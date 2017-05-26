module FHIR
  module DSTU2
    class Communication < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['category', 'encounter', 'identifier', 'medium', 'patient', 'received', 'recipient', 'request', 'sender', 'sent', 'status', 'subject', 'category', 'encounter', 'identifier', 'medium', 'patient', 'priority', 'recipient', 'requested', 'requester', 'sender', 'status', 'subject', 'time']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Communication.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'Communication.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'Communication.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'Communication.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'Communication.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'Communication.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'Communication.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Communication.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'Communication.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'category' => {'type'=>'CodeableConcept', 'path'=>'Communication.category', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
        'sender' => {'type'=>'Reference', 'path'=>'Communication.sender', 'min'=>0, 'max'=>1},
        'recipient' => {'type'=>'Reference', 'path'=>'Communication.recipient', 'min'=>0, 'max'=>Float::INFINITY},
        'payload' => {'type'=>'Communication::Payload', 'path'=>'Communication.payload', 'min'=>0, 'max'=>Float::INFINITY},
        'medium' => {'valid_codes'=>{'http://hl7.org/fhir/v3/ParticipationMode'=>['ELECTRONIC', 'PHYSICAL', 'REMOTE', 'VERBAL', 'DICTATE', 'FACE', 'PHONE', 'VIDEOCONF', 'WRITTEN', 'FAXWRIT', 'HANDWRIT', 'MAILWRIT', 'ONLINEWRIT', 'EMAILWRIT', 'TYPEWRIT']}, 'type'=>'CodeableConcept', 'path'=>'Communication.medium', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/v3-ParticipationMode'}},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/communication-status'=>['in-progress', 'completed', 'suspended', 'rejected', 'failed']}, 'type'=>'code', 'path'=>'Communication.status', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/communication-status'}},
        'encounter' => {'type'=>'Reference', 'path'=>'Communication.encounter', 'min'=>0, 'max'=>1},
        'sent' => {'type'=>'dateTime', 'path'=>'Communication.sent', 'min'=>0, 'max'=>1},
        'received' => {'type'=>'dateTime', 'path'=>'Communication.received', 'min'=>0, 'max'=>1},
        'reason' => {'type'=>'CodeableConcept', 'path'=>'Communication.reason', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
        'subject' => {'type'=>'Reference', 'path'=>'Communication.subject', 'min'=>0, 'max'=>1},
        'requestDetail' => {'type'=>'Reference', 'path'=>'Communication.requestDetail', 'min'=>0, 'max'=>1}
      }

      class Payload < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'content' => ['string', 'Attachment', 'Reference']
        }
        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Payload.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Payload.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Payload.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'contentString' => {'type'=>'string', 'path'=>'Payload.content[x]', 'min'=>1, 'max'=>1},
          'contentAttachment' => {'type'=>'Attachment', 'path'=>'Payload.content[x]', 'min'=>1, 'max'=>1},
          'contentReference' => {'type'=>'Reference', 'path'=>'Payload.content[x]', 'min'=>1, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :contentString     # 1-1 string
        attr_accessor :contentAttachment # 1-1 Attachment
        attr_accessor :contentReference  # 1-1 Reference()
      end

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :identifier        # 0-* [ Identifier ]
      attr_accessor :category          # 0-1 CodeableConcept
      attr_accessor :sender            # 0-1 Reference()
      attr_accessor :recipient         # 0-* [ Reference() ]
      attr_accessor :payload           # 0-* [ Communication::Payload ]
      attr_accessor :medium            # 0-* [ CodeableConcept ]
      attr_accessor :status            # 0-1 code
      attr_accessor :encounter         # 0-1 Reference()
      attr_accessor :sent              # 0-1 dateTime
      attr_accessor :received          # 0-1 dateTime
      attr_accessor :reason            # 0-* [ CodeableConcept ]
      attr_accessor :subject           # 0-1 Reference()
      attr_accessor :requestDetail     # 0-1 Reference()

      def resourceType
        'Communication'
      end
    end
  end
end