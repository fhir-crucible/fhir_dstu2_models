module FHIR
  module Deserializer
    module Utilities
      def set_model_data(model, typeName, value)
        model[typeName] = value if value;
      end
      def from_xml(xml_contents)
        doc = Nokogiri::XML(xml_contents)
        doc.root.add_namespace_definition('fhir', 'http://hl7.org/fhir')
        doc.root.add_namespace_definition('xhtml', 'http://www.w3.org/1999/xhtml')
        entry = doc.at_xpath("./fhir:#{self.name.demodulize}")
        self.parse_xml_entry(entry)
      end
      
      def parse_date_time(value)
        if value
          value.to_datetime
        end
      end

      # parse elements from the base element
      # xml id
      def parse_element_data(model, entry)
        model.xmlId = entry.at_xpath('./fhir:id/@value').try(:value) || entry.at_xpath('@id').try(:value)
        entry.xpath('./fhir:extension').each do |extension_entry|
          model.extensions ||= []
          model.extensions << FHIR::Extension.parse_xml_entry(extension_entry)
        end

        entry.xpath('./fhir:modifierExtension').each do |extension_entry|
          model.modifierExtensions ||= []
          model.modifierExtensions << FHIR::Extension.parse_xml_entry(extension_entry)
        end

      end

      # parse elements from the base resource
      # narrative
      # contained array
      def parse_resource_data(model, entry)
        set_model_data(model, 'text', FHIR::Narrative.parse_xml_entry(entry.at_xpath('./fhir:text')))

        entry.xpath('./fhir:contained/*').each do |contained_entry|
          model.contained ||= []
          if is_fhir_class?("FHIR::#{contained_entry.name}")
            model.contained << "FHIR::#{contained_entry.name}".constantize.parse_xml_entry(contained_entry)
          end
        end

        set_model_data(model, 'meta', parse_resource_metadata(entry.at_xpath('./fhir:meta')))
        set_model_data(model, 'implicitRules', entry.at_xpath('./fhir:implicitRules/@value').try(:value))
        set_model_data(model, 'language', entry.at_xpath('./fhir:language/@value').try(:value))

      end

      def parse_resource_metadata(entry) 
          return nil unless entry
          model = FHIR::Resource::ResourceMetaComponent.new
          self.parse_element_data(model, entry)
          set_model_data(model, 'versionId', entry.at_xpath('./fhir:versionId/@value').try(:value))
          set_model_data(model, 'lastUpdated', parse_date_time(entry.at_xpath('./fhir:lastUpdated/@value').try(:value)))
          set_model_data(model, 'profile', entry.xpath('./fhir:profile/@value').map {|e| e.value })
          set_model_data(model, 'security', entry.xpath('./fhir:security').map {|e| FHIR::Coding.parse_xml_entry(e)})
          set_model_data(model, 'tag', entry.xpath('./fhir:tag').map {|e| FHIR::Coding.parse_xml_entry(e)})
          model
      end


      # Deserialize JSON into a single FHIR Resource
      def from_fhir_json(json)
        decodeHash(json,0)
      end
      
      def decodeHash(h,depth)
         # if the input is a String, convert it into a Hash
        if h.is_a? String
          begin
            if h.encoding.names.include? 'UTF-8'
              h.gsub!("\xEF\xBB\xBF".force_encoding('UTF-8'), '') # remove UTF-8 BOM
            end
            h = JSON.parse(h)
          rescue Exception => e
            $LOG.error "Failed to parse JSON hash as resource: #{e.message} %n #{h} %n #{e.backtrace.join("\n")}"
            return nil
          end
        end
        
        objClass = nil
        resourceType = h['resourceType']
        if !resourceType.nil?
          objClass = get_fhir_class_from_resource_type(resourceType)
          # puts ' ' * depth + "This is FHIR resource: #{objClass.to_s}"
        end
        
        if objClass.nil?
          raise "Deserialization failure: Cannot identify FHIR class. No 'resourceType' attribute."
        end
        
        obj = objClass.new
        
        h.each do |key,value| 
          fixed = fix_key(key)
          regex = Regexp.new "^#{fixed}="
          setter = objClass.instance_methods.grep regex
          if !setter.empty?
            if value.is_a? Hash
              # puts ' ' * depth + "Key: #{key} is a Hash"
              if !value['resourceType'].nil? and !value['resourceType'].empty?
                # puts ' ' * depth + "Key: #{key} is marked as FHIR resource"
                # This is a FHIR Resource, let's decode it...
                child = decodeHash(value,depth+1)
                set_model_data(obj, fixed, child)
              else
                # puts ' ' * depth + "try to discover what kind of resource this is..."
                metadata = obj.reflect_on_association(fixed)
                if !metadata.class_name.nil?
                  # puts ' ' * depth + "Key: #{key} is a #{metadata.class_name}?"
                  value['resourceType'] = metadata.class_name
                  child = decodeHash(value,depth+1)
                  set_model_data(obj, fixed, child)
                else
                  raise "Could not discover resourceType for '#{fixed}' inside '#{resourceType}'"
                end                
              end
            elsif value.is_a? Array
              # puts ' ' * depth + "Key: #{key} is an Array"
              # This is an array... decode each element...
              value.map! do |item|
                if item.is_a? Hash
                  # puts ' ' * depth + " - Array Item is a Hash"
                  rt = item['resourceType']
                  if !rt.nil?
                    # puts ' ' * depth + " -- Array Item is a FHIR Type"
                    child = decodeHash(item,depth+1)
                    next child 
                  else
                    # try to discover what kind of resource this is...
                    # puts ' ' * depth + " -- try to discover what kind of resource this is..."
                    metadata = obj.reflect_on_association(fixed)
                    if !metadata.class_name.nil?
                      # puts ' ' * depth + " -- Array Item is a #{metadata.class_name}"
                      item['resourceType'] = metadata.class_name
                      child = decodeHash(item,depth+1)
                      next child
                    else
                      raise "Could not discover resourceType for '#{fixed}' inside '#{resourceType}'"
                    end
                  end
                elsif item.is_a? Array
                  raise "Cannot handle array of arrays in deserialization of '#{objClass.to_s}.#{fixed}'"
                else
                  # puts ' ' * depth + " - Array Item is a primitive"
                  next item # .. this is probably a primitive data type
                end              
              end
              set_model_data(obj, fixed, value)
            elsif value.is_a? String or value.is_a? TrueClass or value.is_a? FalseClass
              # puts ' ' * depth + "Key: #{key} is a recognized primitive"
              # do nothing, we can set Strings and booleans directly
              obj[fixed] = value
            else
              # puts ' ' * depth + "I didn't expect this: '#{objClass.to_s}.#{key}' of type '#{value.class}'"
            end
          else
            # We're ignoring this key, there is no associated setter method.
            # TODO raise an exception? log the issue?
            # puts ' ' * depth + "Ignoring '#{key}', no associated setter."
          end
        end
         
        obj
      end # eof decodeHash function

    end
  end
end
