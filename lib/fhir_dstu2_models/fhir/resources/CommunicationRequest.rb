module FHIR
  module DSTU2
    class CommunicationRequest < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'scheduled' => ['dateTime', 'Period']
      }
      SEARCH_PARAMS = ['category', 'encounter', 'identifier', 'medium', 'patient', 'priority', 'recipient', 'requested', 'requester', 'sender', 'status', 'subject', 'time']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'CommunicationRequest.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'CommunicationRequest.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'CommunicationRequest.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'CommunicationRequest.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'CommunicationRequest.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'CommunicationRequest.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'CommunicationRequest.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'CommunicationRequest.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'CommunicationRequest.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'category' => {'type'=>'CodeableConcept', 'path'=>'CommunicationRequest.category', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
        'sender' => {'type'=>'Reference', 'path'=>'CommunicationRequest.sender', 'min'=>0, 'max'=>1},
        'recipient' => {'type'=>'Reference', 'path'=>'CommunicationRequest.recipient', 'min'=>0, 'max'=>Float::INFINITY},
        'payload' => {'type'=>'CommunicationRequest::Payload', 'path'=>'CommunicationRequest.payload', 'min'=>0, 'max'=>Float::INFINITY},
        'medium' => {'valid_codes'=>{'http://hl7.org/fhir/v3/ParticipationMode'=>['ELECTRONIC', 'PHYSICAL', 'REMOTE', 'VERBAL', 'DICTATE', 'FACE', 'PHONE', 'VIDEOCONF', 'WRITTEN', 'FAXWRIT', 'HANDWRIT', 'MAILWRIT', 'ONLINEWRIT', 'EMAILWRIT', 'TYPEWRIT']}, 'type'=>'CodeableConcept', 'path'=>'CommunicationRequest.medium', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/v3-ParticipationMode'}},
        'requester' => {'type'=>'Reference', 'path'=>'CommunicationRequest.requester', 'min'=>0, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/communication-request-status'=>['proposed', 'planned', 'requested', 'received', 'accepted', 'in-progress', 'completed', 'suspended', 'rejected', 'failed']}, 'type'=>'code', 'path'=>'CommunicationRequest.status', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/communication-request-status'}},
        'encounter' => {'type'=>'Reference', 'path'=>'CommunicationRequest.encounter', 'min'=>0, 'max'=>1},
        'scheduledDateTime' => {'type'=>'dateTime', 'path'=>'CommunicationRequest.scheduled[x]', 'min'=>0, 'max'=>1},
        'scheduledPeriod' => {'type'=>'Period', 'path'=>'CommunicationRequest.scheduled[x]', 'min'=>0, 'max'=>1},
        'reason' => {'type'=>'CodeableConcept', 'path'=>'CommunicationRequest.reason', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
        'requestedOn' => {'type'=>'dateTime', 'path'=>'CommunicationRequest.requestedOn', 'min'=>0, 'max'=>1},
        'subject' => {'type'=>'Reference', 'path'=>'CommunicationRequest.subject', 'min'=>0, 'max'=>1},
        'priority' => {'valid_codes'=>{'http://hl7.org/fhir/diagnostic-order-priority'=>['routine', 'urgent', 'stat', 'asap']}, 'type'=>'CodeableConcept', 'path'=>'CommunicationRequest.priority', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/diagnostic-order-priority'}}
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
      attr_accessor :payload           # 0-* [ CommunicationRequest::Payload ]
      attr_accessor :medium            # 0-* [ CodeableConcept ]
      attr_accessor :requester         # 0-1 Reference()
      attr_accessor :status            # 0-1 code
      attr_accessor :encounter         # 0-1 Reference()
      attr_accessor :scheduledDateTime # 0-1 dateTime
      attr_accessor :scheduledPeriod   # 0-1 Period
      attr_accessor :reason            # 0-* [ CodeableConcept ]
      attr_accessor :requestedOn       # 0-1 dateTime
      attr_accessor :subject           # 0-1 Reference()
      attr_accessor :priority          # 0-1 CodeableConcept

      def resourceType
        'CommunicationRequest'
      end
    end
  end
end
