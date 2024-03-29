module FHIR
  module DSTU2
    class CodeableConcept < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS =
        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'CodeableConcept.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'CodeableConcept.extension', 'min' => 0, 'max' => Float::INFINITY },
          'coding' => { 'type' => 'Coding', 'path' => 'CodeableConcept.coding', 'min' => 0, 'max' => Float::INFINITY },
          'text' => { 'type' => 'string', 'path' => 'CodeableConcept.text', 'min' => 0, 'max' => 1 }
        }

      attr_accessor :id        # 0-1 id
      attr_accessor :extension # 0-* [ Extension ]
      attr_accessor :coding    # 0-* [ Coding ]
      attr_accessor :text      # 0-1 string
    end
  end
end
