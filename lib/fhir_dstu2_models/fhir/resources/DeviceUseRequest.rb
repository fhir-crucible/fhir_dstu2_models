module FHIR
  module DSTU2
    class DeviceUseRequest < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'bodySite' => ['CodeableConcept', 'Reference'],
        'timing' => ['Timing', 'Period', 'dateTime']
      }
      SEARCH_PARAMS = ['device', 'patient', 'subject']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'DeviceUseRequest.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'DeviceUseRequest.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'DeviceUseRequest.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'DeviceUseRequest.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'DeviceUseRequest.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'DeviceUseRequest.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'DeviceUseRequest.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'DeviceUseRequest.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'bodySiteCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'DeviceUseRequest.bodySite[x]', 'min'=>0, 'max'=>1},
        'bodySiteReference' => {'type'=>'Reference', 'path'=>'DeviceUseRequest.bodySite[x]', 'min'=>0, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/device-use-request-status'=>['proposed', 'planned', 'requested', 'received', 'accepted', 'in-progress', 'completed', 'suspended', 'rejected', 'aborted']}, 'type'=>'code', 'path'=>'DeviceUseRequest.status', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/device-use-request-status'}},
        'device' => {'type'=>'Reference', 'path'=>'DeviceUseRequest.device', 'min'=>1, 'max'=>1},
        'encounter' => {'type'=>'Reference', 'path'=>'DeviceUseRequest.encounter', 'min'=>0, 'max'=>1},
        'identifier' => {'type'=>'Identifier', 'path'=>'DeviceUseRequest.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'indication' => {'type'=>'CodeableConcept', 'path'=>'DeviceUseRequest.indication', 'min'=>0, 'max'=>Float::INFINITY},
        'notes' => {'type'=>'string', 'path'=>'DeviceUseRequest.notes', 'min'=>0, 'max'=>Float::INFINITY},
        'prnReason' => {'type'=>'CodeableConcept', 'path'=>'DeviceUseRequest.prnReason', 'min'=>0, 'max'=>Float::INFINITY},
        'orderedOn' => {'type'=>'dateTime', 'path'=>'DeviceUseRequest.orderedOn', 'min'=>0, 'max'=>1},
        'recordedOn' => {'type'=>'dateTime', 'path'=>'DeviceUseRequest.recordedOn', 'min'=>0, 'max'=>1},
        'subject' => {'type'=>'Reference', 'path'=>'DeviceUseRequest.subject', 'min'=>1, 'max'=>1},
        'timingTiming' => {'type'=>'Timing', 'path'=>'DeviceUseRequest.timing[x]', 'min'=>0, 'max'=>1},
        'timingPeriod' => {'type'=>'Period', 'path'=>'DeviceUseRequest.timing[x]', 'min'=>0, 'max'=>1},
        'timingDateTime' => {'type'=>'dateTime', 'path'=>'DeviceUseRequest.timing[x]', 'min'=>0, 'max'=>1},
        'priority' => {'valid_codes'=>{'http://hl7.org/fhir/device-use-request-priority'=>['routine', 'urgent', 'stat', 'asap']}, 'type'=>'code', 'path'=>'DeviceUseRequest.priority', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/device-use-request-priority'}}
      }

      attr_accessor :id                      # 0-1 id
      attr_accessor :meta                    # 0-1 Meta
      attr_accessor :implicitRules           # 0-1 uri
      attr_accessor :language                # 0-1 code
      attr_accessor :text                    # 0-1 Narrative
      attr_accessor :contained               # 0-* [ Resource ]
      attr_accessor :extension               # 0-* [ Extension ]
      attr_accessor :modifierExtension       # 0-* [ Extension ]
      attr_accessor :bodySiteCodeableConcept # 0-1 CodeableConcept
      attr_accessor :bodySiteReference       # 0-1 Reference()
      attr_accessor :status                  # 0-1 code
      attr_accessor :device                  # 1-1 Reference()
      attr_accessor :encounter               # 0-1 Reference()
      attr_accessor :identifier              # 0-* [ Identifier ]
      attr_accessor :indication              # 0-* [ CodeableConcept ]
      attr_accessor :notes                   # 0-* [ string ]
      attr_accessor :prnReason               # 0-* [ CodeableConcept ]
      attr_accessor :orderedOn               # 0-1 dateTime
      attr_accessor :recordedOn              # 0-1 dateTime
      attr_accessor :subject                 # 1-1 Reference()
      attr_accessor :timingTiming            # 0-1 Timing
      attr_accessor :timingPeriod            # 0-1 Period
      attr_accessor :timingDateTime          # 0-1 dateTime
      attr_accessor :priority                # 0-1 code

      def resourceType
        'DeviceUseRequest'
      end
    end
  end
end