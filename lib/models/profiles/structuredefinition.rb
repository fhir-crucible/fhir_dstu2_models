module FHIR
  class StructureDefinition

    attr_accessor :errors
    attr_accessor :warnings

    @@base_definitions = nil
    @@other_definitions = nil
    @@type_definitions = nil

    def self.load_definitions
      if @@base_definitions.nil?
        filename = File.join(File.dirname(__FILE__),'profiles-resources.xml')
        xml = File.read(filename)
        @@base_definitions = FHIR::Bundle.from_xml(xml)
      end
      if @@other_definitions.nil?
        filename = File.join(File.dirname(__FILE__),'profiles-others.xml')
        xml = File.read(filename)
        @@other_definitions = FHIR::Bundle.from_xml(xml)
      end
      if @@type_definitions.nil?
        filename = File.join(File.dirname(__FILE__),'profiles-types.xml')
        xml = File.read(filename)
        @@type_definitions = FHIR::Bundle.from_xml(xml)
      end
    end

    def self.get_base_definition(resource_name)
      return nil if resource_name.nil?
      load_definitions

      @@base_definitions.entry.each do |entry|
        if entry.resourceType == 'StructureDefinition'
          if !entry.resource.nil? && (entry.resource.fhirType == resource_name || entry.resource.name == resource_name)
            return entry.resource
          end
        end
      end

      nil
    end

    def self.get_other_definition(definition_name)
      return nil if definition_name.nil?
      load_definitions

      @@other_definitions.entry.each do |entry|
        if entry.resourceType == 'StructureDefinition'
          if !entry.resource.nil? && (entry.resource.xmlId == definition_name || entry.resource.name == definition_name || entry.resource.url == definition_name)
            return entry.resource
          end
        end
      end

      nil
    end

    def self.get_type_definition(type_name)
      return nil if type_name.nil?
      load_definitions

      @@type_definitions.entry.each do |entry|
        if entry.resourceType == 'StructureDefinition'
          if !entry.resource.nil? && (entry.resource.fhirType == type_name || entry.resource.name == type_name)
            return entry.resource
          end
        end
      end

      nil
    end

    # Checks whether or not "another_definition" is compatible with this definition.
    # If they have conflicting elements, restrictions, bindings, modifying extensions, etc.
    def is_compatible?(another_definition)
      return false if !(another_definition.is_a? FHIR::StructureDefinition) || another_definition.fhirType!=fhirType
      # TODO
      raise Exception.new 'is_compatible? is not implemented'
    end

    # Checks whether or not the "resource" is valid according to this definition.
    # resource == object whose class inherits from FHIR::Resource, or XML, or JSON
    # representation == one of ['Resource','XML','JSON']
    def is_valid?(resource,representation='Resource')
      @errors = []
      @warnings = []
      if representation.downcase=='resource'
        if !is_fhir_class?(resource.class.to_s) || resource.class.name.demodulize!=fhirType
          @errors << "Not a FHIR Resource: #{resource.class.to_s}"
          return false
        end
        is_valid_xml? resource.to_xml
      elsif representation.downcase=='xml'
        is_valid_xml? resource
      elsif representation.downcase=='json'
        is_valid_json? resource
      else
        raise Exception.new "is_valid? unhandled representation: #{representation}"
      end
    end

    # Checks whether or not the "xml" is valid according to this definition.
    # xml == the raw xml for a FHIR resource
    def is_valid_xml?(xml)
      doc = Nokogiri::XML(xml)
      if doc.root.nil?
        @errors << "Not valid xml."
        return false
      end
      doc.root.add_namespace_definition('fhir', 'http://hl7.org/fhir')
      doc.root.add_namespace_definition('xhtml', 'http://www.w3.org/1999/xhtml')
      
      resource_type = doc.xpath('/*').first.name

      # Examine each element defined in the definition
      snapshot.element.each do |element|
        path = element.path
        is_attribute = element.representation.include? 'xmlAttr'

        if is_attribute
          path = path.sub(/(.*)(\.)(.*)/, '\1/@\3') 
        end
        if path.end_with?('[x]')
          path = path.gsub(name,"#{resource_type}").gsub('.','/')
          path = path.sub(/(.*)(\/)(fhir:)(.*)(\[x\])/,'\1\2*[starts-with(name(),\'\4\')]')
        else
          path = path.gsub(name,"fhir:#{resource_type}").gsub('.','/fhir:')
        end
        nodes = doc.xpath(path)
        nodes = doc.xpath(path.gsub('fhir:','')) if nodes.nil? || nodes.size==0

        # Check the cardinality
        min = element.min
        max = 
          if element.max == '*'
            Float::INFINITY
          else 
            element.max.to_i
          end
        if (nodes.size < min) && (nodes.size > max)
          @errors << "#{element.path} failed cardinality test (#{min}..#{max}) -- found #{nodes.size}"
        end

        # Check the datatype for each node, only if the element has one declared
        if element.fhirType.size > 0
          nodes.each do |node|
            matching_type = 0
            if is_attribute
              value = node.value
            else
              value = node['value']
            end
            value = node.to_xml if value.nil? # probably an embedded resource like Narrative

            # the element is valid, if it matches at least one of the datatypes
            temp_messages = []
            element.fhirType.each do |type|
              data_type_code = type.code
              if is_data_type?(data_type_code,value,'XML')
                matching_type+=1 
                if data_type_code == 'code' # then check the binding
                  if(!element.binding.nil?)
                    matching_type+=check_binding(element,value)
                  end
                elsif data_type_code=='CodeableConcept' && element.patternType=='CodeableConcept' && !element.pattern.nil?
                  # TODO check that the CodeableConcept matches the defined pattern
                  binding.pry
                elsif data_type_code=='String' && !element.maxLength.nil? && (value.size>element.maxLength)
                  @errors << "#{element.path} exceed maximum length of #{element.maxLength}: #{value}"
                end
              else
                temp_messages << "#{element.path} is not a valid #{data_type_code}: '#{value}'"
              end
            end
            if matching_type<=0
              @errors += temp_messages
              @errors << "#{element.path} did not match one of the valid data types: #{element.fhirType.map{|e|e.code}.to_s}"
            else
              @warnings += temp_messages
            end  
            if !element.fixed.nil? && element!=value
              @errors << "#{element.path} value of '#{value}' did not match fixed value: #{element.fixed}"
            end                     
          end
        end

        # check 'constraint.xpath' constraints
        if !element.constraint.empty?
          element.constraint.each do |constraint|
            nodes.each do |node|
              begin
                result = node.xpath(constraint.xpath)
                if !result
                  if constraint.severity=='error'
                    @errors << "#{element.path}: failed #{name} invariant rule #{constraint.key}: #{constraint.human}"
                  else
                    @warnings << "#{element.path}: failed #{name} invariant rule #{constraint.key}: #{constraint.human}"
                  end
                end
              rescue Exception => exp
                @warnings << "#{element.path}: invalid XPath 1.0 expression for #{name} invariant rule #{constraint.key}: #{constraint.human}"
              end
            end
          end
        end

      end

      @errors.size==0
    end

    # Checks whether or not the "json" is valid according to this definition.
    # json == the raw json for a FHIR resource
    def is_valid_json?(json)
      if json.is_a? String
        begin
          json = JSON.parse(json)
        rescue Exception => e
          @errors << "Failed to parse JSON: #{e.message} %n #{h} %n #{e.backtrace.join("\n")}"
          return false
        end
      end
      
      resource_type = json['resourceType']
      baseType = snapshot.element[0].path
      # if !resource_type.nil?
      #   fhir_class = get_fhir_class_from_resource_type(resource_type)
      #   binding.pry
      #   if fhir_class.nil? or resource_type!=baseType
      #     @errors << "Invalid resourceType '#{resource_type}' or mismatch with '#{baseType}'"
      #     return false
      #   end
      # end

      snapshot.element.each do |element|
        path = element.path
        path = path[(baseType.size+1)..-1] if path.start_with? baseType
        nodes = get_json_nodes(json,path)

        # Check the cardinality
        min = element.min
        max = 
          if element.max == '*'
            Float::INFINITY
          else 
            element.max.to_i
          end
        if (nodes.size < min) && (nodes.size > max)
          @errors << "#{element.path} failed cardinality test (#{min}..#{max}) -- found #{nodes.size}"
        end

        # Check the datatype for each node, only if the element has one declared, and it isn't the root element
        if element.fhirType.size > 0 && element.path!=xmlId
          nodes.each do |value|
            matching_type = 0

            # the element is valid, if it matches at least one of the datatypes
            temp_messages = []
            element.fhirType.each do |type|
              data_type_code = type.code
              if is_data_type?(data_type_code,value,'JSON')
                matching_type+=1 
                if data_type_code == 'code' # then check the binding
                  if(!element.binding.nil?)
                    matching_type+=check_binding(element,value)
                  end
                elsif data_type_code=='CodeableConcept' && element.patternType=='CodeableConcept' && !element.pattern.nil?
                  # TODO check that the CodeableConcept matches the defined pattern
                  binding.pry
                elsif data_type_code=='String' && !element.maxLength.nil? && (value.size>element.maxLength)
                  @errors << "#{element.path} exceed maximum length of #{element.maxLength}: #{value}"
                end
              else
                temp_messages << "#{element.path} is not a valid #{data_type_code}: '#{value}'"
              end
            end
            if matching_type<=0
              @errors += temp_messages
              @errors << "#{element.path} did not match one of the valid data types: #{element.fhirType.map{|e|e.code}.to_s}"
            else
              @warnings += temp_messages
            end
            if !element.fixed.nil? && element!=value
              @errors << "#{element.path} value of '#{value}' did not match fixed value: #{element.fixed}"
            end
          end
       end

        # check 'constraint.xpath' constraints
        if !element.constraint.empty?
          element.constraint.each do |constraint|
            @warnings << "#{element.path}: unable to evaluate XPath expression against JSON for #{name} invariant rule #{constraint.key}: #{constraint.human}"
          end
        end

      end

      @errors.size==0
    end

    def get_json_nodes(json,path)
      results = []
      return [json] if path.nil?
      steps = path.split('.')
      steps.each.with_index do |step,index|
        if json.is_a? Hash
          json = json[step]
        elsif json.is_a? Array
          json.each do |e|
            results << get_json_nodes(e,steps[index..-1].join('.'))
            return results.flatten!
          end
        else 
          # this thing doesn't exist
          return results
        end
        return results if json.nil?
      end

      if !json.is_a? Array
        results << json
      else
        results = json
      end
      results
    end

    # data_type_code == a FHIR DataType code (see http://hl7.org/fhir/2015May/datatypes.html)
    # value == the representation of the value
    # representation == one of ['Resource','XML','JSON']
    def is_data_type?(data_type_code,value,representation='Resource')      
      # FHIR models covers any base Resources
      if is_fhir_class? "FHIR::#{data_type_code}"
        definition = FHIR::StructureDefinition.get_base_definition(data_type_code)
        if !definition.nil?
          retVal = definition.is_valid?(value,representation)
          if !retVal
            @errors += definition.errors 
            @warnings += definition.warnings
          end
          return retVal
        end
      end

      # Remaining data types: handle special cases before checking type StructureDefinitions
      return case data_type_code.downcase
      when 'domainresource'
        true # we don't have to verify domain resource, because it will be included in the snapshot
      when 'boolean'
        value==true || value==false || value.downcase=='true' || value.downcase=='false'
      when 'code'
        value.is_a?(String) && value.size>=1 && value.size==value.rstrip.size
      when 'string'
        value.is_a?(String)
      when 'xhtml'
        fragment = Nokogiri::HTML::DocumentFragment.parse(value)
        value.is_a?(String) && fragment.errors.size == 0
      when 'base64binary'
        regex = /[^0-9\+\/\=A-Za-z\r\n ]/ 
        value.is_a?(String) && (regex =~ value).nil?
      when 'id'
        regex = /[^\d\w\-\.]/
        # the FHIR spec says IDs have a length limit of 36 characters. But it also says that OIDs
        # are valid IDs, and ISO OIDs have no length limitations.
        value.is_a?(String) && (regex =~ value).nil? # && value.size<=36 
      when 'oid'
        regex = /[^(urn:oid:)[\d\.]]/
        value.is_a?(String) && (regex =~ value).nil?       
      when 'uri'
        is_valid_uri = false
        begin
          is_valid_uri = !URI.parse(value).nil?
        rescue Exception
          is_valid_uri = false
        end
        is_valid_uri
      when 'instant'
        regex = /-?[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))))/
        value.is_a?(String) && !(regex =~ value).nil?
      when 'date'
        regex = /-?[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])))/
        value.is_a?(String) && !(regex =~ value).nil?        
      when 'datetime'
        regex = /-?[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?/
        value.is_a?(String) && !(regex =~ value).nil?
      when 'time'
        regex = /([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?/
        value.is_a?(String) && !(regex =~ value).nil?
      when 'integer','unsignedint'
        (!Integer(value).nil? rescue false)
      when 'positiveint'
        (!Integer(value).nil? rescue false) && (Integer(value) >= 0)     
      when 'decimal'
        (!Float(value).nil? rescue false)
      when 'resource'
        if representation.downcase == 'xml'
          doc = Nokogiri::XML(value)
          contained_resources_valid = true
          doc.root.element_children do |element|
            element.add_namespace_definition(nil,'http://hl7.org/fhir')
            contained_resources_valid = contained_resources_valid && is_valid_xml?(element.to_xml)
          end
          contained_resources_valid
        elsif representation.downcase == 'json'
          resource_type = value['resourceType']
          definition = FHIR::StructureDefinition.get_base_definition(resource_type)
          if !definition.nil?
            retVal = definition.is_valid?(value,representation)
            if !retVal
              @errors += definition.errors 
              @warnings += definition.warnings
            end
            retVal
          else
            @errors << "Unable to find base type definition: #{resource_type}"
            false
          end
        else
          raise Exception.new "is_data_type? unhandled 'resource' DataType with 'resource' representation."
        end
      else
        # Eliminate endless loop on Element is an Element
        return true if (data_type_code=='Element' && xmlId=='Element') 

        definition = FHIR::StructureDefinition.get_type_definition(data_type_code)
        definition = FHIR::StructureDefinition.get_base_definition(data_type_code) if definition.nil?
        if !definition.nil?
          retVal = definition.is_valid?(value,representation)
          if !retVal
            @errors += definition.errors 
            @warnings += definition.warnings
          end
          retVal
        else
          @errors << "Unable to find base type definition: #{data_type_code}"
          false
        end
      end
    end

    def check_binding(element,value)
      valueset = FHIR::ValueSet.get_base_valueset(element.binding.name)
      valueset = FHIR::ValueSet.get_base_valueset(element.binding.valueSetUri) if valueset.nil?
      valueset = FHIR::ValueSet.get_base_valueset(element.binding.valueSetReference.reference) if valueset.nil? && !element.binding.valueSetReference.nil?

      matching_type = 0

      if element.binding.name=='MimeType'
        matches = MIME::Types[value]
        if (matches.nil? || matches.size==0) && (value.downcase!='xml' && value.downcase!='json')
          @errors << "#{element.path} has invalid mime-type: '#{value}'"
          matching_type-=1 if element.binding.strength=='required'
        end
      elsif element.binding.name=='Language'
        hasRegion = (!(value =~ /-/).nil?)
        valid = !BCP47::Language.identify(value).nil? && (!hasRegion || !BCP47::Region.identify(value).nil?)
        if !valid
          @errors << "#{element.path} has unrecognized language: '#{value}'"
          matching_type-=1 if element.binding.strength=='required'            
        end
      elsif valueset.nil?
        @errors << "#{element.path} has unknown ValueSet: '#{element.binding.name}'"
        matching_type-=1 if element.binding.strength=='required'
      elsif !valueset.include?(value)
        message = "#{element.path} has invalid code '#{value}' from '#{element.short}'"
        if element.binding.strength=='required'
          @errors << message
          matching_type-=1
        else
          @warnings << message
        end
      end

      matching_type
    end

  private :is_valid_xml?, :is_valid_json?, :get_json_nodes, :is_data_type?, :check_binding

  end
end

