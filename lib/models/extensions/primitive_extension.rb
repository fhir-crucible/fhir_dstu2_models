# see mongoid model for inclusion
module FHIR
  class PrimitiveExtension
    include Mongoid::Document
    include FHIR::Formats::Utilities

    field :path, type: String
    embeds_many :extension, class_name:'FHIR::Extension'

  end
end
