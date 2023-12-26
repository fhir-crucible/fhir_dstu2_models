module FHIR
  module DSTU2
    class PaymentNotice < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['identifier']
      METADATA = {
        'id' => { 'type' => 'id', 'path' => 'PaymentNotice.id', 'min' => 0, 'max' => 1 },
        'meta' => { 'type' => 'Meta', 'path' => 'PaymentNotice.meta', 'min' => 0, 'max' => 1 },
        'implicitRules' => { 'type' => 'uri', 'path' => 'PaymentNotice.implicitRules', 'min' => 0, 'max' => 1 },
        'language' => { 'type' => 'code', 'path' => 'PaymentNotice.language', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://tools.ietf.org/html/bcp47' } },
        'text' => { 'type' => 'Narrative', 'path' => 'PaymentNotice.text', 'min' => 0, 'max' => 1 },
        'contained' => { 'type' => 'Resource', 'path' => 'PaymentNotice.contained', 'min' => 0, 'max' => Float::INFINITY },
        'extension' => { 'type' => 'Extension', 'path' => 'PaymentNotice.extension', 'min' => 0, 'max' => Float::INFINITY },
        'modifierExtension' => { 'type' => 'Extension', 'path' => 'PaymentNotice.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
        'identifier' => { 'type' => 'Identifier', 'path' => 'PaymentNotice.identifier', 'min' => 0, 'max' => Float::INFINITY },
        'ruleset' => { 'valid_codes' => { 'http://hl7.org/fhir/ruleset' => ['x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3'] }, 'type' => 'Coding', 'path' => 'PaymentNotice.ruleset', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/ruleset' } },
        'originalRuleset' => { 'valid_codes' => { 'http://hl7.org/fhir/ruleset' => ['x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3'] }, 'type' => 'Coding', 'path' => 'PaymentNotice.originalRuleset', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/ruleset' } },
        'created' => { 'type' => 'dateTime', 'path' => 'PaymentNotice.created', 'min' => 0, 'max' => 1 },
        'target' => { 'type' => 'Reference', 'path' => 'PaymentNotice.target', 'min' => 0, 'max' => 1 },
        'provider' => { 'type' => 'Reference', 'path' => 'PaymentNotice.provider', 'min' => 0, 'max' => 1 },
        'organization' => { 'type' => 'Reference', 'path' => 'PaymentNotice.organization', 'min' => 0, 'max' => 1 },
        'request' => { 'type' => 'Reference', 'path' => 'PaymentNotice.request', 'min' => 0, 'max' => 1 },
        'response' => { 'type' => 'Reference', 'path' => 'PaymentNotice.response', 'min' => 0, 'max' => 1 },
        'paymentStatus' => { 'valid_codes' => { 'http://hl7.org/fhir/paymentstatus' => ['paid', 'cleared'] }, 'type' => 'Coding', 'path' => 'PaymentNotice.paymentStatus', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/payment-status' } }
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
      attr_accessor :request           # 0-1 Reference()
      attr_accessor :response          # 0-1 Reference()
      attr_accessor :paymentStatus     # 1-1 Coding

      def resourceType
        'PaymentNotice'
      end
    end
  end
end
