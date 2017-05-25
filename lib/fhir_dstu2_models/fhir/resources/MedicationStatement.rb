module FHIR
  module DSTU2
    class MedicationStatement < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'reasonForUse' => ['CodeableConcept', 'Reference'],
        'effective' => ['dateTime', 'Period'],
        'medication' => ['CodeableConcept', 'Reference']
      }
      SEARCH_PARAMS = ['code', 'effectivedate', 'identifier', 'medication', 'patient', 'source', 'status']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'MedicationStatement.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'MedicationStatement.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'MedicationStatement.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'MedicationStatement.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'MedicationStatement.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'MedicationStatement.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'MedicationStatement.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'MedicationStatement.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'MedicationStatement.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'patient' => {'type'=>'Reference', 'path'=>'MedicationStatement.patient', 'min'=>1, 'max'=>1},
        'informationSource' => {'type'=>'Reference', 'path'=>'MedicationStatement.informationSource', 'min'=>0, 'max'=>1},
        'dateAsserted' => {'type'=>'dateTime', 'path'=>'MedicationStatement.dateAsserted', 'min'=>0, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/medication-statement-status'=>['active', 'completed', 'entered-in-error', 'intended']}, 'type'=>'code', 'path'=>'MedicationStatement.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/medication-statement-status'}},
        'wasNotTaken' => {'type'=>'boolean', 'path'=>'MedicationStatement.wasNotTaken', 'min'=>0, 'max'=>1},
        'reasonNotTaken' => {'valid_codes'=>{'http://hl7.org/fhir/reason-medication-not-given'=>['a', 'b', 'c', 'd']}, 'type'=>'CodeableConcept', 'path'=>'MedicationStatement.reasonNotTaken', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/reason-medication-not-given-codes'}},
        'reasonForUseCodeableConcept' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'MedicationStatement.reasonForUse[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/condition-code'}},
        'reasonForUseReference' => {'type'=>'Reference', 'path'=>'MedicationStatement.reasonForUse[x]', 'min'=>0, 'max'=>1},
        'effectiveDateTime' => {'type'=>'dateTime', 'path'=>'MedicationStatement.effective[x]', 'min'=>0, 'max'=>1},
        'effectivePeriod' => {'type'=>'Period', 'path'=>'MedicationStatement.effective[x]', 'min'=>0, 'max'=>1},
        'note' => {'type'=>'string', 'path'=>'MedicationStatement.note', 'min'=>0, 'max'=>1},
        'supportingInformation' => {'type'=>'Reference', 'path'=>'MedicationStatement.supportingInformation', 'min'=>0, 'max'=>Float::INFINITY},
        'medicationCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'MedicationStatement.medication[x]', 'min'=>1, 'max'=>1},
        'medicationReference' => {'type'=>'Reference', 'path'=>'MedicationStatement.medication[x]', 'min'=>1, 'max'=>1},
        'dosage' => {'type'=>'MedicationStatement::Dosage', 'path'=>'MedicationStatement.dosage', 'min'=>0, 'max'=>Float::INFINITY}
      }

      class Dosage < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'asNeeded' => ['boolean', 'CodeableConcept'],
          'site' => ['CodeableConcept', 'Reference'],
          'quantity' => ['Quantity', 'Range'],
          'rate' => ['Ratio', 'Range']
        }
        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Dosage.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Dosage.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Dosage.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'text' => {'type'=>'string', 'path'=>'Dosage.text', 'min'=>0, 'max'=>1},
          'timing' => {'type'=>'Timing', 'path'=>'Dosage.timing', 'min'=>0, 'max'=>1},
          'asNeededBoolean' => {'type'=>'boolean', 'path'=>'Dosage.asNeeded[x]', 'min'=>0, 'max'=>1},
          'asNeededCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'Dosage.asNeeded[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
          'siteCodeableConcept' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Dosage.site[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/approach-site-codes'}},
          'siteReference' => {'type'=>'Reference', 'path'=>'Dosage.site[x]', 'min'=>0, 'max'=>1},
          'route' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Dosage.route', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/route-codes'}},
          'method' => {'local_name'=>'local_method', 'type'=>'CodeableConcept', 'path'=>'Dosage.method', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
          'quantityQuantity' => {'type'=>'Quantity', 'path'=>'Dosage.quantity[x]', 'min'=>0, 'max'=>1},
          'quantityRange' => {'type'=>'Range', 'path'=>'Dosage.quantity[x]', 'min'=>0, 'max'=>1},
          'rateRatio' => {'type'=>'Ratio', 'path'=>'Dosage.rate[x]', 'min'=>0, 'max'=>1},
          'rateRange' => {'type'=>'Range', 'path'=>'Dosage.rate[x]', 'min'=>0, 'max'=>1},
          'maxDosePerPeriod' => {'type'=>'Ratio', 'path'=>'Dosage.maxDosePerPeriod', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                      # 0-1 id
        attr_accessor :extension               # 0-* [ Extension ]
        attr_accessor :modifierExtension       # 0-* [ Extension ]
        attr_accessor :text                    # 0-1 string
        attr_accessor :timing                  # 0-1 Timing
        attr_accessor :asNeededBoolean         # 0-1 boolean
        attr_accessor :asNeededCodeableConcept # 0-1 CodeableConcept
        attr_accessor :siteCodeableConcept     # 0-1 CodeableConcept
        attr_accessor :siteReference           # 0-1 Reference()
        attr_accessor :route                   # 0-1 CodeableConcept
        attr_accessor :local_method            # 0-1 CodeableConcept
        attr_accessor :quantityQuantity        # 0-1 Quantity
        attr_accessor :quantityRange           # 0-1 Range
        attr_accessor :rateRatio               # 0-1 Ratio
        attr_accessor :rateRange               # 0-1 Range
        attr_accessor :maxDosePerPeriod        # 0-1 Ratio
      end

      attr_accessor :id                          # 0-1 id
      attr_accessor :meta                        # 0-1 Meta
      attr_accessor :implicitRules               # 0-1 uri
      attr_accessor :language                    # 0-1 code
      attr_accessor :text                        # 0-1 Narrative
      attr_accessor :contained                   # 0-* [ Resource ]
      attr_accessor :extension                   # 0-* [ Extension ]
      attr_accessor :modifierExtension           # 0-* [ Extension ]
      attr_accessor :identifier                  # 0-* [ Identifier ]
      attr_accessor :patient                     # 1-1 Reference()
      attr_accessor :informationSource           # 0-1 Reference()
      attr_accessor :dateAsserted                # 0-1 dateTime
      attr_accessor :status                      # 1-1 code
      attr_accessor :wasNotTaken                 # 0-1 boolean
      attr_accessor :reasonNotTaken              # 0-* [ CodeableConcept ]
      attr_accessor :reasonForUseCodeableConcept # 0-1 CodeableConcept
      attr_accessor :reasonForUseReference       # 0-1 Reference()
      attr_accessor :effectiveDateTime           # 0-1 dateTime
      attr_accessor :effectivePeriod             # 0-1 Period
      attr_accessor :note                        # 0-1 string
      attr_accessor :supportingInformation       # 0-* [ Reference() ]
      attr_accessor :medicationCodeableConcept   # 1-1 CodeableConcept
      attr_accessor :medicationReference         # 1-1 Reference()
      attr_accessor :dosage                      # 0-* [ MedicationStatement::Dosage ]

      def resourceType
        'MedicationStatement'
      end
    end
  end
end