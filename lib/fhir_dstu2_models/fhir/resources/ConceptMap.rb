module FHIR
  module DSTU2
    class ConceptMap < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'source' => ['uri', 'Reference'],
        'target' => ['uri', 'Reference']
      }
      SEARCH_PARAMS = ['context', 'date', 'dependson', 'description', 'identifier', 'name', 'product', 'publisher', 'source', 'sourcecode', 'sourcesystem', 'sourceuri', 'status', 'target', 'targetcode', 'targetsystem', 'url', 'version']
      METADATA = {
        'id' => { 'type' => 'id', 'path' => 'ConceptMap.id', 'min' => 0, 'max' => 1 },
        'meta' => { 'type' => 'Meta', 'path' => 'ConceptMap.meta', 'min' => 0, 'max' => 1 },
        'implicitRules' => { 'type' => 'uri', 'path' => 'ConceptMap.implicitRules', 'min' => 0, 'max' => 1 },
        'language' => { 'type' => 'code', 'path' => 'ConceptMap.language', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://tools.ietf.org/html/bcp47' } },
        'text' => { 'type' => 'Narrative', 'path' => 'ConceptMap.text', 'min' => 0, 'max' => 1 },
        'contained' => { 'type' => 'Resource', 'path' => 'ConceptMap.contained', 'min' => 0, 'max' => Float::INFINITY },
        'extension' => { 'type' => 'Extension', 'path' => 'ConceptMap.extension', 'min' => 0, 'max' => Float::INFINITY },
        'modifierExtension' => { 'type' => 'Extension', 'path' => 'ConceptMap.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
        'url' => { 'type' => 'uri', 'path' => 'ConceptMap.url', 'min' => 0, 'max' => 1 },
        'identifier' => { 'type' => 'Identifier', 'path' => 'ConceptMap.identifier', 'min' => 0, 'max' => 1 },
        'version' => { 'type' => 'string', 'path' => 'ConceptMap.version', 'min' => 0, 'max' => 1 },
        'name' => { 'type' => 'string', 'path' => 'ConceptMap.name', 'min' => 0, 'max' => 1 },
        'status' => { 'valid_codes' => { 'http://hl7.org/fhir/conformance-resource-status' => ['draft', 'active', 'retired'] }, 'type' => 'code', 'path' => 'ConceptMap.status', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/conformance-resource-status' } },
        'experimental' => { 'type' => 'boolean', 'path' => 'ConceptMap.experimental', 'min' => 0, 'max' => 1 },
        'publisher' => { 'type' => 'string', 'path' => 'ConceptMap.publisher', 'min' => 0, 'max' => 1 },
        'contact' => { 'type' => 'ConceptMap::Contact', 'path' => 'ConceptMap.contact', 'min' => 0, 'max' => Float::INFINITY },
        'date' => { 'type' => 'dateTime', 'path' => 'ConceptMap.date', 'min' => 0, 'max' => 1 },
        'description' => { 'type' => 'string', 'path' => 'ConceptMap.description', 'min' => 0, 'max' => 1 },
        'useContext' => { 'valid_codes' => { 'urn:iso:std:iso:3166' => [], 'http://unstats.un.org/unsd/methods/m49/m49.htm' => [], 'https://www.usps.com/' => ['AK', 'AL', 'AR', 'AS', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'FM', 'GA', 'GU', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MH', 'MI', 'MN', 'MO', 'MP', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'PR', 'PW', 'RI', 'SC', 'SD', 'TN', 'TX', 'UM', 'UT', 'VA', 'VI', 'VT', 'WA', 'WI', 'WV', 'WY'], 'http://hl7.org/fhir/practitioner-specialty' => ['cardio', 'dent', 'dietary', 'midw', 'sysarch'] }, 'type' => 'CodeableConcept', 'path' => 'ConceptMap.useContext', 'min' => 0, 'max' => Float::INFINITY, 'binding' => { 'strength' => 'extensible', 'uri' => 'http://hl7.org/fhir/ValueSet/use-context' } },
        'requirements' => { 'type' => 'string', 'path' => 'ConceptMap.requirements', 'min' => 0, 'max' => 1 },
        'copyright' => { 'type' => 'string', 'path' => 'ConceptMap.copyright', 'min' => 0, 'max' => 1 },
        'sourceUri' => { 'type' => 'uri', 'path' => 'ConceptMap.source[x]', 'min' => 1, 'max' => 1 },
        'sourceReference' => { 'type' => 'Reference', 'path' => 'ConceptMap.source[x]', 'min' => 1, 'max' => 1 },
        'targetUri' => { 'type' => 'uri', 'path' => 'ConceptMap.target[x]', 'min' => 1, 'max' => 1 },
        'targetReference' => { 'type' => 'Reference', 'path' => 'ConceptMap.target[x]', 'min' => 1, 'max' => 1 },
        'element' => { 'type' => 'ConceptMap::Element', 'path' => 'ConceptMap.element', 'min' => 0, 'max' => Float::INFINITY }
      }

      class Contact < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Contact.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Contact.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Contact.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'name' => { 'type' => 'string', 'path' => 'Contact.name', 'min' => 0, 'max' => 1 },
          'telecom' => { 'type' => 'ContactPoint', 'path' => 'Contact.telecom', 'min' => 0, 'max' => Float::INFINITY }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :name              # 0-1 string
        attr_accessor :telecom           # 0-* [ ContactPoint ]
      end

      class Element < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Element.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Element.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Element.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'codeSystem' => { 'type' => 'uri', 'path' => 'Element.codeSystem', 'min' => 0, 'max' => 1 },
          'code' => { 'type' => 'code', 'path' => 'Element.code', 'min' => 0, 'max' => 1 },
          'target' => { 'type' => 'ConceptMap::Element::Target', 'path' => 'Element.target', 'min' => 0, 'max' => Float::INFINITY }
        }

        class Target < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          METADATA = {
            'id' => { 'type' => 'id', 'path' => 'Target.id', 'min' => 0, 'max' => 1 },
            'extension' => { 'type' => 'Extension', 'path' => 'Target.extension', 'min' => 0, 'max' => Float::INFINITY },
            'modifierExtension' => { 'type' => 'Extension', 'path' => 'Target.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
            'codeSystem' => { 'type' => 'uri', 'path' => 'Target.codeSystem', 'min' => 0, 'max' => 1 },
            'code' => { 'type' => 'code', 'path' => 'Target.code', 'min' => 0, 'max' => 1 },
            'equivalence' => { 'valid_codes' => { 'http://hl7.org/fhir/concept-map-equivalence' => ['equivalent', 'equal', 'wider', 'subsumes', 'narrower', 'specializes', 'inexact', 'unmatched', 'disjoint'] }, 'type' => 'code', 'path' => 'Target.equivalence', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/concept-map-equivalence' } },
            'comments' => { 'type' => 'string', 'path' => 'Target.comments', 'min' => 0, 'max' => 1 },
            'dependsOn' => { 'type' => 'ConceptMap::Element::Target::DependsOn', 'path' => 'Target.dependsOn', 'min' => 0, 'max' => Float::INFINITY },
            'product' => { 'type' => 'ConceptMap::Element::Target::DependsOn', 'path' => 'Target.product', 'min' => 0, 'max' => Float::INFINITY }
          }

          class DependsOn < FHIR::DSTU2::Model
            include FHIR::DSTU2::Hashable
            include FHIR::DSTU2::Json
            include FHIR::DSTU2::Xml

            METADATA = {
              'id' => { 'type' => 'id', 'path' => 'DependsOn.id', 'min' => 0, 'max' => 1 },
              'extension' => { 'type' => 'Extension', 'path' => 'DependsOn.extension', 'min' => 0, 'max' => Float::INFINITY },
              'modifierExtension' => { 'type' => 'Extension', 'path' => 'DependsOn.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
              'element' => { 'type' => 'uri', 'path' => 'DependsOn.element', 'min' => 1, 'max' => 1 },
              'codeSystem' => { 'type' => 'uri', 'path' => 'DependsOn.codeSystem', 'min' => 1, 'max' => 1 },
              'code' => { 'type' => 'string', 'path' => 'DependsOn.code', 'min' => 1, 'max' => 1 }
            }

            attr_accessor :id                # 0-1 id
            attr_accessor :extension         # 0-* [ Extension ]
            attr_accessor :modifierExtension # 0-* [ Extension ]
            attr_accessor :element           # 1-1 uri
            attr_accessor :codeSystem        # 1-1 uri
            attr_accessor :code              # 1-1 string
          end

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :codeSystem        # 0-1 uri
          attr_accessor :code              # 0-1 code
          attr_accessor :equivalence       # 1-1 code
          attr_accessor :comments          # 0-1 string
          attr_accessor :dependsOn         # 0-* [ ConceptMap::Element::Target::DependsOn ]
          attr_accessor :product           # 0-* [ ConceptMap::Element::Target::DependsOn ]
        end

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :codeSystem        # 0-1 uri
        attr_accessor :code              # 0-1 code
        attr_accessor :target            # 0-* [ ConceptMap::Element::Target ]
      end

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :url               # 0-1 uri
      attr_accessor :identifier        # 0-1 Identifier
      attr_accessor :version           # 0-1 string
      attr_accessor :name              # 0-1 string
      attr_accessor :status            # 1-1 code
      attr_accessor :experimental      # 0-1 boolean
      attr_accessor :publisher         # 0-1 string
      attr_accessor :contact           # 0-* [ ConceptMap::Contact ]
      attr_accessor :date              # 0-1 dateTime
      attr_accessor :description       # 0-1 string
      attr_accessor :useContext        # 0-* [ CodeableConcept ]
      attr_accessor :requirements      # 0-1 string
      attr_accessor :copyright         # 0-1 string
      attr_accessor :sourceUri         # 1-1 uri
      attr_accessor :sourceReference   # 1-1 Reference()
      attr_accessor :targetUri         # 1-1 uri
      attr_accessor :targetReference   # 1-1 Reference()
      attr_accessor :element           # 0-* [ ConceptMap::Element ]

      def resourceType
        'ConceptMap'
      end
    end
  end
end
