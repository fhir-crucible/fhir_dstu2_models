module FHIR
  module DSTU2
    class List < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['code', 'date', 'empty-reason', 'encounter', 'item', 'notes', 'patient', 'source', 'status', 'subject', 'title']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'List.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'List.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'List.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'List.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'List.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'List.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'List.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'List.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'List.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'title' => {'type'=>'string', 'path'=>'List.title', 'min'=>0, 'max'=>1},
        'code' => {'valid_codes'=>{'http://hl7.org/fhir/list-example-use-codes'=>['alerts', 'adverserxns', 'allergies', 'medications', 'problems', 'worklist', 'waiting', 'protocols', 'plans']}, 'type'=>'CodeableConcept', 'path'=>'List.code', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/list-example-codes'}},
        'subject' => {'type'=>'Reference', 'path'=>'List.subject', 'min'=>0, 'max'=>1},
        'source' => {'type'=>'Reference', 'path'=>'List.source', 'min'=>0, 'max'=>1},
        'encounter' => {'type'=>'Reference', 'path'=>'List.encounter', 'min'=>0, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/list-status'=>['current', 'retired', 'entered-in-error']}, 'type'=>'code', 'path'=>'List.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/list-status'}},
        'date' => {'type'=>'dateTime', 'path'=>'List.date', 'min'=>0, 'max'=>1},
        'orderedBy' => {'valid_codes'=>{'http://hl7.org/fhir/list-order'=>['user', 'system', 'event-date', 'entry-date', 'priority', 'alphabetic', 'category', 'patient']}, 'type'=>'CodeableConcept', 'path'=>'List.orderedBy', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'preferred', 'uri'=>'http://hl7.org/fhir/ValueSet/list-order'}},
        'mode' => {'valid_codes'=>{'http://hl7.org/fhir/list-mode'=>['working', 'snapshot', 'changes']}, 'type'=>'code', 'path'=>'List.mode', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/list-mode'}},
        'note' => {'type'=>'string', 'path'=>'List.note', 'min'=>0, 'max'=>1},
        'entry' => {'type'=>'List::Entry', 'path'=>'List.entry', 'min'=>0, 'max'=>Float::INFINITY},
        'emptyReason' => {'valid_codes'=>{'http://hl7.org/fhir/list-empty-reason'=>['nilknown', 'notasked', 'withheld', 'unavailable', 'notstarted', 'closed']}, 'type'=>'CodeableConcept', 'path'=>'List.emptyReason', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'preferred', 'uri'=>'http://hl7.org/fhir/ValueSet/list-empty-reason'}}
      }

      class Entry < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Entry.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Entry.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Entry.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'flag' => {'valid_codes'=>{'urn:oid:1.2.36.1.2001.1001.101.104.16592'=>['01', '02', '03', '04', '05', '06']}, 'type'=>'CodeableConcept', 'path'=>'Entry.flag', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/list-item-flag'}},
          'deleted' => {'type'=>'boolean', 'path'=>'Entry.deleted', 'min'=>0, 'max'=>1},
          'date' => {'type'=>'dateTime', 'path'=>'Entry.date', 'min'=>0, 'max'=>1},
          'item' => {'type'=>'Reference', 'path'=>'Entry.item', 'min'=>1, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :flag              # 0-1 CodeableConcept
        attr_accessor :deleted           # 0-1 boolean
        attr_accessor :date              # 0-1 dateTime
        attr_accessor :item              # 1-1 Reference()
      end

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :identifier        # 0-* [ Identifier ]
      attr_accessor :title             # 0-1 string
      attr_accessor :code              # 0-1 CodeableConcept
      attr_accessor :subject           # 0-1 Reference()
      attr_accessor :source            # 0-1 Reference()
      attr_accessor :encounter         # 0-1 Reference()
      attr_accessor :status            # 1-1 code
      attr_accessor :date              # 0-1 dateTime
      attr_accessor :orderedBy         # 0-1 CodeableConcept
      attr_accessor :mode              # 1-1 code
      attr_accessor :note              # 0-1 string
      attr_accessor :entry             # 0-* [ List::Entry ]
      attr_accessor :emptyReason       # 0-1 CodeableConcept

      def resourceType
        'List'
      end
    end
  end
end