module FHIR
  module Formats
    module Utilities

      def is_fhir_class?(classname)
        fhir_classes = Mongoid.models.select {|c| c.name.include? 'FHIR'}
        fhir_classes.map! {|c| c.to_s }
        return fhir_classes.include? classname
      end

      def equals?(other)
        self.attributes.except('_id').keys.each do |key|
          return false unless compare_attribute(self[key], other[key])
        end
        true
      end

      def compare_attribute(left, right)
        if left.respond_to?(:equals?) && right.respond_to?(:equals?)
          left.equals? right
        elsif left.is_a?(Array) && right.is_a?(Array) && (left.length == right.length)
          result = true
          (0...(left.length)).each {|i| result &&= compare_attribute(left[i], right[i])}
          result
        else
          left == right
        end
      end
      
      def get_fhir_class_from_resource_type(resourceType)
        fhir_classes = Mongoid.models.select {|c| c.name.include? 'FHIR' and c.name.include? resourceType }
        fhir_classes = fhir_classes.sort_by { |c| c.to_s.length }
        retClass = nil
        if !fhir_classes.empty?
          retClass = fhir_classes[0]
        end
        retClass
      end
      
      def fix_key(key)
        fixed = key
        keys = {  'type' => 'fhirType',
                  'collection' => 'fhirCollection',
                  'deleted' => 'fhirDeleted',
                  'version' => 'versionNum',
                  'class' => 'fhirClass' }
        keys.merge!(keys.invert)
        if keys.has_key? key
          fixed = keys[key]
        end
        fixed
      end
      
      def fix_all_keys(hash)
        copy = {}
        hash.each {|key,value| copy[fix_key(key)] = value }
        copy
      end
      
    end
  end
end
