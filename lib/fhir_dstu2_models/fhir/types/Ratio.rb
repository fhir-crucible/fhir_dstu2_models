module FHIR
  module DSTU2
    class Ratio < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS =
        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Ratio.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Ratio.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'numerator' => {'type'=>'Quantity', 'path'=>'Ratio.numerator', 'min'=>0, 'max'=>1},
          'denominator' => {'type'=>'Quantity', 'path'=>'Ratio.denominator', 'min'=>0, 'max'=>1}
        }

      attr_accessor :id          # 0-1 id
      attr_accessor :extension   # 0-* [ Extension ]
      attr_accessor :numerator   # 0-1 Quantity
      attr_accessor :denominator # 0-1 Quantity
    end
  end
end
