module FHIR
  module DSTU2
    class Quantity < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS =
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Quantity.id', 'min'=>0, 'max'=>1},
        'extension' => {'type'=>'Extension', 'path'=>'Quantity.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'value' => {'type'=>'decimal', 'path'=>'Quantity.value', 'min'=>0, 'max'=>1},
        'comparator' => {'valid_codes'=>{'http://hl7.org/fhir/quantity-comparator'=>['<', '<=', '>=', '>']}, 'type'=>'code', 'path'=>'Quantity.comparator', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/quantity-comparator'}},
        'unit' => {'type'=>'string', 'path'=>'Quantity.unit', 'min'=>0, 'max'=>1},
        'system' => {'type'=>'uri', 'path'=>'Quantity.system', 'min'=>0, 'max'=>1},
        'code' => {'type'=>'code', 'path'=>'Quantity.code', 'min'=>0, 'max'=>1}
      }

      attr_accessor :id         # 0-1 id
      attr_accessor :extension  # 0-* [ Extension ]
      attr_accessor :value      # 0-1 decimal
      attr_accessor :comparator # 0-1 code
      attr_accessor :unit       # 0-1 string
      attr_accessor :system     # 0-1 uri
      attr_accessor :code       # 0-1 code
    end
  end
end
