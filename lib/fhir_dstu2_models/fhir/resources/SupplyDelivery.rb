module FHIR
  module DSTU2
    class SupplyDelivery < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['identifier', 'patient', 'receiver', 'status', 'supplier']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'SupplyDelivery.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'SupplyDelivery.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'SupplyDelivery.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'SupplyDelivery.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'SupplyDelivery.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'SupplyDelivery.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'SupplyDelivery.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'SupplyDelivery.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'SupplyDelivery.identifier', 'min'=>0, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/supplydelivery-status'=>['in-progress', 'completed', 'abandoned']}, 'type'=>'code', 'path'=>'SupplyDelivery.status', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/supplydelivery-status'}},
        'patient' => {'type'=>'Reference', 'path'=>'SupplyDelivery.patient', 'min'=>0, 'max'=>1},
        'type' => {'valid_codes'=>{'http://hl7.org/fhir/supply-item-type'=>['medication', 'device']}, 'type'=>'CodeableConcept', 'path'=>'SupplyDelivery.type', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/supplydelivery-type'}},
        'quantity' => {'type'=>'Quantity', 'path'=>'SupplyDelivery.quantity', 'min'=>0, 'max'=>1},
        'suppliedItem' => {'type'=>'Reference', 'path'=>'SupplyDelivery.suppliedItem', 'min'=>0, 'max'=>1},
        'supplier' => {'type'=>'Reference', 'path'=>'SupplyDelivery.supplier', 'min'=>0, 'max'=>1},
        'whenPrepared' => {'type'=>'Period', 'path'=>'SupplyDelivery.whenPrepared', 'min'=>0, 'max'=>1},
        'time' => {'type'=>'dateTime', 'path'=>'SupplyDelivery.time', 'min'=>0, 'max'=>1},
        'destination' => {'type'=>'Reference', 'path'=>'SupplyDelivery.destination', 'min'=>0, 'max'=>1},
        'receiver' => {'type'=>'Reference', 'path'=>'SupplyDelivery.receiver', 'min'=>0, 'max'=>Float::INFINITY}
      }

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :identifier        # 0-1 Identifier
      attr_accessor :status            # 0-1 code
      attr_accessor :patient           # 0-1 Reference()
      attr_accessor :type              # 0-1 CodeableConcept
      attr_accessor :quantity          # 0-1 Quantity
      attr_accessor :suppliedItem      # 0-1 Reference()
      attr_accessor :supplier          # 0-1 Reference()
      attr_accessor :whenPrepared      # 0-1 Period
      attr_accessor :time              # 0-1 dateTime
      attr_accessor :destination       # 0-1 Reference()
      attr_accessor :receiver          # 0-* [ Reference() ]

      def resourceType
        'SupplyDelivery'
      end
    end
  end
end