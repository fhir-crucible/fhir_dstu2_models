module FHIR
  module DSTU2
    class DeviceUseStatement < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'bodySite' => ['CodeableConcept', 'Reference'],
        'timing' => ['Timing', 'Period', 'dateTime']
      }
      SEARCH_PARAMS = ['device', 'patient', 'subject']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'DeviceUseStatement.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'DeviceUseStatement.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'DeviceUseStatement.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'DeviceUseStatement.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'DeviceUseStatement.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'DeviceUseStatement.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'DeviceUseStatement.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'DeviceUseStatement.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'bodySiteCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'DeviceUseStatement.bodySite[x]', 'min'=>0, 'max'=>1},
        'bodySiteReference' => {'type'=>'Reference', 'path'=>'DeviceUseStatement.bodySite[x]', 'min'=>0, 'max'=>1},
        'whenUsed' => {'type'=>'Period', 'path'=>'DeviceUseStatement.whenUsed', 'min'=>0, 'max'=>1},
        'device' => {'type'=>'Reference', 'path'=>'DeviceUseStatement.device', 'min'=>1, 'max'=>1},
        'identifier' => {'type'=>'Identifier', 'path'=>'DeviceUseStatement.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'indication' => {'type'=>'CodeableConcept', 'path'=>'DeviceUseStatement.indication', 'min'=>0, 'max'=>Float::INFINITY},
        'notes' => {'type'=>'string', 'path'=>'DeviceUseStatement.notes', 'min'=>0, 'max'=>Float::INFINITY},
        'recordedOn' => {'type'=>'dateTime', 'path'=>'DeviceUseStatement.recordedOn', 'min'=>0, 'max'=>1},
        'subject' => {'type'=>'Reference', 'path'=>'DeviceUseStatement.subject', 'min'=>1, 'max'=>1},
        'timingTiming' => {'type'=>'Timing', 'path'=>'DeviceUseStatement.timing[x]', 'min'=>0, 'max'=>1},
        'timingPeriod' => {'type'=>'Period', 'path'=>'DeviceUseStatement.timing[x]', 'min'=>0, 'max'=>1},
        'timingDateTime' => {'type'=>'dateTime', 'path'=>'DeviceUseStatement.timing[x]', 'min'=>0, 'max'=>1}
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
      attr_accessor :whenUsed                # 0-1 Period
      attr_accessor :device                  # 1-1 Reference()
      attr_accessor :identifier              # 0-* [ Identifier ]
      attr_accessor :indication              # 0-* [ CodeableConcept ]
      attr_accessor :notes                   # 0-* [ string ]
      attr_accessor :recordedOn              # 0-1 dateTime
      attr_accessor :subject                 # 1-1 Reference()
      attr_accessor :timingTiming            # 0-1 Timing
      attr_accessor :timingPeriod            # 0-1 Period
      attr_accessor :timingDateTime          # 0-1 dateTime

      def resourceType
        'DeviceUseStatement'
      end
    end
  end
end