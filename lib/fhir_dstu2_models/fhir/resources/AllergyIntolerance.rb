module FHIR
  module DSTU2
    class AllergyIntolerance < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['category', 'criticality', 'date', 'identifier', 'last-date', 'manifestation', 'onset', 'patient', 'recorder', 'reporter', 'route', 'severity', 'status', 'substance', 'type']
      METADATA = {
        'id' => { 'type' => 'id', 'path' => 'AllergyIntolerance.id', 'min' => 0, 'max' => 1 },
        'meta' => { 'type' => 'Meta', 'path' => 'AllergyIntolerance.meta', 'min' => 0, 'max' => 1 },
        'implicitRules' => { 'type' => 'uri', 'path' => 'AllergyIntolerance.implicitRules', 'min' => 0, 'max' => 1 },
        'language' => { 'type' => 'code', 'path' => 'AllergyIntolerance.language', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://tools.ietf.org/html/bcp47' } },
        'text' => { 'type' => 'Narrative', 'path' => 'AllergyIntolerance.text', 'min' => 0, 'max' => 1 },
        'contained' => { 'type' => 'Resource', 'path' => 'AllergyIntolerance.contained', 'min' => 0, 'max' => Float::INFINITY },
        'extension' => { 'type' => 'Extension', 'path' => 'AllergyIntolerance.extension', 'min' => 0, 'max' => Float::INFINITY },
        'modifierExtension' => { 'type' => 'Extension', 'path' => 'AllergyIntolerance.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
        'identifier' => { 'type' => 'Identifier', 'path' => 'AllergyIntolerance.identifier', 'min' => 0, 'max' => Float::INFINITY },
        'onset' => { 'type' => 'dateTime', 'path' => 'AllergyIntolerance.onset', 'min' => 0, 'max' => 1 },
        'recordedDate' => { 'type' => 'dateTime', 'path' => 'AllergyIntolerance.recordedDate', 'min' => 0, 'max' => 1 },
        'recorder' => { 'type' => 'Reference', 'path' => 'AllergyIntolerance.recorder', 'min' => 0, 'max' => 1 },
        'patient' => { 'type' => 'Reference', 'path' => 'AllergyIntolerance.patient', 'min' => 1, 'max' => 1 },
        'reporter' => { 'type' => 'Reference', 'path' => 'AllergyIntolerance.reporter', 'min' => 0, 'max' => 1 },
        'substance' => { 'valid_codes' => { 'http://snomed.info/sct' => ['160244002', '429625007', '409137002', '428607008'] }, 'type' => 'CodeableConcept', 'path' => 'AllergyIntolerance.substance', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/allergyintolerance-substance-code' } },
        'status' => { 'valid_codes' => { 'http://hl7.org/fhir/allergy-intolerance-status' => ['active', 'unconfirmed', 'confirmed', 'inactive', 'resolved', 'refuted', 'entered-in-error'] }, 'type' => 'code', 'path' => 'AllergyIntolerance.status', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/allergy-intolerance-status' } },
        'criticality' => { 'valid_codes' => { 'http://hl7.org/fhir/allergy-intolerance-criticality' => ['CRITL', 'CRITH', 'CRITU'] }, 'type' => 'code', 'path' => 'AllergyIntolerance.criticality', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/allergy-intolerance-criticality' } },
        'type' => { 'valid_codes' => { 'http://hl7.org/fhir/allergy-intolerance-type' => ['allergy', 'intolerance'] }, 'type' => 'code', 'path' => 'AllergyIntolerance.type', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/allergy-intolerance-type' } },
        'category' => { 'valid_codes' => { 'http://hl7.org/fhir/allergy-intolerance-category' => ['food', 'medication', 'environment', 'other'] }, 'type' => 'code', 'path' => 'AllergyIntolerance.category', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/allergy-intolerance-category' } },
        'lastOccurence' => { 'type' => 'dateTime', 'path' => 'AllergyIntolerance.lastOccurence', 'min' => 0, 'max' => 1 },
        'note' => { 'type' => 'Annotation', 'path' => 'AllergyIntolerance.note', 'min' => 0, 'max' => 1 },
        'reaction' => { 'type' => 'AllergyIntolerance::Reaction', 'path' => 'AllergyIntolerance.reaction', 'min' => 0, 'max' => Float::INFINITY }
      }

      class Reaction < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Reaction.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Reaction.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Reaction.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'substance' => { 'valid_codes' => { 'http://snomed.info/sct' => [] }, 'type' => 'CodeableConcept', 'path' => 'Reaction.substance', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/substance-code' } },
          'certainty' => { 'valid_codes' => { 'http://hl7.org/fhir/reaction-event-certainty' => ['unlikely', 'likely', 'confirmed'] }, 'type' => 'code', 'path' => 'Reaction.certainty', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/reaction-event-certainty' } },
          'manifestation' => { 'valid_codes' => { 'http://snomed.info/sct' => [] }, 'type' => 'CodeableConcept', 'path' => 'Reaction.manifestation', 'min' => 1, 'max' => Float::INFINITY, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/manifestation-codes' } },
          'description' => { 'type' => 'string', 'path' => 'Reaction.description', 'min' => 0, 'max' => 1 },
          'onset' => { 'type' => 'dateTime', 'path' => 'Reaction.onset', 'min' => 0, 'max' => 1 },
          'severity' => { 'valid_codes' => { 'http://hl7.org/fhir/reaction-event-severity' => ['mild', 'moderate', 'severe'] }, 'type' => 'code', 'path' => 'Reaction.severity', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/reaction-event-severity' } },
          'exposureRoute' => { 'valid_codes' => { 'http://snomed.info/sct' => [] }, 'type' => 'CodeableConcept', 'path' => 'Reaction.exposureRoute', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/route-codes' } },
          'note' => { 'type' => 'Annotation', 'path' => 'Reaction.note', 'min' => 0, 'max' => 1 }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :substance         # 0-1 CodeableConcept
        attr_accessor :certainty         # 0-1 code
        attr_accessor :manifestation     # 1-* [ CodeableConcept ]
        attr_accessor :description       # 0-1 string
        attr_accessor :onset             # 0-1 dateTime
        attr_accessor :severity          # 0-1 code
        attr_accessor :exposureRoute     # 0-1 CodeableConcept
        attr_accessor :note              # 0-1 Annotation
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
      attr_accessor :onset             # 0-1 dateTime
      attr_accessor :recordedDate      # 0-1 dateTime
      attr_accessor :recorder          # 0-1 Reference()
      attr_accessor :patient           # 1-1 Reference()
      attr_accessor :reporter          # 0-1 Reference()
      attr_accessor :substance         # 1-1 CodeableConcept
      attr_accessor :status            # 0-1 code
      attr_accessor :criticality       # 0-1 code
      attr_accessor :type              # 0-1 code
      attr_accessor :category          # 0-1 code
      attr_accessor :lastOccurence     # 0-1 dateTime
      attr_accessor :note              # 0-1 Annotation
      attr_accessor :reaction          # 0-* [ AllergyIntolerance::Reaction ]

      def resourceType
        'AllergyIntolerance'
      end
    end
  end
end
