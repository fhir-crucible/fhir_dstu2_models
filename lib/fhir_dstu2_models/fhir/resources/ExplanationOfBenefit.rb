module FHIR
  module DSTU2
    class ExplanationOfBenefit < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['identifier']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'ExplanationOfBenefit.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'ExplanationOfBenefit.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'ExplanationOfBenefit.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'ExplanationOfBenefit.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'ExplanationOfBenefit.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'ExplanationOfBenefit.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'ExplanationOfBenefit.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'ExplanationOfBenefit.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'ExplanationOfBenefit.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'request' => {'type'=>'Reference', 'path'=>'ExplanationOfBenefit.request', 'min'=>0, 'max'=>1},
        'outcome' => {'valid_codes'=>{'http://hl7.org/fhir/remittance-outcome'=>['complete', 'error']}, 'type'=>'code', 'path'=>'ExplanationOfBenefit.outcome', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/remittance-outcome'}},
        'disposition' => {'type'=>'string', 'path'=>'ExplanationOfBenefit.disposition', 'min'=>0, 'max'=>1},
        'ruleset' => {'valid_codes'=>{'http://hl7.org/fhir/ruleset'=>['x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3']}, 'type'=>'Coding', 'path'=>'ExplanationOfBenefit.ruleset', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/ruleset'}},
        'originalRuleset' => {'valid_codes'=>{'http://hl7.org/fhir/ruleset'=>['x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3']}, 'type'=>'Coding', 'path'=>'ExplanationOfBenefit.originalRuleset', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/ruleset'}},
        'created' => {'type'=>'dateTime', 'path'=>'ExplanationOfBenefit.created', 'min'=>0, 'max'=>1},
        'organization' => {'type'=>'Reference', 'path'=>'ExplanationOfBenefit.organization', 'min'=>0, 'max'=>1},
        'requestProvider' => {'type'=>'Reference', 'path'=>'ExplanationOfBenefit.requestProvider', 'min'=>0, 'max'=>1},
        'requestOrganization' => {'type'=>'Reference', 'path'=>'ExplanationOfBenefit.requestOrganization', 'min'=>0, 'max'=>1}
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
        'ExplanationOfBenefit'
      end
    end
  end
end
