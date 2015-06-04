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

    def self.from_contents(contents)
      doc = Nokogiri::XML(contents)
      if doc.errors.empty?
        doc.root.add_namespace_definition('fhir', 'http://hl7.org/fhir')
        doc.root.add_namespace_definition('xhtml', 'http://www.w3.org/1999/xhtml')
        "FHIR::#{doc.at_xpath('/*').name}".constantize.from_xml(contents)
      else
        "FHIR::#{JSON.parse(contents)['resourceType']}".constantize.from_fhir_json(contents)
      end
    end

    class ResourceMetaComponent
      include Mongoid::Document
      include FHIR::Element
      include FHIR::Formats::Utilities
      field :versionId, type: String
      field :lastUpdated, type: String
      validates :lastUpdated, :allow_nil => true, :format => { with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))))\Z/ }
      field :profile, type: Array # Array of Strings
      embeds_many :security, class_name:'FHIR::Coding'
      embeds_many :tag, class_name:'FHIR::Coding'
    end
  end
end
