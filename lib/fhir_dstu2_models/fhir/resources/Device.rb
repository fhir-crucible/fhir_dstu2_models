module FHIR
  module DSTU2
    class Device < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['parent', 'source', 'type', 'category', 'identifier', 'parent', 'source', 'type', 'identifier', 'location', 'manufacturer', 'model', 'organization', 'patient', 'type', 'udi', 'url', 'device', 'patient', 'subject', 'device', 'patient', 'subject']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Device.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'Device.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'Device.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'Device.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'Device.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'Device.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'Device.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Device.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'Device.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'type' => {'type'=>'CodeableConcept', 'path'=>'Device.type', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'preferred', 'uri'=>'https://www.gmdnagency.org/Info.aspx?pageid=1091'}},
        'note' => {'type'=>'Annotation', 'path'=>'Device.note', 'min'=>0, 'max'=>Float::INFINITY},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/devicestatus'=>['available', 'not-available', 'entered-in-error']}, 'type'=>'code', 'path'=>'Device.status', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/devicestatus'}},
        'manufacturer' => {'type'=>'string', 'path'=>'Device.manufacturer', 'min'=>0, 'max'=>1},
        'model' => {'type'=>'string', 'path'=>'Device.model', 'min'=>0, 'max'=>1},
        'version' => {'type'=>'string', 'path'=>'Device.version', 'min'=>0, 'max'=>1},
        'manufactureDate' => {'type'=>'dateTime', 'path'=>'Device.manufactureDate', 'min'=>0, 'max'=>1},
        'expiry' => {'type'=>'dateTime', 'path'=>'Device.expiry', 'min'=>0, 'max'=>1},
        'udi' => {'type'=>'string', 'path'=>'Device.udi', 'min'=>0, 'max'=>1},
        'lotNumber' => {'type'=>'string', 'path'=>'Device.lotNumber', 'min'=>0, 'max'=>1},
        'owner' => {'type'=>'Reference', 'path'=>'Device.owner', 'min'=>0, 'max'=>1},
        'location' => {'type'=>'Reference', 'path'=>'Device.location', 'min'=>0, 'max'=>1},
        'patient' => {'type'=>'Reference', 'path'=>'Device.patient', 'min'=>0, 'max'=>1},
        'contact' => {'type'=>'ContactPoint', 'path'=>'Device.contact', 'min'=>0, 'max'=>Float::INFINITY},
        'url' => {'type'=>'uri', 'path'=>'Device.url', 'min'=>0, 'max'=>1}
      }

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :identifier        # 0-* [ Identifier ]
      attr_accessor :type              # 1-1 CodeableConcept
      attr_accessor :note              # 0-* [ Annotation ]
      attr_accessor :status            # 0-1 code
      attr_accessor :manufacturer      # 0-1 string
      attr_accessor :model             # 0-1 string
      attr_accessor :version           # 0-1 string
      attr_accessor :manufactureDate   # 0-1 dateTime
      attr_accessor :expiry            # 0-1 dateTime
      attr_accessor :udi               # 0-1 string
      attr_accessor :lotNumber         # 0-1 string
      attr_accessor :owner             # 0-1 Reference()
      attr_accessor :location          # 0-1 Reference()
      attr_accessor :patient           # 0-1 Reference()
      attr_accessor :contact           # 0-* [ ContactPoint ]
      attr_accessor :url               # 0-1 uri

      def resourceType
        'Device'
      end
    end
  end
end
