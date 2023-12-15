module FHIR
  module DSTU2
    class EligibilityRequest < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['identifier']
      METADATA = {
        'id' => { 'type' => 'id', 'path' => 'EligibilityRequest.id', 'min' => 0, 'max' => 1 },
        'meta' => { 'type' => 'Meta', 'path' => 'EligibilityRequest.meta', 'min' => 0, 'max' => 1 },
        'implicitRules' => { 'type' => 'uri', 'path' => 'EligibilityRequest.implicitRules', 'min' => 0, 'max' => 1 },
        'language' => { 'type' => 'code', 'path' => 'EligibilityRequest.language', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://tools.ietf.org/html/bcp47' } },
        'text' => { 'type' => 'Narrative', 'path' => 'EligibilityRequest.text', 'min' => 0, 'max' => 1 },
        'contained' => { 'type' => 'Resource', 'path' => 'EligibilityRequest.contained', 'min' => 0, 'max' => Float::INFINITY },
        'extension' => { 'type' => 'Extension', 'path' => 'EligibilityRequest.extension', 'min' => 0, 'max' => Float::INFINITY },
        'modifierExtension' => { 'type' => 'Extension', 'path' => 'EligibilityRequest.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
        'identifier' => { 'type' => 'Identifier', 'path' => 'EligibilityRequest.identifier', 'min' => 0, 'max' => Float::INFINITY },
        'ruleset' => { 'valid_codes' => { 'http://hl7.org/fhir/ruleset' => ['x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3'] }, 'type' => 'Coding', 'path' => 'EligibilityRequest.ruleset', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/ruleset' } },
        'originalRuleset' => { 'valid_codes' => { 'http://hl7.org/fhir/ruleset' => ['x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3'] }, 'type' => 'Coding', 'path' => 'EligibilityRequest.originalRuleset', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/ruleset' } },
        'created' => { 'type' => 'dateTime', 'path' => 'EligibilityRequest.created', 'min' => 0, 'max' => 1 },
        'target' => { 'type' => 'Reference', 'path' => 'EligibilityRequest.target', 'min' => 0, 'max' => 1 },
        'provider' => { 'type' => 'Reference', 'path' => 'EligibilityRequest.provider', 'min' => 0, 'max' => 1 },
        'organization' => { 'type' => 'Reference', 'path' => 'EligibilityRequest.organization', 'min' => 0, 'max' => 1 }
      }

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :identifier        # 0-* [ Identifier ]
      attr_accessor :ruleset           # 0-1 Coding
      attr_accessor :originalRuleset   # 0-1 Coding
      attr_accessor :created           # 0-1 dateTime
      attr_accessor :target            # 0-1 Reference()
      attr_accessor :provider          # 0-1 Reference()
      attr_accessor :organization      # 0-1 Reference()

      def resourceType
        'EligibilityRequest'
      end
    end
  end
end
