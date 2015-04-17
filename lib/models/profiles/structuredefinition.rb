module FHIR
  class StructureDefinition

    attr_accessor :errors
    attr_accessor :warnings

    @@base_definitions = nil
    @@other_definitions = nil
    @@type_definitions = nil
    @@extension_definitions = nil

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
      if @@extension_definitions.nil?
        filename = File.join(File.dirname(__FILE__),'extension-definitions.xml')
        xml = File.read(filename)
        @@extension_definitions = FHIR::Bundle.from_xml(xml)
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

    def self.get_profiles_for_resource(resource_name)
      results = []
      definition = FHIR::StructureDefinition.get_base_definition(resource_name)
      if !definition.nil?
        @@other_definitions.entry.each do |entry|
          if entry.resourceType == 'StructureDefinition'
            if !entry.resource.nil? && entry.resource.base==definition.url
              results << entry.resource
            end
          end
        end
      end
      results
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

    def self.get_extension_definition(extension_name)
      return nil if extension_name.nil?
      load_definitions
      @@extension_definitions.entry.each do |entry|
        if entry.resourceType == 'StructureDefinition'
          if !entry.resource.nil? && (entry.resource.xmlId == extension_name || entry.resource.url == extension_name)
            return entry.resource
          end
        end
      end
      nil
    end

    # -------------------------------------------------------------------------
    #                            Profile Comparison
    # -------------------------------------------------------------------------

    # Checks whether or not "another_definition" is compatible with this definition.
    # If they have conflicting elements, restrictions, bindings, modifying extensions, etc.
    def is_compatible?(another_definition)
      @errors = []
      @warnings = []

      if !(another_definition.is_a? FHIR::StructureDefinition)
        @errors << "StructureDefinition #{name} is not compatible with #{another_definition.class.name}."
        return false
      elsif another_definition.snapshot.element[0].path!=snapshot.element[0].path
        @errors << "StructureDefinition #{name} profiles #{snapshot.element[0].path} -- StructureDefinition #{another_definition.name} profiles #{another_definition.snapshot.element[0].path}."
        return false
      end

      left_elements = Array.new(snapshot.element)
      right_elements = Array.new(another_definition.snapshot.element)

      left_paths = left_elements.map { |e| e.path }
      right_paths = right_elements.map { |e| e.path }

      # StructureDefinitions don't always include all base attributes (for example, of a ContactPoint)
      # if nothing is modified from the base definition, so we have to add them in if they are missing.
      left_missing = right_paths - left_paths
      left_missing_roots = left_missing.map{|e| e.split('.')[0..-2].join('.') }.uniq
      add_missing_elements(name,left_missing_roots,left_elements)

      right_missing = left_paths - right_paths
      right_missing_roots = right_missing.map{|e| e.split('.')[0..-2].join('.') }.uniq
      add_missing_elements(another_definition.name,right_missing_roots,right_elements)

      # update paths
      left_paths = left_elements.map { |e| e.path }
      right_paths = right_elements.map { |e| e.path }

      # recalculate the missing attributes
      left_missing = right_paths - left_paths
      right_missing = left_paths - right_paths

      # generate warnings for missing fields (ignoring extensions)
      left_missing.each do |e|
        if !e.include? 'extension'
          @warnings << "StructureDefinition #{name} is missing element #{e} from StructureDefinition #{another_definition.name}"
        end
      end
      right_missing.each do |e|
        if !e.include? 'extension'
          @warnings << "StructureDefinition #{another_definition.name} is missing element #{e} from StructureDefinition #{name}"
        end
      end

      left_extensions = []
      right_extensions = []

      # compare elements, starting with the elements in this definition
      left_elements.each do |x|
        if x.path.include? 'extension' 
          # handle extensions separately
          left_extensions << x
        else
          y = get_element_by_path(x.path,right_elements)
          compare_element_definitions(x,y,another_definition)
        end
      end

      # now compare elements defined in the other definition, if we haven't already looked at them
      right_elements.each do |y|
        if y.path.include? 'extension' 
          # handle extensions separately
          right_extensions << y
        elsif left_missing.include? y.path
          x = get_element_by_path(y.path,left_elements)
          compare_element_definitions(x,y,another_definition)
        end
      end      

      # finally, compare the extensions.
      checked_extensions = []
      left_extensions.each do |x|
        y = get_extension(x.name,right_extensions)
        if !y.nil?
          # both profiles share an extension with the same name
          checked_extensions << x.name
          compare_extension_definition(x,y,another_definition)
        end
        y = nil
        y = get_extension(x.fhirType[0].profile,right_extensions)
        if !y.nil? && x.name!=y.name
          # both profiles share the same extension definition but with a different name
          checked_extensions << x.name
          checked_extensions << y.name
          compare_element_definitions(x,y,another_definition)
        end
      end
      right_extensions.each do |y|
        next if checked_extensions.include?(y.name)
        x = get_extension(y.name,left_extensions)
        if !x.nil?
          # both profiles share an extension with the same name
          checked_extensions << y.name
          compare_extension_definition(x,y,another_definition)
        end
        x = nil
        x = get_extension(y.fhirType[0].profile,left_extensions)
        if !x.nil? && x.name!=y.name && !checked_extensions.include?(x.name)
          # both profiles share the same extension definition but with a different name
          checked_extensions << x.name
          checked_extensions << y.name
          compare_element_definitions(x,y,another_definition)
        end
      end
      @errors.flatten!
      @warnings.flatten!

      binding.pry

      @errors.size==0
    end

    def get_element_by_path(path,elements=snapshot.element)
      elements.each do |element|
        return element if element.path==path
      end
      nil
    end

    def get_extension(extension,elements=snapshot.element)
      elements.each do |element|
        if element.path.include?('extension') || element.fhirType.map{|t|t.code}.include?('Extension')
          return element if element.name==extension || element.fhirType.map{|t|t.profile}.include?(extension)
        end
      end
      nil
    end

    #private
    def add_missing_elements(name,missing_roots,elements)
      missing_roots.each do |root|
        next if root.ends_with? "extension"
        elem = get_element_by_path(root,elements)
        if !elem.nil?
          # assume missing elements are from first data type (gross)
          type_def = FHIR::StructureDefinition.get_type_definition(elem.fhirType[0].code)
          type_elements = Array.new(type_def.snapshot.element)
          # _DEEP_ copy
          type_elements.map! do |e| #{|e| FHIR::ElementDefinition.from_fhir_json(e.to_fhir_json) }
            FHIR::ElementDefinition.from_fhir_json(e.to_fhir_json)
          end
          # Fix path names
          type_root = String.new(type_elements[0].path)
          type_elements.each { |e| e.path.gsub!(type_root,root) }
          # finally, add the missing element definitions
          # one by one -- only if they are not already present (i.e. do not override)
          type_elements.each do |x|
            y = get_element_by_path(x.path,elements)
            if y.nil?
              elements << x
            else
              @warnings << "StructureDefinition #{name} already contains #{x.path}"
            end
          end
          # elements.uniq!
        else
          @warnings << "StructureDefinition #{name} missing -- #{root}"
        end
      end
    end

    #private
    def compare_extension_definition(x,y,another_definition)
      x_profiles = x.fhirType.map{|t|t.profile}
      y_profiles = y.fhirType.map{|t|t.profile}
      x_only = x_profiles - y_profiles
      y_only = y_profiles - x_profiles
      shared = x_profiles - x_only

      if !shared.nil? && shared.size==0
        # same name, but different profiles
        # maybe the profiles are the same, just with different URLs... 
        # ... so we have to compare them, if we can.
        @warnings << "#{x.path} (#{x.name}) has different extensions:\n\t#{x_profiles} #{name}\n\t#{y_profiles} #{another_definition.name}"
        x_extension = FHIR::StructureDefinition.get_extension_definition(x.fhirType[0].profile)
        y_extension = FHIR::StructureDefinition.get_extension_definition(y.fhirType[0].profile)
        if !x_extension.nil? && !y_extension.nil?
          x_extension.is_compatible(y_extension)
          @errors << x_extension.errors
          @warnings << x_extension.warnings
        else
          @warnings << "#{x.path} (#{x.name}) could not find extension definitions to compare."
        end
      else
        compare_element_definitions(x,y,another_definition)
      end
    end

    #private
    def compare_element_definitions(x,y,another_definition)
      return if x.nil? || y.nil? || another_definition.nil?

      # check cardinality 
      x_min = x.min || 0
      x_max = (x.max == '*') ? Float::INFINITY : x.max.to_i
      y_min = y.min || 0
      y_max = (y.max == '*') ? Float::INFINITY : y.max.to_i

      if x_min.nil? || x.max.nil? || y_min.nil? || y.max.nil?
        @errors << "#{x.path} unknown cardinality:\n\t#{x_min}..#{x.max} (#{name})\n\t#{y_min}..#{y.max} (#{another_definition.name})"
      elsif (x_min > y_max) || (x_max < y_min)
        @errors << "#{x.path} incompatible cardinality:\n\t#{x_min}..#{x.max} (#{name})\n\t#{y_min}..#{y.max} (#{another_definition.name})"
      elsif (x_min != y_min) || (x_max != y_max)
        @warnings << "#{x.path} inconsistent cardinality:\n\t#{x_min}..#{x.max} (#{name})\n\t#{y_min}..#{y.max} (#{another_definition.name})"
      end

      # check data types
      x_types = x.fhirType.map {|t| t.code }
      y_types = y.fhirType.map {|t| t.code }
      x_only = x_types - y_types
      y_only = y_types - x_types
      shared = x_types - x_only

      if !shared.nil? && shared.size==0 && x.constraint.size > 0 && y.constraint.size > 0
        @errors << "#{x.path} incompatible data types:\n\t#{x_types} (#{name})\n\t#{y_types} (#{another_definition.name})"
      end
      if !x_only.nil? && x_only.size > 0
        @warnings << "#{x.path} allows data types #{x_only} (not allowed by #{another_definition.name})"
      end
      if !y_only.nil? && y_only.size > 0
        @warnings << "#{x.path} allows data types #{y_only} (not allowed by #{name})"
      end

      # check bindings 
      if x.binding.nil? && !y.binding.nil?
        @warnings << "#{x.path} inconsistent binding:\n\tnil (#{name})\n\t#{y.binding.name} (#{another_definition.name})"
      elsif !x.binding.nil? && y.binding.nil?
        @warnings << "#{x.path} inconsistent binding:\n\t#{x.binding.name} (#{name})\n\tnil (#{another_definition.name})"
      elsif !x.binding.nil? && !y.binding.nil?
        x_vs = x.binding.valueSetUri || x.binding.valueSetReference.reference
        y_vs = y.binding.valueSetUri || y.binding.valueSetReference.reference
        if x_vs != y_vs
          if x.binding.strength=='required' || y.binding.strength=='required'
            @errors << "#{x.path} incompatible bindings:\n\t#{x.binding.strength} #{x_vs} (#{name})\n\t#{y.binding.strength} #{y_vs} (#{another_definition.name})"
          else 
            @warnings << "#{x.path} potentially inconsistent bindings:\n\t#{x.binding.strength} #{x_vs} (#{name})\n\t#{y.binding.strength} #{y_vs} (#{another_definition.name})"
          end
        end
      end

      # check default values
      if x.defaultValueType != y.defaultValueType
        @errors << "#{x.path} incompatible default type:\n\t#{x.defaultValueType} (#{name})\n\t#{y.defaultValueType} (#{another_definition.name})"
      end
      if x.defaultValue != y.defaultValue
        @errors << "#{x.path} incompatible default value:\n\t#{x.defaultValue} (#{name})\n\t#{y.defaultValue} (#{another_definition.name})"
      end

      # check meaning when missing
      if x.meaningWhenMissing != y.meaningWhenMissing
        @errors << "#{x.path} inconsistent missing meaning:\n\t#{x.meaningWhenMissing} (#{name})\n\t#{y.meaningWhenMissing} (#{another_definition.name})"
      end        

      # check fixed values
      if x.fixedType != y.fixedType
        @errors << "#{x.path} incompatible fixed type:\n\t#{x.fixedType} (#{name})\n\t#{y.fixedType} (#{another_definition.name})"
      end
      if x.fixed != y.fixed
        @errors << "#{x.path} incompatible fixed value:\n\t#{x.fixed} (#{name})\n\t#{y.fixed} (#{another_definition.name})"
      end

      # check pattern values
      if x.patternType != y.patternType
        @errors << "#{x.path} incompatible pattern type:\n\t#{x.patternType} (#{name})\n\t#{y.patternType} (#{another_definition.name})"
      end
      if x.pattern != y.pattern
        @errors << "#{x.path} incompatible pattern:\n\t#{x.pattern} (#{name})\n\t#{y.pattern} (#{another_definition.name})"
      end

      # maxLength (for Strings)
      if x.maxLength != y.maxLength
        @warnings << "#{x.path} inconsistent maximum length:\n\t#{x.maxLength} (#{name})\n\t#{y.maxLength} (#{another_definition.name})"
      end

      # constraints
      x_constraints = x.constraint.map {|t| t.xpath }
      y_constraints = y.constraint.map {|t| t.xpath }
      x_only = x_constraints - y_constraints
      y_only = y_constraints - x_constraints
      shared = x_constraints - x_only

      if !shared.nil? && shared.size==0 && x.constraint.size > 0 && y.constraint.size > 0
        @errors << "#{x.path} incompatible constraints:\n\t#{x_constraints} (#{name})\n\t#{y_constraints} (#{another_definition.name})"
      end
      if !x_only.nil? && x_only.size > 0
        @errors << "#{x.path} additional constraints:\n\t#{x_constraints} (#{name})"
      end
      if !y_only.nil? && y_only.size > 0
        @errors << "#{x.path} additional constraints:\n\t#{y_constraints} (#{another_definition.name})"
      end

      # mustSupports
      if x.mustSupport != y.mustSupport
        @warnings << "#{x.path} inconsistent 'mustSupport':\n\t#{x.mustSupport || false} (#{name})\n\t#{y.mustSupport || false} (#{another_definition.name})"
      end

      # isModifier
      if x.isModifier != y.isModifier
        @errors << "#{x.path} incompatible 'isModifier':\n\t#{x.isModifier || false} (#{name})\n\t#{y.isModifier || false} (#{another_definition.name})"
      end
    end

    # -------------------------------------------------------------------------
    #                            Profile Validation
    # -------------------------------------------------------------------------

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
        max = (element.max == '*') ? Float::INFINITY : element.max.to_i
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

  private :is_valid_xml?, :is_valid_json?, :get_json_nodes, :is_data_type?, :check_binding, :add_missing_elements, :compare_element_definitions

  end
end

