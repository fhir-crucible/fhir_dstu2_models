module FHIR
  module DSTU2
    class OrderResponse < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['code', 'date', 'fulfillment', 'identifier', 'request', 'who']
      METADATA = {
        'id' => { 'type' => 'id', 'path' => 'OrderResponse.id', 'min' => 0, 'max' => 1 },
        'meta' => { 'type' => 'Meta', 'path' => 'OrderResponse.meta', 'min' => 0, 'max' => 1 },
        'implicitRules' => { 'type' => 'uri', 'path' => 'OrderResponse.implicitRules', 'min' => 0, 'max' => 1 },
        'language' => { 'type' => 'code', 'path' => 'OrderResponse.language', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://tools.ietf.org/html/bcp47' } },
        'text' => { 'type' => 'Narrative', 'path' => 'OrderResponse.text', 'min' => 0, 'max' => 1 },
        'contained' => { 'type' => 'Resource', 'path' => 'OrderResponse.contained', 'min' => 0, 'max' => Float::INFINITY },
        'extension' => { 'type' => 'Extension', 'path' => 'OrderResponse.extension', 'min' => 0, 'max' => Float::INFINITY },
        'modifierExtension' => { 'type' => 'Extension', 'path' => 'OrderResponse.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
        'identifier' => { 'type' => 'Identifier', 'path' => 'OrderResponse.identifier', 'min' => 0, 'max' => Float::INFINITY },
        'request' => { 'type' => 'Reference', 'path' => 'OrderResponse.request', 'min' => 1, 'max' => 1 },
        'date' => { 'type' => 'dateTime', 'path' => 'OrderResponse.date', 'min' => 0, 'max' => 1 },
        'who' => { 'type' => 'Reference', 'path' => 'OrderResponse.who', 'min' => 0, 'max' => 1 },
        'orderStatus' => { 'valid_codes' => { 'http://hl7.org/fhir/order-status' => ['pending', 'review', 'rejected', 'error', 'accepted', 'cancelled', 'replaced', 'aborted', 'completed'] }, 'type' => 'code', 'path' => 'OrderResponse.orderStatus', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/order-status' } },
        'description' => { 'type' => 'string', 'path' => 'OrderResponse.description', 'min' => 0, 'max' => 1 },
        'fulfillment' => { 'type' => 'Reference', 'path' => 'OrderResponse.fulfillment', 'min' => 0, 'max' => Float::INFINITY }
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
      attr_accessor :request           # 1-1 Reference()
      attr_accessor :date              # 0-1 dateTime
      attr_accessor :who               # 0-1 Reference()
      attr_accessor :orderStatus       # 1-1 code
      attr_accessor :description       # 0-1 string
      attr_accessor :fulfillment       # 0-* [ Reference() ]

      def resourceType
        'OrderResponse'
      end
    end
  end
end
