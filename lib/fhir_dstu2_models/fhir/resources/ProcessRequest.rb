module FHIR
  module DSTU2
    class ProcessRequest < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['action', 'identifier', 'organization', 'provider']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'ProcessRequest.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'ProcessRequest.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'ProcessRequest.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'ProcessRequest.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'ProcessRequest.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'ProcessRequest.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'ProcessRequest.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'ProcessRequest.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'action' => {'valid_codes'=>{'http://hl7.org/fhir/actionlist'=>['cancel', 'poll', 'reprocess', 'status']}, 'type'=>'code', 'path'=>'ProcessRequest.action', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/actionlist'}},
        'identifier' => {'type'=>'Identifier', 'path'=>'ProcessRequest.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'ruleset' => {'valid_codes'=>{'http://hl7.org/fhir/ruleset'=>['x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3']}, 'type'=>'Coding', 'path'=>'ProcessRequest.ruleset', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/ruleset'}},
        'originalRuleset' => {'valid_codes'=>{'http://hl7.org/fhir/ruleset'=>['x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3']}, 'type'=>'Coding', 'path'=>'ProcessRequest.originalRuleset', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/ruleset'}},
        'created' => {'type'=>'dateTime', 'path'=>'ProcessRequest.created', 'min'=>0, 'max'=>1},
        'target' => {'type'=>'Reference', 'path'=>'ProcessRequest.target', 'min'=>0, 'max'=>1},
        'provider' => {'type'=>'Reference', 'path'=>'ProcessRequest.provider', 'min'=>0, 'max'=>1},
        'organization' => {'type'=>'Reference', 'path'=>'ProcessRequest.organization', 'min'=>0, 'max'=>1},
        'request' => {'type'=>'Reference', 'path'=>'ProcessRequest.request', 'min'=>0, 'max'=>1},
        'response' => {'type'=>'Reference', 'path'=>'ProcessRequest.response', 'min'=>0, 'max'=>1},
        'nullify' => {'type'=>'boolean', 'path'=>'ProcessRequest.nullify', 'min'=>0, 'max'=>1},
        'reference' => {'type'=>'string', 'path'=>'ProcessRequest.reference', 'min'=>0, 'max'=>1},
        'item' => {'type'=>'ProcessRequest::Item', 'path'=>'ProcessRequest.item', 'min'=>0, 'max'=>Float::INFINITY},
        'include' => {'type'=>'string', 'path'=>'ProcessRequest.include', 'min'=>0, 'max'=>Float::INFINITY},
        'exclude' => {'type'=>'string', 'path'=>'ProcessRequest.exclude', 'min'=>0, 'max'=>Float::INFINITY},
        'period' => {'type'=>'Period', 'path'=>'ProcessRequest.period', 'min'=>0, 'max'=>1}
      }

      class Item < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Item.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Item.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Item.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'sequenceLinkId' => {'type'=>'integer', 'path'=>'Item.sequenceLinkId', 'min'=>1, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :sequenceLinkId    # 1-1 integer
      end

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :action            # 1-1 code
      attr_accessor :identifier        # 0-* [ Identifier ]
      attr_accessor :ruleset           # 0-1 Coding
      attr_accessor :originalRuleset   # 0-1 Coding
      attr_accessor :created           # 0-1 dateTime
      attr_accessor :target            # 0-1 Reference()
      attr_accessor :provider          # 0-1 Reference()
      attr_accessor :organization      # 0-1 Reference()
      attr_accessor :request           # 0-1 Reference()
      attr_accessor :response          # 0-1 Reference()
      attr_accessor :nullify           # 0-1 boolean
      attr_accessor :reference         # 0-1 string
      attr_accessor :item              # 0-* [ ProcessRequest::Item ]
      attr_accessor :include           # 0-* [ string ]
      attr_accessor :exclude           # 0-* [ string ]
      attr_accessor :period            # 0-1 Period

      def resourceType
        'ProcessRequest'
      end
    end
  end
end
