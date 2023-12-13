module FHIR
  module DSTU2
    class RiskAssessment < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['condition', 'date', 'encounter', 'identifier', 'method', 'patient', 'performer', 'subject']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'RiskAssessment.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'RiskAssessment.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'RiskAssessment.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'RiskAssessment.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'RiskAssessment.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'RiskAssessment.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'RiskAssessment.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'RiskAssessment.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'subject' => {'type'=>'Reference', 'path'=>'RiskAssessment.subject', 'min'=>0, 'max'=>1},
        'date' => {'type'=>'dateTime', 'path'=>'RiskAssessment.date', 'min'=>0, 'max'=>1},
        'condition' => {'type'=>'Reference', 'path'=>'RiskAssessment.condition', 'min'=>0, 'max'=>1},
        'encounter' => {'type'=>'Reference', 'path'=>'RiskAssessment.encounter', 'min'=>0, 'max'=>1},
        'performer' => {'type'=>'Reference', 'path'=>'RiskAssessment.performer', 'min'=>0, 'max'=>1},
        'identifier' => {'type'=>'Identifier', 'path'=>'RiskAssessment.identifier', 'min'=>0, 'max'=>1},
        'method' => {'local_name'=>'local_method', 'type'=>'CodeableConcept', 'path'=>'RiskAssessment.method', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
        'basis' => {'type'=>'Reference', 'path'=>'RiskAssessment.basis', 'min'=>0, 'max'=>Float::INFINITY},
        'prediction' => {'type'=>'RiskAssessment::Prediction', 'path'=>'RiskAssessment.prediction', 'min'=>0, 'max'=>Float::INFINITY},
        'mitigation' => {'type'=>'string', 'path'=>'RiskAssessment.mitigation', 'min'=>0, 'max'=>1}
      }

      class Prediction < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'probability' => ['decimal', 'Range', 'CodeableConcept'],
          'when' => ['Period', 'Range']
        }
        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Prediction.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Prediction.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Prediction.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'outcome' => {'type'=>'CodeableConcept', 'path'=>'Prediction.outcome', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
          'probabilityDecimal' => {'type'=>'decimal', 'path'=>'Prediction.probability[x]', 'min'=>0, 'max'=>1},
          'probabilityRange' => {'type'=>'Range', 'path'=>'Prediction.probability[x]', 'min'=>0, 'max'=>1},
          'probabilityCodeableConcept' => {'valid_codes'=>{'http://hl7.org/fhir/risk-probability'=>['negligible', 'low', 'moderate', 'high', 'certain']}, 'type'=>'CodeableConcept', 'path'=>'Prediction.probability[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/risk-probability'}},
          'relativeRisk' => {'type'=>'decimal', 'path'=>'Prediction.relativeRisk', 'min'=>0, 'max'=>1},
          'whenPeriod' => {'type'=>'Period', 'path'=>'Prediction.when[x]', 'min'=>0, 'max'=>1},
          'whenRange' => {'type'=>'Range', 'path'=>'Prediction.when[x]', 'min'=>0, 'max'=>1},
          'rationale' => {'type'=>'string', 'path'=>'Prediction.rationale', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                         # 0-1 id
        attr_accessor :extension                  # 0-* [ Extension ]
        attr_accessor :modifierExtension          # 0-* [ Extension ]
        attr_accessor :outcome                    # 1-1 CodeableConcept
        attr_accessor :probabilityDecimal         # 0-1 decimal
        attr_accessor :probabilityRange           # 0-1 Range
        attr_accessor :probabilityCodeableConcept # 0-1 CodeableConcept
        attr_accessor :relativeRisk               # 0-1 decimal
        attr_accessor :whenPeriod                 # 0-1 Period
        attr_accessor :whenRange                  # 0-1 Range
        attr_accessor :rationale                  # 0-1 string
      end

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :subject           # 0-1 Reference()
      attr_accessor :date              # 0-1 dateTime
      attr_accessor :condition         # 0-1 Reference()
      attr_accessor :encounter         # 0-1 Reference()
      attr_accessor :performer         # 0-1 Reference()
      attr_accessor :identifier        # 0-1 Identifier
      attr_accessor :local_method      # 0-1 CodeableConcept
      attr_accessor :basis             # 0-* [ Reference() ]
      attr_accessor :prediction        # 0-* [ RiskAssessment::Prediction ]
      attr_accessor :mitigation        # 0-1 string

      def resourceType
        'RiskAssessment'
      end
    end
  end
end
