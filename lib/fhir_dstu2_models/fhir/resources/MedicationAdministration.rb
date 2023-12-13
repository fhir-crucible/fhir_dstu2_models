module FHIR
  module DSTU2
    class MedicationAdministration < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'effectiveTime' => ['dateTime', 'Period'],
        'medication' => ['CodeableConcept', 'Reference']
      }
      SEARCH_PARAMS = ['code', 'device', 'effectivetime', 'encounter', 'identifier', 'medication', 'notgiven', 'patient', 'practitioner', 'prescription', 'status']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'MedicationAdministration.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'MedicationAdministration.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'MedicationAdministration.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'MedicationAdministration.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'MedicationAdministration.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'MedicationAdministration.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'MedicationAdministration.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'MedicationAdministration.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'MedicationAdministration.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/medication-admin-status'=>['in-progress', 'on-hold', 'completed', 'entered-in-error', 'stopped']}, 'type'=>'code', 'path'=>'MedicationAdministration.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/medication-admin-status'}},
        'patient' => {'type'=>'Reference', 'path'=>'MedicationAdministration.patient', 'min'=>1, 'max'=>1},
        'practitioner' => {'type'=>'Reference', 'path'=>'MedicationAdministration.practitioner', 'min'=>0, 'max'=>1},
        'encounter' => {'type'=>'Reference', 'path'=>'MedicationAdministration.encounter', 'min'=>0, 'max'=>1},
        'prescription' => {'type'=>'Reference', 'path'=>'MedicationAdministration.prescription', 'min'=>0, 'max'=>1},
        'wasNotGiven' => {'type'=>'boolean', 'path'=>'MedicationAdministration.wasNotGiven', 'min'=>0, 'max'=>1},
        'reasonNotGiven' => {'valid_codes'=>{'http://hl7.org/fhir/reason-medication-not-given'=>['a', 'b', 'c', 'd']}, 'type'=>'CodeableConcept', 'path'=>'MedicationAdministration.reasonNotGiven', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/reason-medication-not-given-codes'}},
        'reasonGiven' => {'valid_codes'=>{'http://hl7.org/fhir/reason-medication-given'=>['a', 'b', 'c']}, 'type'=>'CodeableConcept', 'path'=>'MedicationAdministration.reasonGiven', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/reason-medication-given-codes'}},
        'effectiveTimeDateTime' => {'type'=>'dateTime', 'path'=>'MedicationAdministration.effectiveTime[x]', 'min'=>1, 'max'=>1},
        'effectiveTimePeriod' => {'type'=>'Period', 'path'=>'MedicationAdministration.effectiveTime[x]', 'min'=>1, 'max'=>1},
        'medicationCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'MedicationAdministration.medication[x]', 'min'=>1, 'max'=>1},
        'medicationReference' => {'type'=>'Reference', 'path'=>'MedicationAdministration.medication[x]', 'min'=>1, 'max'=>1},
        'device' => {'type'=>'Reference', 'path'=>'MedicationAdministration.device', 'min'=>0, 'max'=>Float::INFINITY},
        'note' => {'type'=>'string', 'path'=>'MedicationAdministration.note', 'min'=>0, 'max'=>1},
        'dosage' => {'type'=>'MedicationAdministration::Dosage', 'path'=>'MedicationAdministration.dosage', 'min'=>0, 'max'=>1}
      }

      class Dosage < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'site' => ['CodeableConcept', 'Reference'],
          'rate' => ['Ratio', 'Range']
        }
        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Dosage.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Dosage.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Dosage.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'text' => {'type'=>'string', 'path'=>'Dosage.text', 'min'=>0, 'max'=>1},
          'siteCodeableConcept' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Dosage.site[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/approach-site-codes'}},
          'siteReference' => {'type'=>'Reference', 'path'=>'Dosage.site[x]', 'min'=>0, 'max'=>1},
          'route' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Dosage.route', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/route-codes'}},
          'method' => {'local_name'=>'local_method', 'type'=>'CodeableConcept', 'path'=>'Dosage.method', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
          'quantity' => {'type'=>'Quantity', 'path'=>'Dosage.quantity', 'min'=>0, 'max'=>1},
          'rateRatio' => {'type'=>'Ratio', 'path'=>'Dosage.rate[x]', 'min'=>0, 'max'=>1},
          'rateRange' => {'type'=>'Range', 'path'=>'Dosage.rate[x]', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                  # 0-1 id
        attr_accessor :extension           # 0-* [ Extension ]
        attr_accessor :modifierExtension   # 0-* [ Extension ]
        attr_accessor :text                # 0-1 string
        attr_accessor :siteCodeableConcept # 0-1 CodeableConcept
        attr_accessor :siteReference       # 0-1 Reference()
        attr_accessor :route               # 0-1 CodeableConcept
        attr_accessor :local_method        # 0-1 CodeableConcept
        attr_accessor :quantity            # 0-1 Quantity
        attr_accessor :rateRatio           # 0-1 Ratio
        attr_accessor :rateRange           # 0-1 Range
      end

      attr_accessor :id                        # 0-1 id
      attr_accessor :meta                      # 0-1 Meta
      attr_accessor :implicitRules             # 0-1 uri
      attr_accessor :language                  # 0-1 code
      attr_accessor :text                      # 0-1 Narrative
      attr_accessor :contained                 # 0-* [ Resource ]
      attr_accessor :extension                 # 0-* [ Extension ]
      attr_accessor :modifierExtension         # 0-* [ Extension ]
      attr_accessor :identifier                # 0-* [ Identifier ]
      attr_accessor :status                    # 1-1 code
      attr_accessor :patient                   # 1-1 Reference()
      attr_accessor :practitioner              # 0-1 Reference()
      attr_accessor :encounter                 # 0-1 Reference()
      attr_accessor :prescription              # 0-1 Reference()
      attr_accessor :wasNotGiven               # 0-1 boolean
      attr_accessor :reasonNotGiven            # 0-* [ CodeableConcept ]
      attr_accessor :reasonGiven               # 0-* [ CodeableConcept ]
      attr_accessor :effectiveTimeDateTime     # 1-1 dateTime
      attr_accessor :effectiveTimePeriod       # 1-1 Period
      attr_accessor :medicationCodeableConcept # 1-1 CodeableConcept
      attr_accessor :medicationReference       # 1-1 Reference()
      attr_accessor :device                    # 0-* [ Reference() ]
      attr_accessor :note                      # 0-1 string
      attr_accessor :dosage                    # 0-1 MedicationAdministration::Dosage

      def resourceType
        'MedicationAdministration'
      end
    end
  end
end
