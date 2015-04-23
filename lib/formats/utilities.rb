module FHIR
  module Formats
    module Utilities

      def is_fhir_class?(classname)
        fhir_classes = Mongoid.models.select {|c| c.name.include? 'FHIR'}
        fhir_classes.map! {|c| c.to_s }
        return fhir_classes.include? classname
      end

      def equals?(other, exclude=['_id'])
        self.attributes.except(*exclude).keys.each do |key|
          return false unless compare_attribute(self[key], other[key], exclude)
        end
        true
      end

      def mismatch(other, exclude=['_id'])
        misses = []
        self.attributes.except(*exclude).keys.each do |key|
          these = attribute_mismatch(self[key], other[key], exclude)
          if !these || (these.is_a?(Array) && !these.empty?)
            misses << "#{self.class}::#{key}" 
            misses.concat these if these.is_a?(Array)
          end
        end
        misses
      end

      def attribute_mismatch(left, right, exclude=['_id'])
        if left.respond_to?(:mismatch) && right.respond_to?(:mismatch)
          left.mismatch right, exclude
        else
          compare_attribute(left, right, exclude)
        end
      end


      def compare_attribute(left, right, exclude=['_id'])
        if left.respond_to?(:equals?) && right.respond_to?(:equals?)
          left.equals? right, exclude
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
                  'class' => 'fhirClass',
                  'xmlId' => 'id',
                  'id' => 'xmlId',
                  'identity' => 'fhirIdentity',
                  'modifier' => 'fhirModifier' }
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
