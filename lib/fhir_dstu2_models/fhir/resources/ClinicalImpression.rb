module FHIR
  module DSTU2
    class ClinicalImpression < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'trigger' => ['CodeableConcept', 'Reference']
      }
      SEARCH_PARAMS = ['action', 'assessor', 'date', 'finding', 'investigation', 'patient', 'plan', 'previous', 'problem', 'resolved', 'ruledout', 'status', 'trigger', 'trigger-code']
      METADATA = {
        'id' => { 'type' => 'id', 'path' => 'ClinicalImpression.id', 'min' => 0, 'max' => 1 },
        'meta' => { 'type' => 'Meta', 'path' => 'ClinicalImpression.meta', 'min' => 0, 'max' => 1 },
        'implicitRules' => { 'type' => 'uri', 'path' => 'ClinicalImpression.implicitRules', 'min' => 0, 'max' => 1 },
        'language' => { 'type' => 'code', 'path' => 'ClinicalImpression.language', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://tools.ietf.org/html/bcp47' } },
        'text' => { 'type' => 'Narrative', 'path' => 'ClinicalImpression.text', 'min' => 0, 'max' => 1 },
        'contained' => { 'type' => 'Resource', 'path' => 'ClinicalImpression.contained', 'min' => 0, 'max' => Float::INFINITY },
        'extension' => { 'type' => 'Extension', 'path' => 'ClinicalImpression.extension', 'min' => 0, 'max' => Float::INFINITY },
        'modifierExtension' => { 'type' => 'Extension', 'path' => 'ClinicalImpression.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
        'patient' => { 'type' => 'Reference', 'path' => 'ClinicalImpression.patient', 'min' => 1, 'max' => 1 },
        'assessor' => { 'type' => 'Reference', 'path' => 'ClinicalImpression.assessor', 'min' => 0, 'max' => 1 },
        'status' => { 'valid_codes' => { 'http://hl7.org/fhir/clinical-impression-status' => ['in-progress', 'completed', 'entered-in-error'] }, 'type' => 'code', 'path' => 'ClinicalImpression.status', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/clinical-impression-status' } },
        'date' => { 'type' => 'dateTime', 'path' => 'ClinicalImpression.date', 'min' => 0, 'max' => 1 },
        'description' => { 'type' => 'string', 'path' => 'ClinicalImpression.description', 'min' => 0, 'max' => 1 },
        'previous' => { 'type' => 'Reference', 'path' => 'ClinicalImpression.previous', 'min' => 0, 'max' => 1 },
        'problem' => { 'type' => 'Reference', 'path' => 'ClinicalImpression.problem', 'min' => 0, 'max' => Float::INFINITY },
        'triggerCodeableConcept' => { 'valid_codes' => { 'http://snomed.info/sct' => [] }, 'type' => 'CodeableConcept', 'path' => 'ClinicalImpression.trigger[x]', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/clinical-findings' } },
        'triggerReference' => { 'type' => 'Reference', 'path' => 'ClinicalImpression.trigger[x]', 'min' => 0, 'max' => 1 },
        'investigations' => { 'type' => 'ClinicalImpression::Investigations', 'path' => 'ClinicalImpression.investigations', 'min' => 0, 'max' => Float::INFINITY },
        'protocol' => { 'type' => 'uri', 'path' => 'ClinicalImpression.protocol', 'min' => 0, 'max' => 1 },
        'summary' => { 'type' => 'string', 'path' => 'ClinicalImpression.summary', 'min' => 0, 'max' => 1 },
        'finding' => { 'type' => 'ClinicalImpression::Finding', 'path' => 'ClinicalImpression.finding', 'min' => 0, 'max' => Float::INFINITY },
        'resolved' => { 'valid_codes' => { 'http://snomed.info/sct' => [] }, 'type' => 'CodeableConcept', 'path' => 'ClinicalImpression.resolved', 'min' => 0, 'max' => Float::INFINITY, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/condition-code' } },
        'ruledOut' => { 'type' => 'ClinicalImpression::RuledOut', 'path' => 'ClinicalImpression.ruledOut', 'min' => 0, 'max' => Float::INFINITY },
        'prognosis' => { 'type' => 'string', 'path' => 'ClinicalImpression.prognosis', 'min' => 0, 'max' => 1 },
        'plan' => { 'type' => 'Reference', 'path' => 'ClinicalImpression.plan', 'min' => 0, 'max' => Float::INFINITY },
        'action' => { 'type' => 'Reference', 'path' => 'ClinicalImpression.action', 'min' => 0, 'max' => Float::INFINITY }
      }

      class Investigations < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Investigations.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Investigations.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Investigations.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'code' => { 'valid_codes' => { 'http://snomed.info/sct' => ['271336007', '160237006'] }, 'type' => 'CodeableConcept', 'path' => 'Investigations.code', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/investigation-sets' } },
          'item' => { 'type' => 'Reference', 'path' => 'Investigations.item', 'min' => 0, 'max' => Float::INFINITY }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :code              # 1-1 CodeableConcept
        attr_accessor :item              # 0-* [ Reference() ]
      end

      class Finding < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Finding.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Finding.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Finding.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'item' => { 'valid_codes' => { 'http://snomed.info/sct' => [] }, 'type' => 'CodeableConcept', 'path' => 'Finding.item', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/condition-code' } },
          'cause' => { 'type' => 'string', 'path' => 'Finding.cause', 'min' => 0, 'max' => 1 }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :item              # 1-1 CodeableConcept
        attr_accessor :cause             # 0-1 string
      end

      class RuledOut < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'RuledOut.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'RuledOut.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'RuledOut.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'item' => { 'valid_codes' => { 'http://snomed.info/sct' => [] }, 'type' => 'CodeableConcept', 'path' => 'RuledOut.item', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/condition-code' } },
          'reason' => { 'type' => 'string', 'path' => 'RuledOut.reason', 'min' => 0, 'max' => 1 }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :item              # 1-1 CodeableConcept
        attr_accessor :reason            # 0-1 string
      end

      attr_accessor :id                     # 0-1 id
      attr_accessor :meta                   # 0-1 Meta
      attr_accessor :implicitRules          # 0-1 uri
      attr_accessor :language               # 0-1 code
      attr_accessor :text                   # 0-1 Narrative
      attr_accessor :contained              # 0-* [ Resource ]
      attr_accessor :extension              # 0-* [ Extension ]
      attr_accessor :modifierExtension      # 0-* [ Extension ]
      attr_accessor :patient                # 1-1 Reference()
      attr_accessor :assessor               # 0-1 Reference()
      attr_accessor :status                 # 1-1 code
      attr_accessor :date                   # 0-1 dateTime
      attr_accessor :description            # 0-1 string
      attr_accessor :previous               # 0-1 Reference()
      attr_accessor :problem                # 0-* [ Reference() ]
      attr_accessor :triggerCodeableConcept # 0-1 CodeableConcept
      attr_accessor :triggerReference       # 0-1 Reference()
      attr_accessor :investigations         # 0-* [ ClinicalImpression::Investigations ]
      attr_accessor :protocol               # 0-1 uri
      attr_accessor :summary                # 0-1 string
      attr_accessor :finding                # 0-* [ ClinicalImpression::Finding ]
      attr_accessor :resolved               # 0-* [ CodeableConcept ]
      attr_accessor :ruledOut               # 0-* [ ClinicalImpression::RuledOut ]
      attr_accessor :prognosis              # 0-1 string
      attr_accessor :plan                   # 0-* [ Reference() ]
      attr_accessor :action                 # 0-* [ Reference() ]

      def resourceType
        'ClinicalImpression'
      end
    end
  end
end
