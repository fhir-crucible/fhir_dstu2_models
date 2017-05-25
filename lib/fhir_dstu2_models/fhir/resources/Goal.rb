module FHIR
  module DSTU2
    class Goal < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'start' => ['date', 'CodeableConcept'],
        'target' => ['date', 'Quantity']
      }
      SEARCH_PARAMS = ['category', 'identifier', 'patient', 'status', 'subject', 'targetdate']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Goal.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'Goal.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'Goal.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'Goal.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'Goal.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'Goal.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'Goal.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Goal.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'Goal.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'subject' => {'type'=>'Reference', 'path'=>'Goal.subject', 'min'=>0, 'max'=>1},
        'startDate' => {'type'=>'date', 'path'=>'Goal.start[x]', 'min'=>0, 'max'=>1},
        'startCodeableConcept' => {'valid_codes'=>{'http://snomed.info/sct'=>['32485007', '308283009', '442137000', '386216000']}, 'type'=>'CodeableConcept', 'path'=>'Goal.start[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/goal-start-event'}},
        'targetDate' => {'type'=>'date', 'path'=>'Goal.target[x]', 'min'=>0, 'max'=>1},
        'targetQuantity' => {'type'=>'Quantity', 'path'=>'Goal.target[x]', 'min'=>0, 'max'=>1},
        'category' => {'valid_codes'=>{'http://hl7.org/fhir/goal-category'=>['dietary', 'safety', 'behavioral', 'nursing', 'physiotherapy']}, 'type'=>'CodeableConcept', 'path'=>'Goal.category', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/goal-category'}},
        'description' => {'type'=>'string', 'path'=>'Goal.description', 'min'=>1, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/goal-status'=>['proposed', 'planned', 'accepted', 'rejected', 'in-progress', 'achieved', 'sustaining', 'on-hold', 'cancelled']}, 'type'=>'code', 'path'=>'Goal.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/goal-status'}},
        'statusDate' => {'type'=>'date', 'path'=>'Goal.statusDate', 'min'=>0, 'max'=>1},
        'statusReason' => {'valid_codes'=>{'http://hl7.org/fhir/goal-status-reason'=>['surgery', 'life-event', 'replaced', 'patient-request']}, 'type'=>'CodeableConcept', 'path'=>'Goal.statusReason', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/goal-status-reason'}},
        'author' => {'type'=>'Reference', 'path'=>'Goal.author', 'min'=>0, 'max'=>1},
        'priority' => {'valid_codes'=>{'http://hl7.org/fhir/goal-priority'=>['high', 'medium', 'low']}, 'type'=>'CodeableConcept', 'path'=>'Goal.priority', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'preferred', 'uri'=>'http://hl7.org/fhir/ValueSet/goal-priority'}},
        'addresses' => {'type'=>'Reference', 'path'=>'Goal.addresses', 'min'=>0, 'max'=>Float::INFINITY},
        'note' => {'type'=>'Annotation', 'path'=>'Goal.note', 'min'=>0, 'max'=>Float::INFINITY},
        'outcome' => {'type'=>'Goal::Outcome', 'path'=>'Goal.outcome', 'min'=>0, 'max'=>Float::INFINITY}
      }

      class Outcome < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'result' => ['CodeableConcept', 'Reference']
        }
        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Outcome.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Outcome.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Outcome.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'resultCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'Outcome.result[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
          'resultReference' => {'type'=>'Reference', 'path'=>'Outcome.result[x]', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                    # 0-1 id
        attr_accessor :extension             # 0-* [ Extension ]
        attr_accessor :modifierExtension     # 0-* [ Extension ]
        attr_accessor :resultCodeableConcept # 0-1 CodeableConcept
        attr_accessor :resultReference       # 0-1 Reference()
      end

      attr_accessor :id                   # 0-1 id
      attr_accessor :meta                 # 0-1 Meta
      attr_accessor :implicitRules        # 0-1 uri
      attr_accessor :language             # 0-1 code
      attr_accessor :text                 # 0-1 Narrative
      attr_accessor :contained            # 0-* [ Resource ]
      attr_accessor :extension            # 0-* [ Extension ]
      attr_accessor :modifierExtension    # 0-* [ Extension ]
      attr_accessor :identifier           # 0-* [ Identifier ]
      attr_accessor :subject              # 0-1 Reference()
      attr_accessor :startDate            # 0-1 date
      attr_accessor :startCodeableConcept # 0-1 CodeableConcept
      attr_accessor :targetDate           # 0-1 date
      attr_accessor :targetQuantity       # 0-1 Quantity
      attr_accessor :category             # 0-* [ CodeableConcept ]
      attr_accessor :description          # 1-1 string
      attr_accessor :status               # 1-1 code
      attr_accessor :statusDate           # 0-1 date
      attr_accessor :statusReason         # 0-1 CodeableConcept
      attr_accessor :author               # 0-1 Reference()
      attr_accessor :priority             # 0-1 CodeableConcept
      attr_accessor :addresses            # 0-* [ Reference() ]
      attr_accessor :note                 # 0-* [ Annotation ]
      attr_accessor :outcome              # 0-* [ Goal::Outcome ]

      def resourceType
        'Goal'
      end
    end
  end
end