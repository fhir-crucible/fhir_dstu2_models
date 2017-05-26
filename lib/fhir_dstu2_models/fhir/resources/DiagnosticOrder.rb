module FHIR
  module DSTU2
    class DiagnosticOrder < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['actor', 'bodysite', 'code', 'encounter', 'event-date', 'event-status', 'identifier', 'item-date', 'item-past-status', 'item-status', 'orderer', 'patient', 'specimen', 'status', 'subject']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'DiagnosticOrder.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'DiagnosticOrder.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'DiagnosticOrder.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'DiagnosticOrder.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'DiagnosticOrder.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'DiagnosticOrder.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'DiagnosticOrder.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'DiagnosticOrder.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'subject' => {'type'=>'Reference', 'path'=>'DiagnosticOrder.subject', 'min'=>1, 'max'=>1},
        'orderer' => {'type'=>'Reference', 'path'=>'DiagnosticOrder.orderer', 'min'=>0, 'max'=>1},
        'identifier' => {'type'=>'Identifier', 'path'=>'DiagnosticOrder.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'encounter' => {'type'=>'Reference', 'path'=>'DiagnosticOrder.encounter', 'min'=>0, 'max'=>1},
        'reason' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'DiagnosticOrder.reason', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/condition-code'}},
        'supportingInformation' => {'type'=>'Reference', 'path'=>'DiagnosticOrder.supportingInformation', 'min'=>0, 'max'=>Float::INFINITY},
        'specimen' => {'type'=>'Reference', 'path'=>'DiagnosticOrder.specimen', 'min'=>0, 'max'=>Float::INFINITY},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/diagnostic-order-status'=>['proposed', 'draft', 'planned', 'requested', 'received', 'accepted', 'in-progress', 'review', 'completed', 'cancelled', 'suspended', 'rejected', 'failed']}, 'type'=>'code', 'path'=>'DiagnosticOrder.status', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/diagnostic-order-status'}},
        'priority' => {'valid_codes'=>{'http://hl7.org/fhir/diagnostic-order-priority'=>['routine', 'urgent', 'stat', 'asap']}, 'type'=>'code', 'path'=>'DiagnosticOrder.priority', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/diagnostic-order-priority'}},
        'event' => {'type'=>'DiagnosticOrder::Event', 'path'=>'DiagnosticOrder.event', 'min'=>0, 'max'=>Float::INFINITY},
        'item' => {'type'=>'DiagnosticOrder::Item', 'path'=>'DiagnosticOrder.item', 'min'=>0, 'max'=>Float::INFINITY},
        'note' => {'type'=>'Annotation', 'path'=>'DiagnosticOrder.note', 'min'=>0, 'max'=>Float::INFINITY}
      }

      class Event < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Event.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Event.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Event.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'status' => {'valid_codes'=>{'http://hl7.org/fhir/diagnostic-order-status'=>['proposed', 'draft', 'planned', 'requested', 'received', 'accepted', 'in-progress', 'review', 'completed', 'cancelled', 'suspended', 'rejected', 'failed']}, 'type'=>'code', 'path'=>'Event.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/diagnostic-order-status'}},
          'description' => {'valid_codes'=>{'http://snomed.info/sct'=>['440622005', '394838008', '26895000']}, 'type'=>'CodeableConcept', 'path'=>'Event.description', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/diagnostic-order-event'}},
          'dateTime' => {'type'=>'dateTime', 'path'=>'Event.dateTime', 'min'=>1, 'max'=>1},
          'actor' => {'type'=>'Reference', 'path'=>'Event.actor', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :status            # 1-1 code
        attr_accessor :description       # 0-1 CodeableConcept
        attr_accessor :dateTime          # 1-1 dateTime
        attr_accessor :actor             # 0-1 Reference()
      end

      class Item < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Item.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Item.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Item.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'code' => {'valid_codes'=>{'http://loinc.org'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Item.code', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'preferred', 'uri'=>'http://hl7.org/fhir/ValueSet/diagnostic-requests'}},
          'specimen' => {'type'=>'Reference', 'path'=>'Item.specimen', 'min'=>0, 'max'=>Float::INFINITY},
          'bodySite' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Item.bodySite', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/body-site'}},
          'status' => {'valid_codes'=>{'http://hl7.org/fhir/diagnostic-order-status'=>['proposed', 'draft', 'planned', 'requested', 'received', 'accepted', 'in-progress', 'review', 'completed', 'cancelled', 'suspended', 'rejected', 'failed']}, 'type'=>'code', 'path'=>'Item.status', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/diagnostic-order-status'}},
          'event' => {'type'=>'DiagnosticOrder::Event', 'path'=>'Item.event', 'min'=>0, 'max'=>Float::INFINITY}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :code              # 1-1 CodeableConcept
        attr_accessor :specimen          # 0-* [ Reference() ]
        attr_accessor :bodySite          # 0-1 CodeableConcept
        attr_accessor :status            # 0-1 code
        attr_accessor :event             # 0-* [ DiagnosticOrder::Event ]
      end

      attr_accessor :id                    # 0-1 id
      attr_accessor :meta                  # 0-1 Meta
      attr_accessor :implicitRules         # 0-1 uri
      attr_accessor :language              # 0-1 code
      attr_accessor :text                  # 0-1 Narrative
      attr_accessor :contained             # 0-* [ Resource ]
      attr_accessor :extension             # 0-* [ Extension ]
      attr_accessor :modifierExtension     # 0-* [ Extension ]
      attr_accessor :subject               # 1-1 Reference()
      attr_accessor :orderer               # 0-1 Reference()
      attr_accessor :identifier            # 0-* [ Identifier ]
      attr_accessor :encounter             # 0-1 Reference()
      attr_accessor :reason                # 0-* [ CodeableConcept ]
      attr_accessor :supportingInformation # 0-* [ Reference() ]
      attr_accessor :specimen              # 0-* [ Reference() ]
      attr_accessor :status                # 0-1 code
      attr_accessor :priority              # 0-1 code
      attr_accessor :event                 # 0-* [ DiagnosticOrder::Event ]
      attr_accessor :item                  # 0-* [ DiagnosticOrder::Item ]
      attr_accessor :note                  # 0-* [ Annotation ]

      def resourceType
        'DiagnosticOrder'
      end
    end
  end
end