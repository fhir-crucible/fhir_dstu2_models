require 'bigdecimal'
module FHIR
  module DSTU2
    module Hashable
      def to_hash
        hash = {}
        self.class::METADATA.each do |key, value|
          local_name = key
          local_name = value['local_name'] if value['local_name']
          hash[key] = instance_variable_get("@#{local_name}")
          if hash[key].respond_to?(:to_hash)
            hash[key] = hash[key].to_hash
          elsif hash[key].is_a? Array
            hash[key] = Array.new(hash[key]) # copy the array
            hash[key].each_with_index do |item, index|
              hash[key][index] = item.to_hash if item.respond_to?(:to_hash)
            end
          end
        end
        hash.keep_if do |_key, value|
          !value.nil? && ((value.is_a?(Hash) && !value.empty?) ||
                            (value.is_a?(Array) && !value.empty?) ||
                            (!value.is_a?(Hash) && !value.is_a?(Array))
                         )
        end
        hash['resourceType'] = resourceType if respond_to?(:resourceType)
        hash
      end

      def from_hash(hash)
        # clear the existing variables
        self.class::METADATA.each do |key, value|
          local_name = key
          local_name = value['local_name'] if value['local_name']
          instance_variable_set("@#{local_name}", nil)
        end
        # set the variables to the hash values
        hash.each do |key, value|
          key = key.to_s
          meta = self.class::METADATA[key]
          next if meta.nil?
          local_name = key
          local_name = meta['local_name'] if meta['local_name']
          begin
            instance_variable_set("@#{local_name}", value)
          rescue StandardError
            # TODO: this appears to be a dead code branch
            nil
          end
          # inflate the value if it isn't a primitive
          klass = FHIR::DSTU2::PRIMITIVES.key?(meta['type']) ? nil : FHIR::DSTU2.const_get(meta['type'])
          if !klass.nil? && !value.nil?
            # handle array of objects
            if value.is_a?(Array)
              value = value.map do |child|
                obj = child
                unless [FHIR::DSTU2::RESOURCES, FHIR::DSTU2::TYPES].flatten.include? child.class.name.gsub('FHIR::DSTU2::', '')
                  obj = make_child(child, klass)
                end
                obj
              end
            else # handle single object
              value = make_child(value, klass)
              # if there is only one of these, but cardinality allows more, we need to wrap it in an array.
              value = [value] if value && (meta['max'] > 1)
            end
            instance_variable_set("@#{local_name}", value)
          elsif !FHIR::DSTU2::PRIMITIVES.include?(meta['type']) && meta['type'] != 'xhtml'
            FHIR::DSTU2.logger.error("Unhandled and unrecognized class/type: #{meta['type']}")
          elsif value.is_a?(Array)
            # array of primitives
            value = value.map { |child| convert_primitive(child, meta) }
            instance_variable_set("@#{local_name}", value)
          else
            # single primitive
            value = convert_primitive(value, meta)
            # if there is only one of these, but cardinality allows more, we need to wrap it in an array.
            value = [value] if value && (meta['max'] > 1)
            instance_variable_set("@#{local_name}", value)
          end # !klass && !nil?
        end # hash loop
        self
      end

      def make_child(child, klass)
        if child['resourceType'] && !klass::METADATA['resourceType']
          klass = begin
            FHIR::DSTU2.const_get(child['resourceType'])
          rescue StandardError => e
            # TODO: this appears to be a dead code branch
            FHIR::DSTU2.logger.error("Unable to identify embedded class #{child['resourceType']}\n#{e.message}\n#{e.backtrace}")
            nil
          end
        end
        begin
          obj = klass.new(child)
        rescue StandardError => e
          # TODO: this appears to be a dead code branch
          FHIR::DSTU2.logger.error("Unable to inflate embedded class #{klass}\n#{e.message}\n#{e.backtrace}")
        end
        obj
      end

      def convert_primitive(value, meta)
        return value unless value.is_a?(String)

        rval = value
        if meta['type'] == 'boolean'
          rval = value.strip == 'true'
        elsif FHIR::DSTU2::PRIMITIVES.include?(meta['type'])
          primitive_meta = FHIR::DSTU2::PRIMITIVES[meta['type']]
          if primitive_meta['type'] == 'number'
            rval = BigDecimal(value.to_s)
            rval = rval.frac.zero? ? rval.to_i : rval.to_f
          end # primitive is number
        end # boolean else
        rval
      end

      private :make_child, :convert_primitive
    end
  end
end
