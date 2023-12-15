module FHIR
  module DSTU2
    class Organization < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['active', 'address', 'address-city', 'address-country', 'address-postalcode', 'address-state', 'address-use', 'identifier', 'name', 'partof', 'phonetic', 'type']
      METADATA = {
        'id' => { 'type' => 'id', 'path' => 'Organization.id', 'min' => 0, 'max' => 1 },
        'meta' => { 'type' => 'Meta', 'path' => 'Organization.meta', 'min' => 0, 'max' => 1 },
        'implicitRules' => { 'type' => 'uri', 'path' => 'Organization.implicitRules', 'min' => 0, 'max' => 1 },
        'language' => { 'type' => 'code', 'path' => 'Organization.language', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://tools.ietf.org/html/bcp47' } },
        'text' => { 'type' => 'Narrative', 'path' => 'Organization.text', 'min' => 0, 'max' => 1 },
        'contained' => { 'type' => 'Resource', 'path' => 'Organization.contained', 'min' => 0, 'max' => Float::INFINITY },
        'extension' => { 'type' => 'Extension', 'path' => 'Organization.extension', 'min' => 0, 'max' => Float::INFINITY },
        'modifierExtension' => { 'type' => 'Extension', 'path' => 'Organization.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
        'identifier' => { 'type' => 'Identifier', 'path' => 'Organization.identifier', 'min' => 0, 'max' => Float::INFINITY },
        'active' => { 'type' => 'boolean', 'path' => 'Organization.active', 'min' => 0, 'max' => 1 },
        'type' => { 'valid_codes' => { 'http://hl7.org/fhir/organization-type' => ['prov', 'dept', 'team', 'govt', 'ins', 'edu', 'reli', 'crs', 'cg', 'bus', 'other'] }, 'type' => 'CodeableConcept', 'path' => 'Organization.type', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/organization-type' } },
        'name' => { 'type' => 'string', 'path' => 'Organization.name', 'min' => 0, 'max' => 1 },
        'telecom' => { 'type' => 'ContactPoint', 'path' => 'Organization.telecom', 'min' => 0, 'max' => Float::INFINITY },
        'address' => { 'type' => 'Address', 'path' => 'Organization.address', 'min' => 0, 'max' => Float::INFINITY },
        'partOf' => { 'type' => 'Reference', 'path' => 'Organization.partOf', 'min' => 0, 'max' => 1 },
        'contact' => { 'type' => 'Organization::Contact', 'path' => 'Organization.contact', 'min' => 0, 'max' => Float::INFINITY }
      }

      class Contact < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Contact.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Contact.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Contact.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'purpose' => { 'valid_codes' => { 'http://hl7.org/fhir/contactentity-type' => ['BILL', 'ADMIN', 'HR', 'PAYOR', 'PATINF', 'PRESS'] }, 'type' => 'CodeableConcept', 'path' => 'Contact.purpose', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'extensible', 'uri' => 'http://hl7.org/fhir/ValueSet/contactentity-type' } },
          'name' => { 'type' => 'HumanName', 'path' => 'Contact.name', 'min' => 0, 'max' => 1 },
          'telecom' => { 'type' => 'ContactPoint', 'path' => 'Contact.telecom', 'min' => 0, 'max' => Float::INFINITY },
          'address' => { 'type' => 'Address', 'path' => 'Contact.address', 'min' => 0, 'max' => 1 }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :purpose           # 0-1 CodeableConcept
        attr_accessor :name              # 0-1 HumanName
        attr_accessor :telecom           # 0-* [ ContactPoint ]
        attr_accessor :address           # 0-1 Address
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
      attr_accessor :active            # 0-1 boolean
      attr_accessor :type              # 0-1 CodeableConcept
      attr_accessor :name              # 0-1 string
      attr_accessor :telecom           # 0-* [ ContactPoint ]
      attr_accessor :address           # 0-* [ Address ]
      attr_accessor :partOf            # 0-1 Reference()
      attr_accessor :contact           # 0-* [ Organization::Contact ]

      def resourceType
        'Organization'
      end
    end
  end
end
