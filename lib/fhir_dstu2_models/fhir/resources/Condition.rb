module FHIR
  module DSTU2
    class Condition < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'onset' => ['dateTime', 'Quantity', 'Period', 'Range', 'string'],
        'abatement' => ['dateTime', 'Quantity', 'boolean', 'Period', 'Range', 'string']
      }
      SEARCH_PARAMS = ['asserter', 'body-site', 'category', 'clinicalstatus', 'code', 'date-recorded', 'encounter', 'evidence', 'identifier', 'onset', 'onset-info', 'patient', 'severity', 'stage']
      METADATA = {
        'id' => { 'type' => 'id', 'path' => 'Condition.id', 'min' => 0, 'max' => 1 },
        'meta' => { 'type' => 'Meta', 'path' => 'Condition.meta', 'min' => 0, 'max' => 1 },
        'implicitRules' => { 'type' => 'uri', 'path' => 'Condition.implicitRules', 'min' => 0, 'max' => 1 },
        'language' => { 'type' => 'code', 'path' => 'Condition.language', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://tools.ietf.org/html/bcp47' } },
        'text' => { 'type' => 'Narrative', 'path' => 'Condition.text', 'min' => 0, 'max' => 1 },
        'contained' => { 'type' => 'Resource', 'path' => 'Condition.contained', 'min' => 0, 'max' => Float::INFINITY },
        'extension' => { 'type' => 'Extension', 'path' => 'Condition.extension', 'min' => 0, 'max' => Float::INFINITY },
        'modifierExtension' => { 'type' => 'Extension', 'path' => 'Condition.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
        'identifier' => { 'type' => 'Identifier', 'path' => 'Condition.identifier', 'min' => 0, 'max' => Float::INFINITY },
        'patient' => { 'type' => 'Reference', 'path' => 'Condition.patient', 'min' => 1, 'max' => 1 },
        'encounter' => { 'type' => 'Reference', 'path' => 'Condition.encounter', 'min' => 0, 'max' => 1 },
        'asserter' => { 'type' => 'Reference', 'path' => 'Condition.asserter', 'min' => 0, 'max' => 1 },
        'dateRecorded' => { 'type' => 'date', 'path' => 'Condition.dateRecorded', 'min' => 0, 'max' => 1 },
        'code' => { 'valid_codes' => { 'http://snomed.info/sct' => [] }, 'type' => 'CodeableConcept', 'path' => 'Condition.code', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/condition-code' } },
        'category' => { 'valid_codes' => { 'http://hl7.org/fhir/condition-category' => ['complaint', 'symptom', 'finding', 'diagnosis'] }, 'type' => 'CodeableConcept', 'path' => 'Condition.category', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'preferred', 'uri' => 'http://hl7.org/fhir/ValueSet/condition-category' } },
        'clinicalStatus' => { 'valid_codes' => { 'http://hl7.org/fhir/condition-clinical' => ['active', 'relapse', 'remission', 'resolved'] }, 'type' => 'code', 'path' => 'Condition.clinicalStatus', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'preferred', 'uri' => 'http://hl7.org/fhir/ValueSet/condition-clinical' } },
        'verificationStatus' => { 'valid_codes' => { 'http://hl7.org/fhir/condition-ver-status' => ['provisional', 'differential', 'confirmed', 'refuted', 'entered-in-error', 'unknown'] }, 'type' => 'code', 'path' => 'Condition.verificationStatus', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/condition-ver-status' } },
        'severity' => { 'valid_codes' => { 'http://snomed.info/sct' => ['399166001', '24484000', '6736007', '255604002'] }, 'type' => 'CodeableConcept', 'path' => 'Condition.severity', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'preferred', 'uri' => 'http://hl7.org/fhir/ValueSet/condition-severity' } },
        'onsetDateTime' => { 'type' => 'dateTime', 'path' => 'Condition.onset[x]', 'min' => 0, 'max' => 1 },
        'onsetQuantity' => { 'type' => 'Quantity', 'path' => 'Condition.onset[x]', 'min' => 0, 'max' => 1 },
        'onsetPeriod' => { 'type' => 'Period', 'path' => 'Condition.onset[x]', 'min' => 0, 'max' => 1 },
        'onsetRange' => { 'type' => 'Range', 'path' => 'Condition.onset[x]', 'min' => 0, 'max' => 1 },
        'onsetString' => { 'type' => 'string', 'path' => 'Condition.onset[x]', 'min' => 0, 'max' => 1 },
        'abatementDateTime' => { 'type' => 'dateTime', 'path' => 'Condition.abatement[x]', 'min' => 0, 'max' => 1 },
        'abatementQuantity' => { 'type' => 'Quantity', 'path' => 'Condition.abatement[x]', 'min' => 0, 'max' => 1 },
        'abatementBoolean' => { 'type' => 'boolean', 'path' => 'Condition.abatement[x]', 'min' => 0, 'max' => 1 },
        'abatementPeriod' => { 'type' => 'Period', 'path' => 'Condition.abatement[x]', 'min' => 0, 'max' => 1 },
        'abatementRange' => { 'type' => 'Range', 'path' => 'Condition.abatement[x]', 'min' => 0, 'max' => 1 },
        'abatementString' => { 'type' => 'string', 'path' => 'Condition.abatement[x]', 'min' => 0, 'max' => 1 },
        'stage' => { 'type' => 'Condition::Stage', 'path' => 'Condition.stage', 'min' => 0, 'max' => 1 },
        'evidence' => { 'type' => 'Condition::Evidence', 'path' => 'Condition.evidence', 'min' => 0, 'max' => Float::INFINITY },
        'bodySite' => { 'valid_codes' => { 'http://snomed.info/sct' => [] }, 'type' => 'CodeableConcept', 'path' => 'Condition.bodySite', 'min' => 0, 'max' => Float::INFINITY, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/body-site' } },
        'notes' => { 'type' => 'string', 'path' => 'Condition.notes', 'min' => 0, 'max' => 1 }
      }

      class Stage < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Stage.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Stage.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Stage.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'summary' => { 'valid_codes' => { 'http://snomed.info/sct' => [] }, 'type' => 'CodeableConcept', 'path' => 'Stage.summary', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/condition-stage' } },
          'assessment' => { 'type' => 'Reference', 'path' => 'Stage.assessment', 'min' => 0, 'max' => Float::INFINITY }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :summary           # 0-1 CodeableConcept
        attr_accessor :assessment        # 0-* [ Reference() ]
      end

      class Evidence < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Evidence.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Evidence.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Evidence.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'code' => { 'valid_codes' => { 'http://snomed.info/sct' => [] }, 'type' => 'CodeableConcept', 'path' => 'Evidence.code', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/manifestation-or-symptom' } },
          'detail' => { 'type' => 'Reference', 'path' => 'Evidence.detail', 'min' => 0, 'max' => Float::INFINITY }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :code              # 0-1 CodeableConcept
        attr_accessor :detail            # 0-* [ Reference() ]
      end

      attr_accessor :id                 # 0-1 id
      attr_accessor :meta               # 0-1 Meta
      attr_accessor :implicitRules      # 0-1 uri
      attr_accessor :language           # 0-1 code
      attr_accessor :text               # 0-1 Narrative
      attr_accessor :contained          # 0-* [ Resource ]
      attr_accessor :extension          # 0-* [ Extension ]
      attr_accessor :modifierExtension  # 0-* [ Extension ]
      attr_accessor :identifier         # 0-* [ Identifier ]
      attr_accessor :patient            # 1-1 Reference()
      attr_accessor :encounter          # 0-1 Reference()
      attr_accessor :asserter           # 0-1 Reference()
      attr_accessor :dateRecorded       # 0-1 date
      attr_accessor :code               # 1-1 CodeableConcept
      attr_accessor :category           # 0-1 CodeableConcept
      attr_accessor :clinicalStatus     # 0-1 code
      attr_accessor :verificationStatus # 1-1 code
      attr_accessor :severity           # 0-1 CodeableConcept
      attr_accessor :onsetDateTime      # 0-1 dateTime
      attr_accessor :onsetQuantity      # 0-1 Quantity
      attr_accessor :onsetPeriod        # 0-1 Period
      attr_accessor :onsetRange         # 0-1 Range
      attr_accessor :onsetString        # 0-1 string
      attr_accessor :abatementDateTime  # 0-1 dateTime
      attr_accessor :abatementQuantity  # 0-1 Quantity
      attr_accessor :abatementBoolean   # 0-1 boolean
      attr_accessor :abatementPeriod    # 0-1 Period
      attr_accessor :abatementRange     # 0-1 Range
      attr_accessor :abatementString    # 0-1 string
      attr_accessor :stage              # 0-1 Condition::Stage
      attr_accessor :evidence           # 0-* [ Condition::Evidence ]
      attr_accessor :bodySite           # 0-* [ CodeableConcept ]
      attr_accessor :notes              # 0-1 string

      def resourceType
        'Condition'
      end
    end
  end
end
