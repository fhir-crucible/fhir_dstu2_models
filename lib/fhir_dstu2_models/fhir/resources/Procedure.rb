module FHIR
  module DSTU2
    class Procedure < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'reason' => ['CodeableConcept', 'Reference'],
        'performed' => ['dateTime', 'Period']
      }
      SEARCH_PARAMS = ['encounter', 'identifier', 'orderer', 'patient', 'performer', 'subject', 'code', 'date', 'encounter', 'identifier', 'location', 'patient', 'performer', 'subject']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Procedure.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'Procedure.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'Procedure.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'Procedure.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'Procedure.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'Procedure.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'Procedure.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Procedure.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'Procedure.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'subject' => {'type'=>'Reference', 'path'=>'Procedure.subject', 'min'=>1, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/procedure-status'=>['in-progress', 'aborted', 'completed', 'entered-in-error']}, 'type'=>'code', 'path'=>'Procedure.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/procedure-status'}},
        'category' => {'valid_codes'=>{'http://snomed.info/sct'=>['24642003', '409063005', '409073007', '387713003', '103693007', '46947000']}, 'type'=>'CodeableConcept', 'path'=>'Procedure.category', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/procedure-category'}},
        'code' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Procedure.code', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/procedure-code'}},
        'notPerformed' => {'type'=>'boolean', 'path'=>'Procedure.notPerformed', 'min'=>0, 'max'=>1},
        'reasonNotPerformed' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Procedure.reasonNotPerformed', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/procedure-not-performed-reason'}},
        'bodySite' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Procedure.bodySite', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/body-site'}},
        'reasonCodeableConcept' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Procedure.reason[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/procedure-reason'}},
        'reasonReference' => {'type'=>'Reference', 'path'=>'Procedure.reason[x]', 'min'=>0, 'max'=>1},
        'performer' => {'type'=>'Procedure::Performer', 'path'=>'Procedure.performer', 'min'=>0, 'max'=>Float::INFINITY},
        'performedDateTime' => {'type'=>'dateTime', 'path'=>'Procedure.performed[x]', 'min'=>0, 'max'=>1},
        'performedPeriod' => {'type'=>'Period', 'path'=>'Procedure.performed[x]', 'min'=>0, 'max'=>1},
        'encounter' => {'type'=>'Reference', 'path'=>'Procedure.encounter', 'min'=>0, 'max'=>1},
        'location' => {'type'=>'Reference', 'path'=>'Procedure.location', 'min'=>0, 'max'=>1},
        'outcome' => {'valid_codes'=>{'http://snomed.info/sct'=>['385669000', '385671000', '385670004']}, 'type'=>'CodeableConcept', 'path'=>'Procedure.outcome', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/procedure-outcome'}},
        'report' => {'type'=>'Reference', 'path'=>'Procedure.report', 'min'=>0, 'max'=>Float::INFINITY},
        'complication' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Procedure.complication', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/condition-code'}},
        'followUp' => {'valid_codes'=>{'http://snomed.info/sct'=>['18949003', '30549001', '241031001', '35963001', '225164002', '447346005', '229506003', '274441001', '394725008', '359825008']}, 'type'=>'CodeableConcept', 'path'=>'Procedure.followUp', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/procedure-followup'}},
        'request' => {'type'=>'Reference', 'path'=>'Procedure.request', 'min'=>0, 'max'=>1},
        'notes' => {'type'=>'Annotation', 'path'=>'Procedure.notes', 'min'=>0, 'max'=>Float::INFINITY},
        'focalDevice' => {'type'=>'Procedure::FocalDevice', 'path'=>'Procedure.focalDevice', 'min'=>0, 'max'=>Float::INFINITY},
        'used' => {'type'=>'Reference', 'path'=>'Procedure.used', 'min'=>0, 'max'=>Float::INFINITY}
      }

      class Performer < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Performer.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Performer.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Performer.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'actor' => {'type'=>'Reference', 'path'=>'Performer.actor', 'min'=>0, 'max'=>1},
          'role' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Performer.role', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/performer-role'}}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :actor             # 0-1 Reference()
        attr_accessor :role              # 0-1 CodeableConcept
      end

      class FocalDevice < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'FocalDevice.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'FocalDevice.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'FocalDevice.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'action' => {'valid_codes'=>{'http://hl7.org/fhir/device-action'=>['implanted', 'explanted', 'manipulated']}, 'type'=>'CodeableConcept', 'path'=>'FocalDevice.action', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/device-action'}},
          'manipulated' => {'type'=>'Reference', 'path'=>'FocalDevice.manipulated', 'min'=>1, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :action            # 0-1 CodeableConcept
        attr_accessor :manipulated       # 1-1 Reference()
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
      attr_accessor :subject               # 1-1 Reference()
      attr_accessor :status                # 1-1 code
      attr_accessor :category              # 0-1 CodeableConcept
      attr_accessor :code                  # 1-1 CodeableConcept
      attr_accessor :notPerformed          # 0-1 boolean
      attr_accessor :reasonNotPerformed    # 0-* [ CodeableConcept ]
      attr_accessor :bodySite              # 0-* [ CodeableConcept ]
      attr_accessor :reasonCodeableConcept # 0-1 CodeableConcept
      attr_accessor :reasonReference       # 0-1 Reference()
      attr_accessor :performer             # 0-* [ Procedure::Performer ]
      attr_accessor :performedDateTime     # 0-1 dateTime
      attr_accessor :performedPeriod       # 0-1 Period
      attr_accessor :encounter             # 0-1 Reference()
      attr_accessor :location              # 0-1 Reference()
      attr_accessor :outcome               # 0-1 CodeableConcept
      attr_accessor :report                # 0-* [ Reference() ]
      attr_accessor :complication          # 0-* [ CodeableConcept ]
      attr_accessor :followUp              # 0-* [ CodeableConcept ]
      attr_accessor :request               # 0-1 Reference()
      attr_accessor :notes                 # 0-* [ Annotation ]
      attr_accessor :focalDevice           # 0-* [ Procedure::FocalDevice ]
      attr_accessor :used                  # 0-* [ Reference() ]

      def resourceType
        'Procedure'
      end
    end
  end
end
