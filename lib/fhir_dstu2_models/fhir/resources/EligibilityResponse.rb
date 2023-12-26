module FHIR
  module DSTU2
    class EligibilityResponse < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['identifier']
      METADATA = {
        'id' => { 'type' => 'id', 'path' => 'EligibilityResponse.id', 'min' => 0, 'max' => 1 },
        'meta' => { 'type' => 'Meta', 'path' => 'EligibilityResponse.meta', 'min' => 0, 'max' => 1 },
        'implicitRules' => { 'type' => 'uri', 'path' => 'EligibilityResponse.implicitRules', 'min' => 0, 'max' => 1 },
        'language' => { 'type' => 'code', 'path' => 'EligibilityResponse.language', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://tools.ietf.org/html/bcp47' } },
        'text' => { 'type' => 'Narrative', 'path' => 'EligibilityResponse.text', 'min' => 0, 'max' => 1 },
        'contained' => { 'type' => 'Resource', 'path' => 'EligibilityResponse.contained', 'min' => 0, 'max' => Float::INFINITY },
        'extension' => { 'type' => 'Extension', 'path' => 'EligibilityResponse.extension', 'min' => 0, 'max' => Float::INFINITY },
        'modifierExtension' => { 'type' => 'Extension', 'path' => 'EligibilityResponse.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
        'identifier' => { 'type' => 'Identifier', 'path' => 'EligibilityResponse.identifier', 'min' => 0, 'max' => Float::INFINITY },
        'request' => { 'type' => 'Reference', 'path' => 'EligibilityResponse.request', 'min' => 0, 'max' => 1 },
        'outcome' => { 'valid_codes' => { 'http://hl7.org/fhir/remittance-outcome' => ['complete', 'error'] }, 'type' => 'code', 'path' => 'EligibilityResponse.outcome', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/remittance-outcome' } },
        'disposition' => { 'type' => 'string', 'path' => 'EligibilityResponse.disposition', 'min' => 0, 'max' => 1 },
        'ruleset' => { 'valid_codes' => { 'http://hl7.org/fhir/ruleset' => ['x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3'] }, 'type' => 'Coding', 'path' => 'EligibilityResponse.ruleset', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/ruleset' } },
        'originalRuleset' => { 'valid_codes' => { 'http://hl7.org/fhir/ruleset' => ['x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3'] }, 'type' => 'Coding', 'path' => 'EligibilityResponse.originalRuleset', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/ruleset' } },
        'created' => { 'type' => 'dateTime', 'path' => 'EligibilityResponse.created', 'min' => 0, 'max' => 1 },
        'organization' => { 'type' => 'Reference', 'path' => 'EligibilityResponse.organization', 'min' => 0, 'max' => 1 },
        'requestProvider' => { 'type' => 'Reference', 'path' => 'EligibilityResponse.requestProvider', 'min' => 0, 'max' => 1 },
        'requestOrganization' => { 'type' => 'Reference', 'path' => 'EligibilityResponse.requestOrganization', 'min' => 0, 'max' => 1 }
      }

      attr_accessor :id                  # 0-1 id
      attr_accessor :meta                # 0-1 Meta
      attr_accessor :implicitRules       # 0-1 uri
      attr_accessor :language            # 0-1 code
      attr_accessor :text                # 0-1 Narrative
      attr_accessor :contained           # 0-* [ Resource ]
      attr_accessor :extension           # 0-* [ Extension ]
      attr_accessor :modifierExtension   # 0-* [ Extension ]
      attr_accessor :identifier          # 0-* [ Identifier ]
      attr_accessor :request             # 0-1 Reference()
      attr_accessor :outcome             # 0-1 code
      attr_accessor :disposition         # 0-1 string
      attr_accessor :ruleset             # 0-1 Coding
      attr_accessor :originalRuleset     # 0-1 Coding
      attr_accessor :created             # 0-1 dateTime
      attr_accessor :organization        # 0-1 Reference()
      attr_accessor :requestProvider     # 0-1 Reference()
      attr_accessor :requestOrganization # 0-1 Reference()

      def resourceType
        'EligibilityResponse'
      end
    end
  end
end
