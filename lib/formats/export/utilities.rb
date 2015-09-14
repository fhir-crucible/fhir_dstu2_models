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
          hash['extension'] = h.extension.map {|e|build_extension_hash(e)}
          hash['modifierExtension'] = h.modifierExtension.map {|e|build_extension_hash(e)}
          hash['entry'] = h.entry.map {|e|build_entry_hash(e)} if h.respond_to?(:entry)
          h = hash
        end

        # remove "_id" attributes
        h.delete('_id')

        # hash for renamed attributes
        renamed = {}

        # loop through all the entries in the hash
        h.each do |key,value|
          if ['extension','modifierExtension','entry'].include?(key)
            h.delete(key) if value.empty?
            next
          end

          if key=='primitiveExtension'
            value.each do |pe|
              if pe['extension'].size == 1
                renamed[ pe['path'] ] = { 'extension' => [ build_extension_hash( pe['extension'][0]) ] }
              else
                renamed[ pe['path'] ] = pe['extension'].map do | extension |
                  next extension if extension.nil?
                  { 'extension' => [ build_extension_hash(extension)] }
                end                
              end
            end
            h.delete(key)
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
          # massage AnyTypes
          elsif value.class.name == 'FHIR::AnyType'
            renamed["#{key}#{value.type}"] = value.value
            renamed["#{key}#{value.type}"] = to_num(value.value) if ['integer','positiveint','unsignedint','decimal'].include?(value.type.downcase)
            renamed["#{key}#{value.type}"] = massageHash(value.value,false) if is_fhir_class?(value.value.class.name)
            h.delete(key)
          # massage entries that are FHIR classes...
          elsif is_fhir_class?(value.class.name)
            h[key] = massageHash(value,false)
          else
            #puts "Ignoring '#{key}' inside '#{value.class.name}' of type '#{value.class.name}'"
          end
        end # eof h.each

        h.merge!(renamed) if !renamed.empty?
        
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
        extension_hash['extension'] = e.extension.map {|e|build_extension_hash(e)} if(e.extension && e.extension.any?)
        extension_hash['modifierExtension'] = e.modifierExtension.map {|e|build_extension_hash(e)} if(e.modifierExtension && e.modifierExtension.any?)

        # render template element
        # <%== render :template => 'element', :locals => {model: model, is_resource: false} %>
        if !e.value.nil?
          any = e.value
          if FHIR::AnyType::PRIMITIVES.any?{|x|x.downcase == e.value.type.downcase}
            # <value<%= model.valueType() %> value="<%= model.value()[:value] %>"/>
            x = any.value
            x = any.value[:value] if any.value.is_a? Hash

            if any.type.downcase == 'boolean'
              if x.is_a?(TrueClass) || x.is_a?(FalseClass)
                extension_hash["value#{e.value.type}"] = x
              else
                extension_hash["value#{e.value.type}"] = (x=='true')
              end
            elsif ['integer','positiveint','unsignedint','decimal'].include?(any.type.downcase)
              if x.is_a?(Fixnum) || x.is_a?(Float)
                extension_hash["value#{e.value.type}"] = x
              else
                extension_hash["value#{e.value.type}"] = to_num(x)
              end
            else
              extension_hash["value#{e.value.type}"] = x
            end
          elsif FHIR::AnyType::DATE_TIMES.any?{|x|x.downcase == e.value.type.downcase}
            # <value<%= model.valueType() %> value="<%= model.value()[:value] %>"/>
            if any.value.is_a? Hash
              extension_hash["value#{e.value.type}"] = any.value[:value]
            else
              extension_hash["value#{e.value.type}"] = any.value
            end
          else
            # model.value()[:value].to_xml(is_root: false, name: "value#{model.valueType()}")%>
            if any.value.methods.include? :to_fhir_json
              contained = JSON.parse(any.value.to_fhir_json)
              contained.delete('resourceType')
              extension_hash["value#{any.type}"] = contained
            elsif any.value[:value].methods.include? :to_fhir_json
              contained = JSON.parse(any.value[:value].to_fhir_json)
              contained.delete('resourceType')              
              extension_hash["value#{any.type}"] = contained
            end
          end
        end
        extension_hash
      end

      # Convert string to Fixnum or Float as appropriate
      def to_num(v)
        ((float = Float(v)) && (float % 1.0 == 0) ? float.to_i : float) rescue v
      end

      def build_entry_hash(e)
        entry_hash = massageHash(e,true)
        resourceType = entry_hash['resourceType']
        entry_hash.delete('resourceType')
        if e.methods.include?(:resource) && e.resource.methods.include?(:to_fhir_json)
          entry_hash['resource'] = JSON.parse(e.resource.to_fhir_json)
        elsif e[:resource].methods.include? :to_fhir_json
          entry_hash['resource'] = JSON.parse(e[:resource].to_fhir_json)
        end
        entry_hash
      end
      
    end
  end
end
