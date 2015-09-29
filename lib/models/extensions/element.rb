# see mongoid model for inclusion
module FHIR
  module Element
    # include elements from the core base
    # xml id
    def self.included(base)
      base.send(:field, :xmlId, type: String)
      base.send(:embeds_many, :extension, class_name:'FHIR::Extension', cyclic: true)
      base.send(:embeds_many, :modifierExtension, class_name:'FHIR::Extension', cyclic: true)
      base.send(:embeds_many, :primitiveExtension, class_name: 'FHIR::PrimitiveExtension', cyclic: true)
    end

    def has_primitive_extension?(field,index=0)
      pe = primitiveExtension.select{|pe|pe.path=="_#{field}"}.try(:first)
      has_in_hash = !pe.nil? && !pe['extension'].nil? && !pe['extension'][index].nil?
      has_as_attr = !pe.nil? && !pe.read_attribute(:extension).nil? && !pe.read_attribute(:extension)[index].nil?
      (has_in_hash || has_as_attr)
    end

    def get_primitive_extension(field,index=0)
      pe = primitiveExtension.select{|pe|pe.path=="_#{field}"}.try(:first)
      if pe && pe['extension'] && pe['extension'][index]
        pe = pe['extension'][index] 
      elsif pe && pe.read_attribute(:extension) && pe.read_attribute(:extension)[index]
        pe = pe.read_attribute(:extension)[index] 
      end
      pe
    end

  end
end
