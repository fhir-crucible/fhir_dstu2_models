module FHIR
  module Serializer
    module Utilities
      def to_xml(options={})
        FHIR::Export::ModelSerializer.new.serialize(self, options)
      end
            
      # Export FHIR Resources as FHIR JSON
      def to_fhir_json
        h = massageHash(self,true)
        JSON.pretty_unparse(h)
      end
      
      # Massage the Class/Hash:
      #  - Strip out the Mongoid "_id" structures 
      #  - Strip out nil values
      #  - Strip out empty arrays
      #  - Add W3C namespace to <div/> tags
      def massageHash(h,top)
        resourceType = nil
        
        # if this is a FHIR class, convert to a hash
        if is_fhir_class?(h.class.name)
          resourceType = h.class.name.demodulize
          hash = Marshal.load(Marshal.dump(h.attributes))

          # go through the keys, if one is a FHIR::PartialDateTime,
          # then include the iso8601 value and not a hash
          klass = get_fhir_class_from_resource_type(h.class.name)
          klass.fields.each do |key,value|
            if value.type == FHIR::PartialDateTime
              hash[key] = h.send(key)
            end
          end
          hash['extension'] = h.extension.map {|e|build_extension_hash(e)}
          hash['modifierExtension'] = h.modifierExtension.map {|e|build_extension_hash(e)}
          hash['entry'] = h.entry.map {|e|build_entry_hash(e)} if h.respond_to?(:entry)
          h = hash
        end
        
        if h.is_a? Hash
          # remove "_id" attributes
          h.delete("_id")

          # loop through all the entries in the hash
          h.each do |key,value|
            if ['extension','modifierExtension','entry'].include?(key)
              h.delete(key) if value.empty?
              next
            end

            # massage entries that are also hashes...
            if value.is_a? Hash
              h[key] = massageHash(value,false)
            # massage entries that are arrays...
            elsif value.is_a? Array
              # replace each item in the array...
              value.map! do |item|
                if item.is_a? Hash
                  next massageHash(item,false) # .. with a massaged hash
                # serialize FHIR children correctly
                elsif is_fhir_class?(item.class.name)
                  next massageHash(item, (key=='contained') ) # .. with a hash representation of an object
                else
                  next item # .. or with the item itself (probably primitive data type)
                end
              end
              # after massaging the array, remove empty arrays
              if value.empty?
                h.delete(key)
              end
            # remove empty attributes
            elsif value.nil?
              h.delete(key)
            # special handling for partial date times
            elsif value.is_a? FHIR::PartialDateTime
              if key.ends_with? 'Date'
                h[key] = value.to_date.iso8601
              elsif key.ends_with?('Time') && !key.ends_with?('DateTime')
                h[key] = value.to_time.strftime("%T")
              else
                h[key] = value.iso8601 
              end
            # massage entires that are FHIR classes...
            elsif is_fhir_class?(value.class.name)
              h[key] = massageHash(value,false)
            else
              #puts "Ignoring '#{key}' inside '#{value.class.name}' of type '#{value.class.name}'"
            end
            
            # add W3C namespace to <div/> tags
            # if key == 'div'
              # i = (h[key] =~ /^<div>/)
              # j = (h[key] =~ /^<div/)
              # if i==0
                # # replace the <div/> tag w/ one with the namespace
                # h[key] = '<div xmlns="http://www.w3.org/1999/xhtml">' + value[5..value.length]
              # elsif i!=0 and j!=0
                # # there is no div tag at all -- add the full <div/> tag w/ namespace
                # h[key] = '<div xmlns="http://www.w3.org/1999/xhtml">' + value + '</div>'
              # end
            # end
             
          end       
        end
        
        # if this is a FHIR class, add the 'resourceType' attribute
        if top and !resourceType.nil?
          h['resourceType'] = resourceType
        end
        
        fix_all_keys(h)
      end # eof massageHash method
      
      def build_extension_hash(e)
        extension_hash = {}
        extension_hash['id']=e.xmlId if e.xmlId
        extension_hash['url']=e.url if !e.url.nil?
        # render template element
        # <%== render :template => 'element', :locals => {model: model, is_resource: false} %>
        if !e.value().nil?
          if FHIR::AnyType::PRIMITIVES.include? e.valueType().downcase
            # <value<%= model.valueType() %> value="<%= model.value()[:value] %>"/>
            if e.value.is_a? Hash
              extension_hash["value#{e.valueType}"] = e.value[:value]
            else
              extension_hash["value#{e.valueType}"] = e.value
            end
          elsif FHIR::AnyType::DATE_TIMES.include? e.valueType().downcase 
            # <value<%= model.valueType() %> value="<%= model.value()[:value] %>"/>
            if e.value.is_a? Hash
              extension_hash["value#{e.valueType}"] = e.value[:value]
            else
              extension_hash["value#{e.valueType}"] = e.value
            end
          else
            # model.value()[:value].to_xml(is_root: false, name: "value#{model.valueType()}")%>
            if e.value.methods.include? :to_fhir_json
              contained = JSON.parse(e.value.to_fhir_json)
              contained.delete('resourceType')
              extension_hash["value#{e.valueType}"] = contained
            elsif e.value[:value].methods.include? :to_fhir_json
              contained = JSON.parse(e.value[:value].to_fhir_json)
              contained.delete('resourceType')              
              extension_hash["value#{e.valueType}"] = contained
            end
          end
        end
        extension_hash
      end

      def build_entry_hash(e)
        entry_hash = massageHash(e,true)
        resourceType = entry_hash['resourceType']
        entry_hash.delete('resourceType')
        if e.methods.include?(:resouce) && e.resource.methods.include?(:to_fhir_json)
          entry_hash['resource'] = JSON.parse(e.resource.to_fhir_json)
        elsif e[:resource].methods.include? :to_fhir_json
          entry_hash['resource'] = JSON.parse(e[:resource].to_fhir_json)
        end
        entry_hash
      end
      
    end
  end
end