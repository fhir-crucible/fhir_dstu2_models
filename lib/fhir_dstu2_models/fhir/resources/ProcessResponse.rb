module FHIR
  module DSTU2
    class ProcessResponse < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['identifier', 'organization', 'request', 'requestorganization', 'requestprovider']
      METADATA = {
        'id' => { 'type' => 'id', 'path' => 'ProcessResponse.id', 'min' => 0, 'max' => 1 },
        'meta' => { 'type' => 'Meta', 'path' => 'ProcessResponse.meta', 'min' => 0, 'max' => 1 },
        'implicitRules' => { 'type' => 'uri', 'path' => 'ProcessResponse.implicitRules', 'min' => 0, 'max' => 1 },
        'language' => { 'type' => 'code', 'path' => 'ProcessResponse.language', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://tools.ietf.org/html/bcp47' } },
        'text' => { 'type' => 'Narrative', 'path' => 'ProcessResponse.text', 'min' => 0, 'max' => 1 },
        'contained' => { 'type' => 'Resource', 'path' => 'ProcessResponse.contained', 'min' => 0, 'max' => Float::INFINITY },
        'extension' => { 'type' => 'Extension', 'path' => 'ProcessResponse.extension', 'min' => 0, 'max' => Float::INFINITY },
        'modifierExtension' => { 'type' => 'Extension', 'path' => 'ProcessResponse.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
        'identifier' => { 'type' => 'Identifier', 'path' => 'ProcessResponse.identifier', 'min' => 0, 'max' => Float::INFINITY },
        'request' => { 'type' => 'Reference', 'path' => 'ProcessResponse.request', 'min' => 0, 'max' => 1 },
        'outcome' => { 'valid_codes' => { 'http://hl7.org/fhir/processoutcomecodes' => ['complete', 'pended', 'error'] }, 'type' => 'Coding', 'path' => 'ProcessResponse.outcome', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/process-outcome' } },
        'disposition' => { 'type' => 'string', 'path' => 'ProcessResponse.disposition', 'min' => 0, 'max' => 1 },
        'ruleset' => { 'valid_codes' => { 'http://hl7.org/fhir/ruleset' => ['x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3'] }, 'type' => 'Coding', 'path' => 'ProcessResponse.ruleset', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/ruleset' } },
        'originalRuleset' => { 'valid_codes' => { 'http://hl7.org/fhir/ruleset' => ['x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3'] }, 'type' => 'Coding', 'path' => 'ProcessResponse.originalRuleset', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/ruleset' } },
        'created' => { 'type' => 'dateTime', 'path' => 'ProcessResponse.created', 'min' => 0, 'max' => 1 },
        'organization' => { 'type' => 'Reference', 'path' => 'ProcessResponse.organization', 'min' => 0, 'max' => 1 },
        'requestProvider' => { 'type' => 'Reference', 'path' => 'ProcessResponse.requestProvider', 'min' => 0, 'max' => 1 },
        'requestOrganization' => { 'type' => 'Reference', 'path' => 'ProcessResponse.requestOrganization', 'min' => 0, 'max' => 1 },
        'form' => { 'valid_codes' => { 'http://hl7.org/fhir/forms-codes' => ['1', '2'] }, 'type' => 'Coding', 'path' => 'ProcessResponse.form', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/forms' } },
        'notes' => { 'type' => 'ProcessResponse::Notes', 'path' => 'ProcessResponse.notes', 'min' => 0, 'max' => Float::INFINITY },
        'error' => { 'valid_codes' => { 'http://hl7.org/fhir/adjudication-error' => ['A001', 'A002'] }, 'type' => 'Coding', 'path' => 'ProcessResponse.error', 'min' => 0, 'max' => Float::INFINITY, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/adjudication-error' } }
      }

      class Notes < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Notes.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Notes.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Notes.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'type' => { 'valid_codes' => { 'http://hl7.org/fhir/note-type' => ['display', 'print', 'printoper'] }, 'type' => 'Coding', 'path' => 'Notes.type', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/note-type' } },
          'text' => { 'type' => 'string', 'path' => 'Notes.text', 'min' => 0, 'max' => 1 }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :type              # 0-1 Coding
        attr_accessor :text              # 0-1 string
      end

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
      attr_accessor :outcome             # 0-1 Coding
      attr_accessor :disposition         # 0-1 string
      attr_accessor :ruleset             # 0-1 Coding
      attr_accessor :originalRuleset     # 0-1 Coding
      attr_accessor :created             # 0-1 dateTime
      attr_accessor :organization        # 0-1 Reference()
      attr_accessor :requestProvider     # 0-1 Reference()
      attr_accessor :requestOrganization # 0-1 Reference()
      attr_accessor :form                # 0-1 Coding
      attr_accessor :notes               # 0-* [ ProcessResponse::Notes ]
      attr_accessor :error               # 0-* [ Coding ]

      def resourceType
        'ProcessResponse'
      end
    end
  end
end
