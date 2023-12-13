module FHIR
  module DSTU2
    class VisionPrescription < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'reason' => ['CodeableConcept', 'Reference']
      }
      SEARCH_PARAMS = ['datewritten', 'encounter', 'identifier', 'patient', 'prescriber']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'VisionPrescription.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'VisionPrescription.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'VisionPrescription.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'VisionPrescription.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'VisionPrescription.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'VisionPrescription.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'VisionPrescription.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'VisionPrescription.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'VisionPrescription.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'dateWritten' => {'type'=>'dateTime', 'path'=>'VisionPrescription.dateWritten', 'min'=>0, 'max'=>1},
        'patient' => {'type'=>'Reference', 'path'=>'VisionPrescription.patient', 'min'=>0, 'max'=>1},
        'prescriber' => {'type'=>'Reference', 'path'=>'VisionPrescription.prescriber', 'min'=>0, 'max'=>1},
        'encounter' => {'type'=>'Reference', 'path'=>'VisionPrescription.encounter', 'min'=>0, 'max'=>1},
        'reasonCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'VisionPrescription.reason[x]', 'min'=>0, 'max'=>1},
        'reasonReference' => {'type'=>'Reference', 'path'=>'VisionPrescription.reason[x]', 'min'=>0, 'max'=>1},
        'dispense' => {'type'=>'VisionPrescription::Dispense', 'path'=>'VisionPrescription.dispense', 'min'=>0, 'max'=>Float::INFINITY}
      }

      class Dispense < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Dispense.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Dispense.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Dispense.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'product' => {'valid_codes'=>{'http://hl7.org/fhir/ex-visionprescriptionproduct'=>['lens', 'contact']}, 'type'=>'Coding', 'path'=>'Dispense.product', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/vision-product'}},
          'eye' => {'valid_codes'=>{'http://hl7.org/fhir/vision-eye-codes'=>['right', 'left']}, 'type'=>'code', 'path'=>'Dispense.eye', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/vision-eye-codes'}},
          'sphere' => {'type'=>'decimal', 'path'=>'Dispense.sphere', 'min'=>0, 'max'=>1},
          'cylinder' => {'type'=>'decimal', 'path'=>'Dispense.cylinder', 'min'=>0, 'max'=>1},
          'axis' => {'type'=>'integer', 'path'=>'Dispense.axis', 'min'=>0, 'max'=>1},
          'prism' => {'type'=>'decimal', 'path'=>'Dispense.prism', 'min'=>0, 'max'=>1},
          'base' => {'valid_codes'=>{'http://hl7.org/fhir/vision-base-codes'=>['up', 'down', 'in', 'out']}, 'type'=>'code', 'path'=>'Dispense.base', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/vision-base-codes'}},
          'add' => {'type'=>'decimal', 'path'=>'Dispense.add', 'min'=>0, 'max'=>1},
          'power' => {'type'=>'decimal', 'path'=>'Dispense.power', 'min'=>0, 'max'=>1},
          'backCurve' => {'type'=>'decimal', 'path'=>'Dispense.backCurve', 'min'=>0, 'max'=>1},
          'diameter' => {'type'=>'decimal', 'path'=>'Dispense.diameter', 'min'=>0, 'max'=>1},
          'duration' => {'type'=>'Quantity', 'path'=>'Dispense.duration', 'min'=>0, 'max'=>1},
          'color' => {'type'=>'string', 'path'=>'Dispense.color', 'min'=>0, 'max'=>1},
          'brand' => {'type'=>'string', 'path'=>'Dispense.brand', 'min'=>0, 'max'=>1},
          'notes' => {'type'=>'string', 'path'=>'Dispense.notes', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :product           # 1-1 Coding
        attr_accessor :eye               # 0-1 code
        attr_accessor :sphere            # 0-1 decimal
        attr_accessor :cylinder          # 0-1 decimal
        attr_accessor :axis              # 0-1 integer
        attr_accessor :prism             # 0-1 decimal
        attr_accessor :base              # 0-1 code
        attr_accessor :add               # 0-1 decimal
        attr_accessor :power             # 0-1 decimal
        attr_accessor :backCurve         # 0-1 decimal
        attr_accessor :diameter          # 0-1 decimal
        attr_accessor :duration          # 0-1 Quantity
        attr_accessor :color             # 0-1 string
        attr_accessor :brand             # 0-1 string
        attr_accessor :notes             # 0-1 string
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
      attr_accessor :dateWritten           # 0-1 dateTime
      attr_accessor :patient               # 0-1 Reference()
      attr_accessor :prescriber            # 0-1 Reference()
      attr_accessor :encounter             # 0-1 Reference()
      attr_accessor :reasonCodeableConcept # 0-1 CodeableConcept
      attr_accessor :reasonReference       # 0-1 Reference()
      attr_accessor :dispense              # 0-* [ VisionPrescription::Dispense ]

      def resourceType
        'VisionPrescription'
      end
    end
  end
end
