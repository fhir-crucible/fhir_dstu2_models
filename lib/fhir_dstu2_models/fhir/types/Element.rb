module FHIR
  module DSTU2
    class Element < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['code', 'context', 'date', 'description', 'identifier', 'name', 'publisher', 'status', 'stringency', 'url', 'version']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Element.id', 'min'=>0, 'max'=>1},
        'extension' => {'type'=>'Extension', 'path'=>'Element.extension', 'min'=>0, 'max'=>Float::INFINITY}
      }

      attr_accessor :id        # 0-1 id
      attr_accessor :extension # 0-* [ Extension ]
    end
  end
end