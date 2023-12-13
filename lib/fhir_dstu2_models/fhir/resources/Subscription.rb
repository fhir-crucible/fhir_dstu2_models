module FHIR
  module DSTU2
    class Subscription < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['contact', 'criteria', 'payload', 'status', 'tag', 'type', 'url']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Subscription.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'Subscription.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'Subscription.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'Subscription.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'Subscription.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'Subscription.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'Subscription.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Subscription.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'criteria' => {'type'=>'string', 'path'=>'Subscription.criteria', 'min'=>1, 'max'=>1},
        'contact' => {'type'=>'ContactPoint', 'path'=>'Subscription.contact', 'min'=>0, 'max'=>Float::INFINITY},
        'reason' => {'type'=>'string', 'path'=>'Subscription.reason', 'min'=>1, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/subscription-status'=>['requested', 'active', 'error', 'off']}, 'type'=>'code', 'path'=>'Subscription.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/subscription-status'}},
        'error' => {'type'=>'string', 'path'=>'Subscription.error', 'min'=>0, 'max'=>1},
        'channel' => {'type'=>'Subscription::Channel', 'path'=>'Subscription.channel', 'min'=>1, 'max'=>1},
        'end' => {'type'=>'instant', 'path'=>'Subscription.end', 'min'=>0, 'max'=>1},
        'tag' => {'valid_codes'=>{'http://hl7.org/fhir/subscription-tag'=>['queued', 'delivered']}, 'type'=>'Coding', 'path'=>'Subscription.tag', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/subscription-tag'}}
      }

      class Channel < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Channel.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Channel.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Channel.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'type' => {'valid_codes'=>{'http://hl7.org/fhir/subscription-channel-type'=>['rest-hook', 'websocket', 'email', 'sms', 'message']}, 'type'=>'code', 'path'=>'Channel.type', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/subscription-channel-type'}},
          'endpoint' => {'type'=>'uri', 'path'=>'Channel.endpoint', 'min'=>0, 'max'=>1},
          'payload' => {'type'=>'string', 'path'=>'Channel.payload', 'min'=>1, 'max'=>1},
          'header' => {'type'=>'string', 'path'=>'Channel.header', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :type              # 1-1 code
        attr_accessor :endpoint          # 0-1 uri
        attr_accessor :payload           # 1-1 string
        attr_accessor :header            # 0-1 string
      end

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :criteria          # 1-1 string
      attr_accessor :contact           # 0-* [ ContactPoint ]
      attr_accessor :reason            # 1-1 string
      attr_accessor :status            # 1-1 code
      attr_accessor :error             # 0-1 string
      attr_accessor :channel           # 1-1 Subscription::Channel
      attr_accessor :end               # 0-1 instant
      attr_accessor :tag               # 0-* [ Coding ]

      def resourceType
        'Subscription'
      end
    end
  end
end
