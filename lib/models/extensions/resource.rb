# see mongoid model for inclusion
module FHIR
  module Resource
    # include elements from the base resource
    # narrative
    # contained array
    def self.included(base)
      base.send(:embeds_one, :text, class_name:'FHIR::Narrative')
      base.send(:field, :contained, type: Array)
      base.send(:embeds_one, :meta, class_name:'FHIR::Resource::ResourceMetaComponent')
      base.send(:field, :implicitRules, type: String)
      base.send(:field, :language, type: String)
    end

    class ResourceMetaComponent
      include Mongoid::Document
      include FHIR::Element
      include FHIR::Formats::Utilities
      field :versionId, type: String
      field :lastUpdated, type: DateTime
      field :profile, type: Array # Array of Strings
      embeds_many :security, class_name:'FHIR::Coding'
      embeds_many :tag, class_name:'FHIR::Coding'
    end
  end
end
