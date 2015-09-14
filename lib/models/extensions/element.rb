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
      pe = primitiveExtension.select{|pe|pe.path=="_#{field}"}.first
      !pe.nil? && !pe['extension'].nil? && !pe['extension'][index].nil?
    end

    def get_primitive_extension(field,index=0)
      pe = primitiveExtension.select{|pe|pe.path=="_#{field}"}.first
      pe = pe['extension'][index] if pe && pe['extension'] && pe['extension'][index]
    end

  end
end
