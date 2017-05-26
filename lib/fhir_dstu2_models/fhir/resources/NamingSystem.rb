module FHIR
  module DSTU2
    class NamingSystem < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['contact', 'context', 'date', 'id-type', 'kind', 'name', 'period', 'publisher', 'replaced-by', 'responsible', 'status', 'telecom', 'type', 'value']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'NamingSystem.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'NamingSystem.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'NamingSystem.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'NamingSystem.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'NamingSystem.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'NamingSystem.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'NamingSystem.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'NamingSystem.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'name' => {'type'=>'string', 'path'=>'NamingSystem.name', 'min'=>1, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/conformance-resource-status'=>['draft', 'active', 'retired']}, 'type'=>'code', 'path'=>'NamingSystem.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/conformance-resource-status'}},
        'kind' => {'valid_codes'=>{'http://hl7.org/fhir/namingsystem-type'=>['codesystem', 'identifier', 'root']}, 'type'=>'code', 'path'=>'NamingSystem.kind', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/namingsystem-type'}},
        'publisher' => {'type'=>'string', 'path'=>'NamingSystem.publisher', 'min'=>0, 'max'=>1},
        'contact' => {'type'=>'NamingSystem::Contact', 'path'=>'NamingSystem.contact', 'min'=>0, 'max'=>Float::INFINITY},
        'responsible' => {'type'=>'string', 'path'=>'NamingSystem.responsible', 'min'=>0, 'max'=>1},
        'date' => {'type'=>'dateTime', 'path'=>'NamingSystem.date', 'min'=>1, 'max'=>1},
        'type' => {'valid_codes'=>{'http://hl7.org/fhir/identifier-type'=>['UDI', 'SNO', 'SB', 'PLAC', 'FILL'], 'http://hl7.org/fhir/v2/0203'=>['ACSN', 'AM', 'AMA', 'AN', 'ANC', 'AND', 'ANON', 'ANT', 'APRN', 'ASID', 'An Identifier for a provider a', 'An identifier for a provi', 'An identifier for a provider r', 'BA', 'BC', 'BCT', 'BR', 'BRN', 'BSNR', 'CC', 'CONM', 'CY', 'CZ', 'DDS', 'DEA', 'DFN', 'DI', 'DL', 'DN', 'DO', 'DP', 'DPM', 'DR', 'DS', 'EI', 'EN', 'ESN', 'FI', 'GI', 'GL', 'GN', 'HC', 'IND', 'JHN', 'LACSN', 'LANR', 'LI', 'LN', 'LR', 'MA', 'MB', 'MC', 'MCD', 'MCN', 'MCR', 'MCT', 'MD', 'MI', 'MR', 'MRT', 'MS', 'NBSNR', 'NCT', 'NE', 'NH', 'NI', 'NII', 'NIIP', 'NNxxx', 'NP', 'NPI', 'OD', 'PA', 'PC', 'PCN', 'PE', 'PEN', 'PI', 'PN', 'PNT', 'PPIN', 'PPN', 'PRC', 'PRN', 'PT', 'QA', 'RI', 'RN', 'RPH', 'RR', 'RRI', 'RRP', 'SID', 'SL', 'SN', 'SP', 'SR', 'SS', 'TAX', 'TN', 'TPR', 'U', 'UPIN', 'USID', 'VN', 'VP', 'VS', 'WC', 'WCN', 'WP', 'XX']}, 'type'=>'CodeableConcept', 'path'=>'NamingSystem.type', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/identifier-type'}},
        'description' => {'type'=>'string', 'path'=>'NamingSystem.description', 'min'=>0, 'max'=>1},
        'useContext' => {'valid_codes'=>{'urn:iso:std:iso:3166'=>[], 'http://unstats.un.org/unsd/methods/m49/m49.htm'=>[], 'https://www.usps.com/'=>['AK', 'AL', 'AR', 'AS', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'FM', 'GA', 'GU', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MH', 'MI', 'MN', 'MO', 'MP', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'PR', 'PW', 'RI', 'SC', 'SD', 'TN', 'TX', 'UM', 'UT', 'VA', 'VI', 'VT', 'WA', 'WI', 'WV', 'WY'], 'http://hl7.org/fhir/practitioner-specialty'=>['cardio', 'dent', 'dietary', 'midw', 'sysarch']}, 'type'=>'CodeableConcept', 'path'=>'NamingSystem.useContext', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/use-context'}},
        'usage' => {'type'=>'string', 'path'=>'NamingSystem.usage', 'min'=>0, 'max'=>1},
        'uniqueId' => {'type'=>'NamingSystem::UniqueId', 'path'=>'NamingSystem.uniqueId', 'min'=>1, 'max'=>Float::INFINITY},
        'replacedBy' => {'type'=>'Reference', 'path'=>'NamingSystem.replacedBy', 'min'=>0, 'max'=>1}
      }

      class Contact < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Contact.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Contact.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Contact.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'name' => {'type'=>'string', 'path'=>'Contact.name', 'min'=>0, 'max'=>1},
          'telecom' => {'type'=>'ContactPoint', 'path'=>'Contact.telecom', 'min'=>0, 'max'=>Float::INFINITY}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :name              # 0-1 string
        attr_accessor :telecom           # 0-* [ ContactPoint ]
      end

      class UniqueId < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'UniqueId.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'UniqueId.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'UniqueId.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'type' => {'valid_codes'=>{'http://hl7.org/fhir/namingsystem-identifier-type'=>['oid', 'uuid', 'uri', 'other']}, 'type'=>'code', 'path'=>'UniqueId.type', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/namingsystem-identifier-type'}},
          'value' => {'type'=>'string', 'path'=>'UniqueId.value', 'min'=>1, 'max'=>1},
          'preferred' => {'type'=>'boolean', 'path'=>'UniqueId.preferred', 'min'=>0, 'max'=>1},
          'period' => {'type'=>'Period', 'path'=>'UniqueId.period', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :type              # 1-1 code
        attr_accessor :value             # 1-1 string
        attr_accessor :preferred         # 0-1 boolean
        attr_accessor :period            # 0-1 Period
      end

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :name              # 1-1 string
      attr_accessor :status            # 1-1 code
      attr_accessor :kind              # 1-1 code
      attr_accessor :publisher         # 0-1 string
      attr_accessor :contact           # 0-* [ NamingSystem::Contact ]
      attr_accessor :responsible       # 0-1 string
      attr_accessor :date              # 1-1 dateTime
      attr_accessor :type              # 0-1 CodeableConcept
      attr_accessor :description       # 0-1 string
      attr_accessor :useContext        # 0-* [ CodeableConcept ]
      attr_accessor :usage             # 0-1 string
      attr_accessor :uniqueId          # 1-* [ NamingSystem::UniqueId ]
      attr_accessor :replacedBy        # 0-1 Reference()

      def resourceType
        'NamingSystem'
      end
    end
  end
end