module FHIR
  class Profile

    @@base_profiles = nil

    def self.load_base_profiles
      if @@base_profiles.nil?
        filename = File.join(File.dirname(__FILE__),'profiles-resources.xml')
        xml = File.read(filename)
        @@base_profiles = FHIR::Bundle.from_xml(xml)
      end
    end

    def self.get_base_profile(resource_name)
      return nil if resource_name.nil?
      load_base_profiles

      @@base_profiles.entry.each do |entry|
        if entry.resourceType == 'Profile'
          if !entry.resource.nil? && entry.resource.fhirType == resource_name
            return entry.resource
          end
        end
      end

      nil
    end

    # Checks whether or not "another_profile" is compatible with this profile.
    # If they have conflicting elements, restrictions, bindings, modifying extensions, etc.
    def is_compatible?(another_profile)
      return false if !(another_profile.is_a? FHIR::Profile) || another_profile.fhirType!=fhirType

      raise Exception.new 'is_compatible? is not implemented'
    end

    # Checks whether or not the "resource" is valid according to this profile.
    # resource == object whose class inherits from FHIR::Resource, or XML, or JSON
    # representation == one of ['Resource','XML','JSON']
    def is_valid?(resource,representation='Resource')
      if representation=='Resource'
        return false if !is_fhir_class?(resource.class.to_s) || resource.class.name.demodulize!=fhirType
        is_valid_xml? resource.to_xml
      elsif representation=='XML'
        is_valid_xml? resource
      elsif representation=='JSON'
        is_valid_json? resource
      else
        raise Exception.new "is_valid? unhandled representation: #{representation}"
      end
    end

    # Checks whether or not the "xml" is valid according to this profile.
    # xml == the raw xml for a FHIR resource
    def is_valid_xml?(xml)
      doc = Nokogiri::XML(xml)
      doc.root.add_namespace_definition('fhir', 'http://hl7.org/fhir')
      doc.root.add_namespace_definition('xhtml', 'http://www.w3.org/1999/xhtml')
      
      resource_type = doc.xpath('/*').first.name
      fhir_class = get_fhir_class_from_resource_type(resource_type)
      return false if fhir_class.nil? or resource_type!=fhirType

      # Examine each element defined in the profile
      snapshot.element.each do |element|
        path = element.path
        is_attribute = element.representation.include? 'xmlAttr'

        if is_attribute
          path = path.sub(/(.*)(\.)(.*)/, '\1/@\3') 
        end
        path = path.gsub(resource_type,"xmlns:#{resource_type}").gsub('.','/xmlns:')
        nodes = doc.xpath(path)

        # Check the cardinality
        min = element.min
        max = 
          if element.max == '*'
            Float::INFINITY
          else 
            element.max.to_i
          end
        return false if (nodes.size < min) && (nodes.size > max)

        # Check the datatype for each node, only if the element has one declared
        if element.fhirType.size > 0
          nodes.each do |node|
            matching_type = 0
            if is_attribute
              value = node.value
            else
              value = node['value']
            end
            # the element is valid, if it matches at least one of the datatypes
            element.fhirType.each do |type|
              data_type_code = type.code
              matching_type+=1 if is_data_type?(data_type_code,value,'XML')
            end
            binding.pry if matching_type==0
            return false if matching_type==0
          end
        end

        # Check the binding
      end

      true
    end

    # Checks whether or not the "json" is valid according to this profile.
    # json == the raw json for a FHIR resource
    def is_valid_json?(json)
      if json.is_a? String
        begin
          json = JSON.parse(json)
        rescue Exception => e
          $LOG.error "Failed to parse JSON: #{e.message} %n #{h} %n #{e.backtrace.join("\n")}"
          return false
        end
      end
      
      resource_type = json['resourceType']
      fhir_class = get_fhir_class_from_resource_type(resource_type)
      return false if fhir_class.nil? or resource_type!=fhirType

      snapshot.element.each do |element|
        path = element.path
        if element.representation.include? 'xmlAttr'
          path = path.sub(/(.*)(\.)(.*)/, '\1[@\3') + ']'
        end
        path = path.gsub(resource_type,"xmlns:#{resource_type}").gsub('.','/xmlns:')
        nodes = get_json_nodes(json,path)

        # Check the cardinality
        min = element.min
        max = 
          if element.max == '*'
            Float::INFINITY
          else 
            element.max.to_i
          end
        return false if (nodes.size < min) && (nodes.size > max)

      end

      # TODO check elements
      # -   cardinality (min,max)
      # -   type (id,Identifier,instant,uri,code,Coding,[a resource type])
      # -   binding

      raise Exception.new 'is_valid_json? is not implemented'
    end

    def get_json_nodes(json,xpath)
      []
    end

    # data_type_code == a FHIR DataType code (see http://hl7.org/implement/standards/FHIR-Develop/data-types.html)
    # value == the representation of the value
    # representation == one of ['Resource','XML','JSON']
    def is_data_type?(data_type_code,value,representation='Resource')
      
      # Address,Age,Attachment,BackboneElement,CodeableConcept,Coding,ContactPoint,Count,
      # Distance,Duration,Element,ElementDefinition,Extension,HumanName,Identifier,Money,
      # Narrative,Period,Quantity,Range,Ratio,Reference,SampledData,Timing,base64Binary,
      # boolean,code,date,dateTime,decimal,id,instant,integer,oid,string,time,uri,uuid
      
      # FHIR models cover the following data types:
      # Address,Attachment,CodeableConcept,Coding,ContactPoint,
      # ElementDefinition,Extension,HumanName,Identifier,
      # Narrative,Period,Quantity,Range,Ratio,Reference,SampledData,Timing
      if is_fhir_class? "FHIR::#{data_type_code}"
        profile = get_base_profile(data_type_code)
        if !profile.nil?
          return profile.is_valid?(value,representation)
        else
          return false
        end
      end

      # Remaining data types:
      # BackboneElement,Count,
      # Distance,Duration,Element,Money,
      # base64Binary,
      # boolean,code,date,dateTime,decimal,id,instant,integer,oid,string,time,uri,uuid
      return case data_type_code.downcase
      when 'boolean'
        value==true || value==false || value.downcase=='true' || value.downcase=='false'
      when 'code'
        value.is_a?(String) && value.size>=1 && value.size==value.rstrip.size
      when 'string'
        value.is_a?(String)
      when 'base64binary'
        regex = /[^0-9\+\/\=A-Za-z\r\n ]/ 
        value.is_a?(String) && (regex =~ value).nil?
      when 'id'
        regex = /[^\d\w\-\.]/
        value.is_a?(String) && value.size<=36 && (regex =~ value).nil?
      when 'uri'
        is_valid_uri = false
        begin
          is_valid_uri = !URI.parse(value).nil?
        rescue Exception
          is_valid_uri = false
        end
        is_valid_uri
      else
        binding.pry
        raise Exception.new "is_data_type? unhandled DataType: #{data_type_code}"
      end
    end

  end
end

