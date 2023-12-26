module FHIR
  module DSTU2
    class ImmunizationRecommendation < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['date', 'dose-number', 'dose-sequence', 'identifier', 'information', 'patient', 'status', 'support', 'vaccine-type']
      METADATA = {
        'id' => { 'type' => 'id', 'path' => 'ImmunizationRecommendation.id', 'min' => 0, 'max' => 1 },
        'meta' => { 'type' => 'Meta', 'path' => 'ImmunizationRecommendation.meta', 'min' => 0, 'max' => 1 },
        'implicitRules' => { 'type' => 'uri', 'path' => 'ImmunizationRecommendation.implicitRules', 'min' => 0, 'max' => 1 },
        'language' => { 'type' => 'code', 'path' => 'ImmunizationRecommendation.language', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://tools.ietf.org/html/bcp47' } },
        'text' => { 'type' => 'Narrative', 'path' => 'ImmunizationRecommendation.text', 'min' => 0, 'max' => 1 },
        'contained' => { 'type' => 'Resource', 'path' => 'ImmunizationRecommendation.contained', 'min' => 0, 'max' => Float::INFINITY },
        'extension' => { 'type' => 'Extension', 'path' => 'ImmunizationRecommendation.extension', 'min' => 0, 'max' => Float::INFINITY },
        'modifierExtension' => { 'type' => 'Extension', 'path' => 'ImmunizationRecommendation.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
        'identifier' => { 'type' => 'Identifier', 'path' => 'ImmunizationRecommendation.identifier', 'min' => 0, 'max' => Float::INFINITY },
        'patient' => { 'type' => 'Reference', 'path' => 'ImmunizationRecommendation.patient', 'min' => 1, 'max' => 1 },
        'recommendation' => { 'type' => 'ImmunizationRecommendation::Recommendation', 'path' => 'ImmunizationRecommendation.recommendation', 'min' => 1, 'max' => Float::INFINITY }
      }

      class Recommendation < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Recommendation.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Recommendation.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Recommendation.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'date' => { 'type' => 'dateTime', 'path' => 'Recommendation.date', 'min' => 1, 'max' => 1 },
          'vaccineCode' => { 'valid_codes' => { 'http://hl7.org/fhir/sid/cvx' => [], 'urn:oid:1.2.36.1.2001.1005.17' => [] }, 'type' => 'CodeableConcept', 'path' => 'Recommendation.vaccineCode', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/vaccine-code' } },
          'doseNumber' => { 'type' => 'positiveInt', 'path' => 'Recommendation.doseNumber', 'min' => 0, 'max' => 1 },
          'forecastStatus' => { 'valid_codes' => { 'http://hl7.org/fhir/immunization-recommendation-status' => ['due', 'overdue'] }, 'type' => 'CodeableConcept', 'path' => 'Recommendation.forecastStatus', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/immunization-recommendation-status' } },
          'dateCriterion' => { 'type' => 'ImmunizationRecommendation::Recommendation::DateCriterion', 'path' => 'Recommendation.dateCriterion', 'min' => 0, 'max' => Float::INFINITY },
          'protocol' => { 'type' => 'ImmunizationRecommendation::Recommendation::Protocol', 'path' => 'Recommendation.protocol', 'min' => 0, 'max' => 1 },
          'supportingImmunization' => { 'type' => 'Reference', 'path' => 'Recommendation.supportingImmunization', 'min' => 0, 'max' => Float::INFINITY },
          'supportingPatientInformation' => { 'type' => 'Reference', 'path' => 'Recommendation.supportingPatientInformation', 'min' => 0, 'max' => Float::INFINITY }
        }

        class DateCriterion < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          METADATA = {
            'id' => { 'type' => 'id', 'path' => 'DateCriterion.id', 'min' => 0, 'max' => 1 },
            'extension' => { 'type' => 'Extension', 'path' => 'DateCriterion.extension', 'min' => 0, 'max' => Float::INFINITY },
            'modifierExtension' => { 'type' => 'Extension', 'path' => 'DateCriterion.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
            'code' => { 'valid_codes' => { 'http://hl7.org/fhir/immunization-recommendation-date-criterion' => ['due', 'recommended', 'earliest', 'overdue', 'latest'] }, 'type' => 'CodeableConcept', 'path' => 'DateCriterion.code', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/immunization-recommendation-date-criterion' } },
            'value' => { 'type' => 'dateTime', 'path' => 'DateCriterion.value', 'min' => 1, 'max' => 1 }
          }

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :code              # 1-1 CodeableConcept
          attr_accessor :value             # 1-1 dateTime
        end

        class Protocol < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          METADATA = {
            'id' => { 'type' => 'id', 'path' => 'Protocol.id', 'min' => 0, 'max' => 1 },
            'extension' => { 'type' => 'Extension', 'path' => 'Protocol.extension', 'min' => 0, 'max' => Float::INFINITY },
            'modifierExtension' => { 'type' => 'Extension', 'path' => 'Protocol.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
            'doseSequence' => { 'type' => 'integer', 'path' => 'Protocol.doseSequence', 'min' => 0, 'max' => 1 },
            'description' => { 'type' => 'string', 'path' => 'Protocol.description', 'min' => 0, 'max' => 1 },
            'authority' => { 'type' => 'Reference', 'path' => 'Protocol.authority', 'min' => 0, 'max' => 1 },
            'series' => { 'type' => 'string', 'path' => 'Protocol.series', 'min' => 0, 'max' => 1 }
          }

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :doseSequence      # 0-1 integer
          attr_accessor :description       # 0-1 string
          attr_accessor :authority         # 0-1 Reference()
          attr_accessor :series            # 0-1 string
        end

        attr_accessor :id                           # 0-1 id
        attr_accessor :extension                    # 0-* [ Extension ]
        attr_accessor :modifierExtension            # 0-* [ Extension ]
        attr_accessor :date                         # 1-1 dateTime
        attr_accessor :vaccineCode                  # 1-1 CodeableConcept
        attr_accessor :doseNumber                   # 0-1 positiveInt
        attr_accessor :forecastStatus               # 1-1 CodeableConcept
        attr_accessor :dateCriterion                # 0-* [ ImmunizationRecommendation::Recommendation::DateCriterion ]
        attr_accessor :protocol                     # 0-1 ImmunizationRecommendation::Recommendation::Protocol
        attr_accessor :supportingImmunization       # 0-* [ Reference() ]
        attr_accessor :supportingPatientInformation # 0-* [ Reference() ]
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
      attr_accessor :patient           # 1-1 Reference()
      attr_accessor :recommendation    # 1-* [ ImmunizationRecommendation::Recommendation ]

      def resourceType
        'ImmunizationRecommendation'
      end
    end
  end
end
