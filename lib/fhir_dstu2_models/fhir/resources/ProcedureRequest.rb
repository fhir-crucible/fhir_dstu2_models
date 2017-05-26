module FHIR
  module DSTU2
    class ProcedureRequest < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'reason' => ['CodeableConcept', 'Reference'],
        'scheduled' => ['dateTime', 'Period', 'Timing'],
        'asNeeded' => ['boolean', 'CodeableConcept']
      }
      SEARCH_PARAMS = ['encounter', 'identifier', 'orderer', 'patient', 'performer', 'subject']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'ProcedureRequest.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'ProcedureRequest.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'ProcedureRequest.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'ProcedureRequest.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'ProcedureRequest.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'ProcedureRequest.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'ProcedureRequest.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'ProcedureRequest.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'ProcedureRequest.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'subject' => {'type'=>'Reference', 'path'=>'ProcedureRequest.subject', 'min'=>1, 'max'=>1},
        'code' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'ProcedureRequest.code', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/procedure-code'}},
        'bodySite' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'ProcedureRequest.bodySite', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/body-site'}},
        'reasonCodeableConcept' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'ProcedureRequest.reason[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/procedure-reason'}},
        'reasonReference' => {'type'=>'Reference', 'path'=>'ProcedureRequest.reason[x]', 'min'=>0, 'max'=>1},
        'scheduledDateTime' => {'type'=>'dateTime', 'path'=>'ProcedureRequest.scheduled[x]', 'min'=>0, 'max'=>1},
        'scheduledPeriod' => {'type'=>'Period', 'path'=>'ProcedureRequest.scheduled[x]', 'min'=>0, 'max'=>1},
        'scheduledTiming' => {'type'=>'Timing', 'path'=>'ProcedureRequest.scheduled[x]', 'min'=>0, 'max'=>1},
        'encounter' => {'type'=>'Reference', 'path'=>'ProcedureRequest.encounter', 'min'=>0, 'max'=>1},
        'performer' => {'type'=>'Reference', 'path'=>'ProcedureRequest.performer', 'min'=>0, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/procedure-request-status'=>['proposed', 'draft', 'requested', 'received', 'accepted', 'in-progress', 'completed', 'suspended', 'rejected', 'aborted']}, 'type'=>'code', 'path'=>'ProcedureRequest.status', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/procedure-request-status'}},
        'notes' => {'type'=>'Annotation', 'path'=>'ProcedureRequest.notes', 'min'=>0, 'max'=>Float::INFINITY},
        'asNeededBoolean' => {'type'=>'boolean', 'path'=>'ProcedureRequest.asNeeded[x]', 'min'=>0, 'max'=>1},
        'asNeededCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'ProcedureRequest.asNeeded[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
        'orderedOn' => {'type'=>'dateTime', 'path'=>'ProcedureRequest.orderedOn', 'min'=>0, 'max'=>1},
        'orderer' => {'type'=>'Reference', 'path'=>'ProcedureRequest.orderer', 'min'=>0, 'max'=>1},
        'priority' => {'valid_codes'=>{'http://hl7.org/fhir/procedure-request-priority'=>['routine', 'urgent', 'stat', 'asap']}, 'type'=>'code', 'path'=>'ProcedureRequest.priority', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/procedure-request-priority'}}
      }

      attr_accessor :id                      # 0-1 id
      attr_accessor :meta                    # 0-1 Meta
      attr_accessor :implicitRules           # 0-1 uri
      attr_accessor :language                # 0-1 code
      attr_accessor :text                    # 0-1 Narrative
      attr_accessor :contained               # 0-* [ Resource ]
      attr_accessor :extension               # 0-* [ Extension ]
      attr_accessor :modifierExtension       # 0-* [ Extension ]
      attr_accessor :identifier              # 0-* [ Identifier ]
      attr_accessor :subject                 # 1-1 Reference()
      attr_accessor :code                    # 1-1 CodeableConcept
      attr_accessor :bodySite                # 0-* [ CodeableConcept ]
      attr_accessor :reasonCodeableConcept   # 0-1 CodeableConcept
      attr_accessor :reasonReference         # 0-1 Reference()
      attr_accessor :scheduledDateTime       # 0-1 dateTime
      attr_accessor :scheduledPeriod         # 0-1 Period
      attr_accessor :scheduledTiming         # 0-1 Timing
      attr_accessor :encounter               # 0-1 Reference()
      attr_accessor :performer               # 0-1 Reference()
      attr_accessor :status                  # 0-1 code
      attr_accessor :notes                   # 0-* [ Annotation ]
      attr_accessor :asNeededBoolean         # 0-1 boolean
      attr_accessor :asNeededCodeableConcept # 0-1 CodeableConcept
      attr_accessor :orderedOn               # 0-1 dateTime
      attr_accessor :orderer                 # 0-1 Reference()
      attr_accessor :priority                # 0-1 code

      def resourceType
        'ProcedureRequest'
      end
    end
  end
end