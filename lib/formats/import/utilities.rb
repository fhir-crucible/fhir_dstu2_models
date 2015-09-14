module FHIR
  module Deserializer
    module Utilities
      def set_model_data(model, typeName, value)
        begin
          model[typeName] = value if value;
        rescue Exception => e
          $LOG.error "Failed to set model data: #{model.class}, #{typeName}, #{value}: #{e.message}" 
        end
      end
      def from_xml(xml_contents)
        doc = Nokogiri::XML(xml_contents)
        doc.root.add_namespace_definition('fhir', 'http://hl7.org/fhir')
        doc.root.add_namespace_definition('xhtml', 'http://www.w3.org/1999/xhtml')
        entry = doc.at_xpath("./fhir:#{self.name.demodulize}")
        self.parse_xml_entry(entry)
      end

      # parse elements from the base element
      # xml id
      def parse_element_data(model, entry)
        model.xmlId = entry.at_xpath('./fhir:id/@value').try(:value) || entry.at_xpath('@id').try(:value)
        entry.xpath('./fhir:extension').each do |extension_entry|
          model.extension ||= []
          model.extension << FHIR::Extension.parse_xml_entry(extension_entry)
        end

        entry.xpath('./fhir:modifierExtension').each do |extension_entry|
          model.modifierExtension ||= []
          model.modifierExtension << FHIR::Extension.parse_xml_entry(extension_entry)
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
        set_model_data(model, 'lastUpdated', entry.at_xpath('./fhir:lastUpdated/@value').try(:value))
        set_model_data(model, 'profile', entry.xpath('./fhir:profile/@value').map {|e| e.value })
        set_model_data(model, 'security', entry.xpath('./fhir:security').map {|e| FHIR::Coding.parse_xml_entry(e)})
        set_model_data(model, 'tag', entry.xpath('./fhir:tag').map {|e| FHIR::Coding.parse_xml_entry(e)})
        model
      end

      def parse_primitive_field(model,entry,xmlField,modelField,multipleCardinality=false)
        return nil unless entry && xmlField && modelField

        selector = "./fhir:#{xmlField}"
        extension_selector = "./fhir:extension"

        if multipleCardinality
          data = []
          extensions = []
          entry.xpath(selector).each do |e|
            data << e.at_xpath('@value').try(:value)
            extension = e.at_xpath(extension_selector)
            if extension
              extensions << FHIR::Extension.parse_xml_entry(extension)
            else
              extensions << nil
            end
          end
          set_model_data(model,modelField,data)
          if extensions.select{|x|!x.nil?}.any?
            pext = FHIR::PrimitiveExtension.new
            pext['path'] = "_#{xmlField}"
            pext['extension'] = extensions
            model['primitiveExtension'] ||= []
            model['primitiveExtension'] << pext
          end
        else
          element = entry.at_xpath(selector)
          data = element.at_xpath('@value').try(:value) if element
          set_model_data(model,modelField,data)
          extension = FHIR::Extension.parse_xml_entry( element.at_xpath(extension_selector) ) if element
          if extension
            pext = FHIR::PrimitiveExtension.new
            pext['path'] = "_#{xmlField}"
            pext['extension'] = [ extension ]
            model['primitiveExtension'] ||= []
            model['primitiveExtension'] << pext 
          end
        end
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

          if fixed[0]=='_'
            r = Regexp.new "^#{fixed[1..-1]}="
            s = objClass.instance_methods.grep r
            if !s.empty?
              # this should be a hash holding with one property 'extension'
              # which contains an array of extensions
              begin
                pext = FHIR::PrimitiveExtension.new
                pext['path'] = fixed
                if value.is_a? Hash
                  pext['extension'] = [ decodeExtension( value['extension'].first, depth+1 ) ] if value['extension'].try(:first)
                elsif value.is_a? Array
                  pext['extension'] = value.map do | extension |
                    ext = nil
                    ext = decodeExtension( extension['extension'].first, depth+1 ) if !extension.nil?
                    ext
                  end
                end
                if pext['extension']
                  obj['primitiveExtension'] = [] if obj['primitiveExtension'].nil?
                 obj['primitiveExtension'] << pext
                end
              rescue Exception => e
                # binding.pry
              end
            end
            next
          end

          regex = Regexp.new "^#{fixed}="
          setter = objClass.instance_methods.grep regex
          if setter.empty?
            # AnyType check, looking for a method of the format 'prefix=' where our
            # current fixed/key is something like prefixDecimal (e.g. prefix[x] of AnyType)
            begin
              prefixes = objClass::ANY_TYPES.select{|x| fixed.starts_with?(x)}
              prefixes.each do |prefix|
                regex = Regexp.new "^#{prefix}="
                temp = objClass.instance_methods.grep(regex) 
                if !temp.empty?
                  datatype = fixed.gsub(prefix,'')
                  obj[prefix] = FHIR::AnyType.new(datatype,value)
                end
              end
            rescue Exception => e
              # this class does not have any attributes with type=='*'
            end
          end

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
                      child = nil
                      if metadata.class_name=='FHIR::Extension'
                        child = decodeExtension(item,depth+1)
                      else
                        item['resourceType'] = metadata.class_name
                        child = decodeHash(item,depth+1)
                      end
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
            elsif value.is_a?(String) || value.is_a?(TrueClass) || value.is_a?(FalseClass) || value.is_a?(Numeric)
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

      def decodeExtension(item,depth)
        child = FHIR::Extension.new
        begin
          child.url = item['url']
        rescue Exception => e
          puts e.message
          # binding.pry
        end
        item.keys.each do |ekey|
          if ekey.starts_with? 'value'
            d = ekey[5..-1]
            if item[ekey].is_a? Hash
              item[ekey]['resourceType'] = ekey[5..-1]
              v = decodeHash(item[ekey],depth+1)
            else
              v = item[ekey]
            end
            child.value = FHIR::AnyType.new(d,v)
          elsif ekey == 'extension'
            child.extension = [] if child.extension.nil?
            item[ekey].each do |x|
              child.extension << decodeExtension(x,depth+1)
            end
          elsif ekey == 'modifierExtension'
            child.modifierExtension = [] if child.modifierExtension.nil?
            item[ekey].each do |x|
              child.modifierExtension << decodeExtension(x,depth+1)
            end  
          end
        end
        child
      end

    end
  end
end
