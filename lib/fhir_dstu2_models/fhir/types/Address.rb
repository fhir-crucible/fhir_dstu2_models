module FHIR
  module DSTU2
    class Address < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS =
        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Address.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Address.extension', 'min' => 0, 'max' => Float::INFINITY },
          'use' => { 'valid_codes' => { 'http://hl7.org/fhir/address-use' => ['home', 'work', 'temp', 'old'] }, 'type' => 'code', 'path' => 'Address.use', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/address-use' } },
          'type' => { 'valid_codes' => { 'http://hl7.org/fhir/address-type' => ['postal', 'physical', 'both'] }, 'type' => 'code', 'path' => 'Address.type', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/address-type' } },
          'text' => { 'type' => 'string', 'path' => 'Address.text', 'min' => 0, 'max' => 1 },
          'line' => { 'type' => 'string', 'path' => 'Address.line', 'min' => 0, 'max' => Float::INFINITY },
          'city' => { 'type' => 'string', 'path' => 'Address.city', 'min' => 0, 'max' => 1 },
          'district' => { 'type' => 'string', 'path' => 'Address.district', 'min' => 0, 'max' => 1 },
          'state' => { 'type' => 'string', 'path' => 'Address.state', 'min' => 0, 'max' => 1 },
          'postalCode' => { 'type' => 'string', 'path' => 'Address.postalCode', 'min' => 0, 'max' => 1 },
          'country' => { 'type' => 'string', 'path' => 'Address.country', 'min' => 0, 'max' => 1 },
          'period' => { 'type' => 'Period', 'path' => 'Address.period', 'min' => 0, 'max' => 1 }
        }

      attr_accessor :id         # 0-1 id
      attr_accessor :extension  # 0-* [ Extension ]
      attr_accessor :use        # 0-1 code
      attr_accessor :type       # 0-1 code
      attr_accessor :text       # 0-1 string
      attr_accessor :line       # 0-* [ string ]
      attr_accessor :city       # 0-1 string
      attr_accessor :district   # 0-1 string
      attr_accessor :state      # 0-1 string
      attr_accessor :postalCode # 0-1 string
      attr_accessor :country    # 0-1 string
      attr_accessor :period     # 0-1 Period
    end
  end
end
