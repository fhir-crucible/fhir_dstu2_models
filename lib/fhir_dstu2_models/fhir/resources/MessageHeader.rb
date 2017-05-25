module FHIR
  module DSTU2
    class MessageHeader < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['author', 'code', 'data', 'destination', 'destination-uri', 'enterer', 'event', 'receiver', 'response-id', 'responsible', 'source', 'source-uri', 'target', 'timestamp']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'MessageHeader.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'MessageHeader.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'MessageHeader.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'MessageHeader.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'MessageHeader.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'MessageHeader.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'MessageHeader.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'MessageHeader.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'timestamp' => {'type'=>'instant', 'path'=>'MessageHeader.timestamp', 'min'=>1, 'max'=>1},
        'event' => {'valid_codes'=>{'http://hl7.org/fhir/message-events'=>['MedicationAdministration-Complete', 'MedicationAdministration-Nullification', 'MedicationAdministration-Recording', 'MedicationAdministration-Update', 'admin-notify', 'diagnosticreport-provide', 'observation-provide', 'patient-link', 'patient-unlink', 'valueset-expand']}, 'type'=>'Coding', 'path'=>'MessageHeader.event', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'preferred', 'uri'=>'http://hl7.org/fhir/ValueSet/message-events'}},
        'response' => {'type'=>'MessageHeader::Response', 'path'=>'MessageHeader.response', 'min'=>0, 'max'=>1},
        'source' => {'type'=>'MessageHeader::Source', 'path'=>'MessageHeader.source', 'min'=>1, 'max'=>1},
        'destination' => {'type'=>'MessageHeader::Destination', 'path'=>'MessageHeader.destination', 'min'=>0, 'max'=>Float::INFINITY},
        'enterer' => {'type'=>'Reference', 'path'=>'MessageHeader.enterer', 'min'=>0, 'max'=>1},
        'author' => {'type'=>'Reference', 'path'=>'MessageHeader.author', 'min'=>0, 'max'=>1},
        'receiver' => {'type'=>'Reference', 'path'=>'MessageHeader.receiver', 'min'=>0, 'max'=>1},
        'responsible' => {'type'=>'Reference', 'path'=>'MessageHeader.responsible', 'min'=>0, 'max'=>1},
        'reason' => {'valid_codes'=>{'http://hl7.org/fhir/message-reasons-encounter'=>['admit', 'discharge', 'absent', 'return', 'moved', 'edit']}, 'type'=>'CodeableConcept', 'path'=>'MessageHeader.reason', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/message-reason-encounter'}},
        'data' => {'type'=>'Reference', 'path'=>'MessageHeader.data', 'min'=>0, 'max'=>Float::INFINITY}
      }

      class Response < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Response.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Response.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Response.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'identifier' => {'type'=>'id', 'path'=>'Response.identifier', 'min'=>1, 'max'=>1},
          'code' => {'valid_codes'=>{'http://hl7.org/fhir/response-code'=>['ok', 'transient-error', 'fatal-error']}, 'type'=>'code', 'path'=>'Response.code', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/response-code'}},
          'details' => {'type'=>'Reference', 'path'=>'Response.details', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :identifier        # 1-1 id
        attr_accessor :code              # 1-1 code
        attr_accessor :details           # 0-1 Reference()
      end

      class Source < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Source.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Source.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Source.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'name' => {'type'=>'string', 'path'=>'Source.name', 'min'=>0, 'max'=>1},
          'software' => {'type'=>'string', 'path'=>'Source.software', 'min'=>0, 'max'=>1},
          'version' => {'type'=>'string', 'path'=>'Source.version', 'min'=>0, 'max'=>1},
          'contact' => {'type'=>'ContactPoint', 'path'=>'Source.contact', 'min'=>0, 'max'=>1},
          'endpoint' => {'type'=>'uri', 'path'=>'Source.endpoint', 'min'=>1, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :name              # 0-1 string
        attr_accessor :software          # 0-1 string
        attr_accessor :version           # 0-1 string
        attr_accessor :contact           # 0-1 ContactPoint
        attr_accessor :endpoint          # 1-1 uri
      end

      class Destination < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Destination.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Destination.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Destination.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'name' => {'type'=>'string', 'path'=>'Destination.name', 'min'=>0, 'max'=>1},
          'target' => {'type'=>'Reference', 'path'=>'Destination.target', 'min'=>0, 'max'=>1},
          'endpoint' => {'type'=>'uri', 'path'=>'Destination.endpoint', 'min'=>1, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :name              # 0-1 string
        attr_accessor :target            # 0-1 Reference()
        attr_accessor :endpoint          # 1-1 uri
      end

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :timestamp         # 1-1 instant
      attr_accessor :event             # 1-1 Coding
      attr_accessor :response          # 0-1 MessageHeader::Response
      attr_accessor :source            # 1-1 MessageHeader::Source
      attr_accessor :destination       # 0-* [ MessageHeader::Destination ]
      attr_accessor :enterer           # 0-1 Reference()
      attr_accessor :author            # 0-1 Reference()
      attr_accessor :receiver          # 0-1 Reference()
      attr_accessor :responsible       # 0-1 Reference()
      attr_accessor :reason            # 0-1 CodeableConcept
      attr_accessor :data              # 0-* [ Reference() ]

      def resourceType
        'MessageHeader'
      end
    end
  end
end