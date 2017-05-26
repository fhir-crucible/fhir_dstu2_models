module FHIR
  module DSTU2
    class Order < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'reason' => ['CodeableConcept', 'Reference']
      }
      SEARCH_PARAMS = ['code', 'date', 'fulfillment', 'identifier', 'request', 'who', 'date', 'detail', 'identifier', 'patient', 'source', 'subject', 'target', 'when', 'when_code', 'additive', 'datetime', 'encounter', 'formula', 'identifier', 'oraldiet', 'patient', 'provider', 'status', 'supplement', 'code', 'datewritten', 'encounter', 'identifier', 'medication', 'patient', 'prescriber', 'status', 'actor', 'bodysite', 'code', 'encounter', 'event-date', 'event-status', 'identifier', 'item-date', 'item-past-status', 'item-status', 'orderer', 'patient', 'specimen', 'status', 'subject']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Order.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'Order.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'Order.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'Order.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'Order.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'Order.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'Order.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Order.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'Order.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'date' => {'type'=>'dateTime', 'path'=>'Order.date', 'min'=>0, 'max'=>1},
        'subject' => {'type'=>'Reference', 'path'=>'Order.subject', 'min'=>0, 'max'=>1},
        'source' => {'type'=>'Reference', 'path'=>'Order.source', 'min'=>0, 'max'=>1},
        'target' => {'type'=>'Reference', 'path'=>'Order.target', 'min'=>0, 'max'=>1},
        'reasonCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'Order.reason[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
        'reasonReference' => {'type'=>'Reference', 'path'=>'Order.reason[x]', 'min'=>0, 'max'=>1},
        'when' => {'type'=>'Order::When', 'path'=>'Order.when', 'min'=>0, 'max'=>1},
        'detail' => {'type'=>'Reference', 'path'=>'Order.detail', 'min'=>1, 'max'=>Float::INFINITY}
      }

      class When < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'When.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'When.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'When.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'code' => {'type'=>'CodeableConcept', 'path'=>'When.code', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
          'schedule' => {'type'=>'Timing', 'path'=>'When.schedule', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :code              # 0-1 CodeableConcept
        attr_accessor :schedule          # 0-1 Timing
      end

      attr_accessor :id                    # 0-1 id
      attr_accessor :meta                  # 0-1 Meta
      attr_accessor :implicitRules         # 0-1 uri
      attr_accessor :language              # 0-1 code
      attr_accessor :text                  # 0-1 Narrative
      attr_accessor :contained             # 0-* [ Resource ]
      attr_accessor :extension             # 0-* [ Extension ]
      attr_accessor :modifierExtension     # 0-* [ Extension ]
      attr_accessor :identifier            # 0-* [ Identifier ]
      attr_accessor :date                  # 0-1 dateTime
      attr_accessor :subject               # 0-1 Reference()
      attr_accessor :source                # 0-1 Reference()
      attr_accessor :target                # 0-1 Reference()
      attr_accessor :reasonCodeableConcept # 0-1 CodeableConcept
      attr_accessor :reasonReference       # 0-1 Reference()
      attr_accessor :when                  # 0-1 Order::When
      attr_accessor :detail                # 1-* [ Reference() ]

      def resourceType
        'Order'
      end
    end
  end
end