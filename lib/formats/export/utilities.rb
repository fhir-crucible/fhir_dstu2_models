module FHIR
  module Serializer
    module Utilities
      def to_xml(options={})
        FHIR::Export::ModelSerializer.new.serialize(self, options)
      end
            
      #	Export FHIR Resources as FHIR JSON
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
          h = Marshal.load(Marshal.dump(h.attributes))
        end
        
        if h.is_a? Hash
          # remove "_id" attributes
          h.delete("_id")
          # loop through all the entries in the hash
          h.each do |key,value|
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
                  next massageHash(item,false) # .. with a hash representation of an object
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
      
    end
  end
end