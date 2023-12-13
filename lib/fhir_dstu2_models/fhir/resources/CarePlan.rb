module FHIR
  module DSTU2
    class CarePlan < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['activitycode', 'activitydate', 'activityreference', 'condition', 'date', 'goal', 'participant', 'patient', 'performer', 'relatedcode', 'relatedplan', 'subject']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'CarePlan.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'CarePlan.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'CarePlan.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'CarePlan.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'CarePlan.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'CarePlan.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'CarePlan.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'CarePlan.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'CarePlan.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'subject' => {'type'=>'Reference', 'path'=>'CarePlan.subject', 'min'=>0, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/care-plan-status'=>['proposed', 'draft', 'active', 'completed', 'cancelled']}, 'type'=>'code', 'path'=>'CarePlan.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/care-plan-status'}},
        'context' => {'type'=>'Reference', 'path'=>'CarePlan.context', 'min'=>0, 'max'=>1},
        'period' => {'type'=>'Period', 'path'=>'CarePlan.period', 'min'=>0, 'max'=>1},
        'author' => {'type'=>'Reference', 'path'=>'CarePlan.author', 'min'=>0, 'max'=>Float::INFINITY},
        'modified' => {'type'=>'dateTime', 'path'=>'CarePlan.modified', 'min'=>0, 'max'=>1},
        'category' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'CarePlan.category', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/care-plan-category'}},
        'description' => {'type'=>'string', 'path'=>'CarePlan.description', 'min'=>0, 'max'=>1},
        'addresses' => {'type'=>'Reference', 'path'=>'CarePlan.addresses', 'min'=>0, 'max'=>Float::INFINITY},
        'support' => {'type'=>'Reference', 'path'=>'CarePlan.support', 'min'=>0, 'max'=>Float::INFINITY},
        'relatedPlan' => {'type'=>'CarePlan::RelatedPlan', 'path'=>'CarePlan.relatedPlan', 'min'=>0, 'max'=>Float::INFINITY},
        'participant' => {'type'=>'CarePlan::Participant', 'path'=>'CarePlan.participant', 'min'=>0, 'max'=>Float::INFINITY},
        'goal' => {'type'=>'Reference', 'path'=>'CarePlan.goal', 'min'=>0, 'max'=>Float::INFINITY},
        'activity' => {'type'=>'CarePlan::Activity', 'path'=>'CarePlan.activity', 'min'=>0, 'max'=>Float::INFINITY},
        'note' => {'type'=>'Annotation', 'path'=>'CarePlan.note', 'min'=>0, 'max'=>1}
      }

      class RelatedPlan < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'RelatedPlan.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'RelatedPlan.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'RelatedPlan.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'code' => {'valid_codes'=>{'http://hl7.org/fhir/care-plan-relationship'=>['includes', 'replaces', 'fulfills']}, 'type'=>'code', 'path'=>'RelatedPlan.code', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/care-plan-relationship'}},
          'plan' => {'type'=>'Reference', 'path'=>'RelatedPlan.plan', 'min'=>1, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :code              # 0-1 code
        attr_accessor :plan              # 1-1 Reference()
      end

      class Participant < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Participant.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Participant.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Participant.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'role' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Participant.role', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/participant-role'}},
          'member' => {'type'=>'Reference', 'path'=>'Participant.member', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :role              # 0-1 CodeableConcept
        attr_accessor :member            # 0-1 Reference()
      end

      class Activity < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Activity.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Activity.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Activity.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'actionResulting' => {'type'=>'Reference', 'path'=>'Activity.actionResulting', 'min'=>0, 'max'=>Float::INFINITY},
          'progress' => {'type'=>'Annotation', 'path'=>'Activity.progress', 'min'=>0, 'max'=>Float::INFINITY},
          'reference' => {'type'=>'Reference', 'path'=>'Activity.reference', 'min'=>0, 'max'=>1},
          'detail' => {'type'=>'CarePlan::Activity::Detail', 'path'=>'Activity.detail', 'min'=>0, 'max'=>1}
        }

        class Detail < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          MULTIPLE_TYPES = {
            'scheduled' => ['Timing', 'Period', 'string'],
            'product' => ['CodeableConcept', 'Reference']
          }
          METADATA = {
            'id' => {'type'=>'id', 'path'=>'Detail.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Detail.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Detail.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'category' => {'valid_codes'=>{'http://hl7.org/fhir/care-plan-activity-category'=>['diet', 'drug', 'encounter', 'observation', 'procedure', 'supply', 'other']}, 'type'=>'CodeableConcept', 'path'=>'Detail.category', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/care-plan-activity-category'}},
            'code' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Detail.code', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/care-plan-activity'}},
            'reasonCode' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Detail.reasonCode', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/activity-reason'}},
            'reasonReference' => {'type'=>'Reference', 'path'=>'Detail.reasonReference', 'min'=>0, 'max'=>Float::INFINITY},
            'goal' => {'type'=>'Reference', 'path'=>'Detail.goal', 'min'=>0, 'max'=>Float::INFINITY},
            'status' => {'valid_codes'=>{'http://hl7.org/fhir/care-plan-activity-status'=>['not-started', 'scheduled', 'in-progress', 'on-hold', 'completed', 'cancelled']}, 'type'=>'code', 'path'=>'Detail.status', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/care-plan-activity-status'}},
            'statusReason' => {'valid_codes'=>{'http://hl7.org/fhir/goal-status-reason'=>['surgery', 'life-event', 'replaced', 'patient-request']}, 'type'=>'CodeableConcept', 'path'=>'Detail.statusReason', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/goal-status-reason'}},
            'prohibited' => {'type'=>'boolean', 'path'=>'Detail.prohibited', 'min'=>1, 'max'=>1},
            'scheduledTiming' => {'type'=>'Timing', 'path'=>'Detail.scheduled[x]', 'min'=>0, 'max'=>1},
            'scheduledPeriod' => {'type'=>'Period', 'path'=>'Detail.scheduled[x]', 'min'=>0, 'max'=>1},
            'scheduledString' => {'type'=>'string', 'path'=>'Detail.scheduled[x]', 'min'=>0, 'max'=>1},
            'location' => {'type'=>'Reference', 'path'=>'Detail.location', 'min'=>0, 'max'=>1},
            'performer' => {'type'=>'Reference', 'path'=>'Detail.performer', 'min'=>0, 'max'=>Float::INFINITY},
            'productCodeableConcept' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Detail.product[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/medication-codes'}},
            'productReference' => {'type'=>'Reference', 'path'=>'Detail.product[x]', 'min'=>0, 'max'=>1},
            'dailyAmount' => {'type'=>'Quantity', 'path'=>'Detail.dailyAmount', 'min'=>0, 'max'=>1},
            'quantity' => {'type'=>'Quantity', 'path'=>'Detail.quantity', 'min'=>0, 'max'=>1},
            'description' => {'type'=>'string', 'path'=>'Detail.description', 'min'=>0, 'max'=>1}
          }

          attr_accessor :id                     # 0-1 id
          attr_accessor :extension              # 0-* [ Extension ]
          attr_accessor :modifierExtension      # 0-* [ Extension ]
          attr_accessor :category               # 0-1 CodeableConcept
          attr_accessor :code                   # 0-1 CodeableConcept
          attr_accessor :reasonCode             # 0-* [ CodeableConcept ]
          attr_accessor :reasonReference        # 0-* [ Reference() ]
          attr_accessor :goal                   # 0-* [ Reference() ]
          attr_accessor :status                 # 0-1 code
          attr_accessor :statusReason           # 0-1 CodeableConcept
          attr_accessor :prohibited             # 1-1 boolean
          attr_accessor :scheduledTiming        # 0-1 Timing
          attr_accessor :scheduledPeriod        # 0-1 Period
          attr_accessor :scheduledString        # 0-1 string
          attr_accessor :location               # 0-1 Reference()
          attr_accessor :performer              # 0-* [ Reference() ]
          attr_accessor :productCodeableConcept # 0-1 CodeableConcept
          attr_accessor :productReference       # 0-1 Reference()
          attr_accessor :dailyAmount            # 0-1 Quantity
          attr_accessor :quantity               # 0-1 Quantity
          attr_accessor :description            # 0-1 string
        end

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :actionResulting   # 0-* [ Reference() ]
        attr_accessor :progress          # 0-* [ Annotation ]
        attr_accessor :reference         # 0-1 Reference()
        attr_accessor :detail            # 0-1 CarePlan::Activity::Detail
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
      attr_accessor :subject           # 0-1 Reference()
      attr_accessor :status            # 1-1 code
      attr_accessor :context           # 0-1 Reference()
      attr_accessor :period            # 0-1 Period
      attr_accessor :author            # 0-* [ Reference() ]
      attr_accessor :modified          # 0-1 dateTime
      attr_accessor :category          # 0-* [ CodeableConcept ]
      attr_accessor :description       # 0-1 string
      attr_accessor :addresses         # 0-* [ Reference() ]
      attr_accessor :support           # 0-* [ Reference() ]
      attr_accessor :relatedPlan       # 0-* [ CarePlan::RelatedPlan ]
      attr_accessor :participant       # 0-* [ CarePlan::Participant ]
      attr_accessor :goal              # 0-* [ Reference() ]
      attr_accessor :activity          # 0-* [ CarePlan::Activity ]
      attr_accessor :note              # 0-1 Annotation

      def resourceType
        'CarePlan'
      end
    end
  end
end
