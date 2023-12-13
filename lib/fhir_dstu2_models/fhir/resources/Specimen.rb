module FHIR
  module DSTU2
    class Specimen < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['accession', 'bodysite', 'collected', 'collector', 'container', 'container-id', 'identifier', 'parent', 'patient', 'subject', 'type']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Specimen.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'Specimen.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'Specimen.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'Specimen.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'Specimen.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'Specimen.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'Specimen.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Specimen.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'Specimen.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/specimen-status'=>['available', 'unavailable', 'unsatisfactory', 'entered-in-error']}, 'type'=>'code', 'path'=>'Specimen.status', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/specimen-status'}},
        'type' => {'valid_codes'=>{'http://hl7.org/fhir/v2/0487'=>['...', 'ABS', 'ACNE', 'ACNFLD', 'AIRS', 'ALL', 'AMN', 'AMP', 'ANGI', 'ARTC', 'ASERU', 'ASP', 'ATTE', 'AUTOA', 'AUTOC', 'AUTP', 'BBL', 'BCYST', 'BDY', 'BIFL', 'BITE', 'BLD', 'BLDA', 'BLDCO', 'BLDV', 'BLEB', 'BLIST', 'BOIL', 'BON', 'BONE', 'BOWL', 'BPH', 'BPU', 'BRN', 'BRSH', 'BRTH', 'BRUS', 'BUB', 'BULLA', 'BX', 'CALC', 'CARBU', 'CAT', 'CBITE', 'CDM', 'CLIPP', 'CNJT', 'CNL', 'COL', 'CONE', 'CSCR', 'CSERU', 'CSF', 'CSITE', 'CSMY', 'CST', 'CSVR', 'CTP', 'CUR', 'CVM', 'CVPS', 'CVPT', 'CYN', 'CYST', 'DBITE', 'DCS', 'DEC', 'DEION', 'DIA', 'DIAF', 'DISCHG', 'DIV', 'DRN', 'DRNG', 'DRNGP', 'DUFL', 'EARW', 'EBRUSH', 'EEYE', 'EFF', 'EFFUS', 'EFOD', 'EISO', 'ELT', 'ENVIR', 'EOS', 'EOTH', 'ESOI', 'ESOS', 'ETA', 'ETTP', 'ETTUB', 'EWHI', 'EXG', 'EXS', 'EXUDTE', 'FAW', 'FBLOOD', 'FGA', 'FIB', 'FIST', 'FLD', 'FLT', 'FLU', 'FLUID', 'FOLEY', 'FRS', 'FSCLP', 'FUR', 'GAS', 'GASA', 'GASAN', 'GASBR', 'GASD', 'GAST', 'GENL', 'GENV', 'GRAFT', 'GRAFTS', 'GRANU', 'GROSH', 'GSOL', 'GSPEC', 'GT', 'GTUBE', 'HAR', 'HBITE', 'HBLUD', 'HEMAQ', 'HEMO', 'HERNI', 'HEV', 'HIC', 'HYDC', 'IBITE', 'ICYST', 'IDC', 'IHG', 'ILEO', 'ILLEG', 'IMP', 'INCI', 'INFIL', 'INS', 'INTRD', 'ISLT', 'IT', 'IUD', 'IVCAT', 'IVFLD', 'IVTIP', 'JEJU', 'JNTFLD', 'JP', 'KELOI', 'KIDFLD', 'LAVG', 'LAVGG', 'LAVGP', 'LAVPG', 'LENS1', 'LENS2', 'LESN', 'LIQ', 'LIQO', 'LNA', 'LNV', 'LSAC', 'LYM', 'MAC', 'MAHUR', 'MAR', 'MASS', 'MBLD', 'MEC', 'MILK', 'MLK', 'MUCOS', 'MUCUS', 'NAIL', 'NASDR', 'NEDL', 'NEPH', 'NGASP', 'NGAST', 'NGS', 'NODUL', 'NSECR', 'ORH', 'ORL', 'OTH', 'PACEM', 'PAFL', 'PCFL', 'PDSIT', 'PDTS', 'PELVA', 'PENIL', 'PERIA', 'PILOC', 'PINS', 'PIS', 'PLAN', 'PLAS', 'PLB', 'PLC', 'PLEVS', 'PLR', 'PMN', 'PND', 'POL', 'POPGS', 'POPLG', 'POPLV', 'PORTA', 'PPP', 'PROST', 'PRP', 'PSC', 'PUNCT', 'PUS', 'PUSFR', 'PUST', 'QC3', 'RANDU', 'RBC', 'RBITE', 'RECT', 'RECTA', 'RENALC', 'RENC', 'RES', 'SAL', 'SCAR', 'SCLV', 'SCROA', 'SECRE', 'SER', 'SHU', 'SHUNF', 'SHUNT', 'SITE', 'SKBP', 'SKN', 'SMM', 'SMN', 'SNV', 'SPRM', 'SPRP', 'SPRPB', 'SPS', 'SPT', 'SPTC', 'SPTT', 'SPUT1', 'SPUTIN', 'SPUTSP', 'STER', 'STL', 'STONE', 'SUBMA', 'SUBMX', 'SUMP', 'SUP', 'SUTUR', 'SWGZ', 'SWT', 'TASP', 'TEAR', 'THRB', 'TISS', 'TISU', 'TLC', 'TRAC', 'TRANS', 'TSERU', 'TSTES', 'TTRA', 'TUBES', 'TUMOR', 'TZANC', 'UDENT', 'UMED', 'UR', 'URC', 'URINB', 'URINC', 'URINM', 'URINN', 'URINP', 'URNS', 'URT', 'USCOP', 'USPEC', 'USUB', 'VASTIP', 'VENT', 'VITF', 'VOM', 'WASH', 'WASI', 'WAT', 'WB', 'WBC', 'WEN', 'WICK', 'WND', 'WNDA', 'WNDD', 'WNDE', 'WORM', 'WRT', 'WWA', 'WWO', 'WWT']}, 'type'=>'CodeableConcept', 'path'=>'Specimen.type', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/v2-0487'}},
        'parent' => {'type'=>'Reference', 'path'=>'Specimen.parent', 'min'=>0, 'max'=>Float::INFINITY},
        'subject' => {'type'=>'Reference', 'path'=>'Specimen.subject', 'min'=>1, 'max'=>1},
        'accessionIdentifier' => {'type'=>'Identifier', 'path'=>'Specimen.accessionIdentifier', 'min'=>0, 'max'=>1},
        'receivedTime' => {'type'=>'dateTime', 'path'=>'Specimen.receivedTime', 'min'=>0, 'max'=>1},
        'collection' => {'type'=>'Specimen::Collection', 'path'=>'Specimen.collection', 'min'=>0, 'max'=>1},
        'treatment' => {'type'=>'Specimen::Treatment', 'path'=>'Specimen.treatment', 'min'=>0, 'max'=>Float::INFINITY},
        'container' => {'type'=>'Specimen::Container', 'path'=>'Specimen.container', 'min'=>0, 'max'=>Float::INFINITY}
      }

      class Collection < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'collected' => ['dateTime', 'Period']
        }
        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Collection.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Collection.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Collection.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'collector' => {'type'=>'Reference', 'path'=>'Collection.collector', 'min'=>0, 'max'=>1},
          'comment' => {'type'=>'string', 'path'=>'Collection.comment', 'min'=>0, 'max'=>Float::INFINITY},
          'collectedDateTime' => {'type'=>'dateTime', 'path'=>'Collection.collected[x]', 'min'=>0, 'max'=>1},
          'collectedPeriod' => {'type'=>'Period', 'path'=>'Collection.collected[x]', 'min'=>0, 'max'=>1},
          'quantity' => {'type'=>'Quantity', 'path'=>'Collection.quantity', 'min'=>0, 'max'=>1},
          'method' => {'local_name'=>'local_method', 'valid_codes'=>{'http://snomed.info/sct'=>['119295008', '413651001', '360020006', '430823004', '16404004', '67889009', '29240004', '45710003', '7800008', '258431006', '20255002', '386147002', '278450005'], 'http://hl7.org/fhir/v2/0488'=>['ANP', 'BAP', 'BCAE', 'BCAN', 'BCPD', 'BIO', 'CAP', 'CATH', 'CVP', 'EPLA', 'ESWA', 'FNA', 'KOFFP', 'LNA', 'LNV', 'MARTL', 'ML11', 'MLP', 'NYP', 'PACE', 'PIN', 'PNA', 'PRIME', 'PUMP', 'QC5', 'SCLP', 'SCRAPS', 'SHA', 'SWA', 'SWD', 'TMAN', 'TMCH', 'TMM4', 'TMMY', 'TMOT', 'TMP', 'TMPV', 'TMSC', 'TMUP', 'TMVI', 'VENIP', 'WOOD']}, 'type'=>'CodeableConcept', 'path'=>'Collection.method', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/specimen-collection-method'}},
          'bodySite' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Collection.bodySite', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/body-site'}}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :collector         # 0-1 Reference()
        attr_accessor :comment           # 0-* [ string ]
        attr_accessor :collectedDateTime # 0-1 dateTime
        attr_accessor :collectedPeriod   # 0-1 Period
        attr_accessor :quantity          # 0-1 Quantity
        attr_accessor :local_method      # 0-1 CodeableConcept
        attr_accessor :bodySite          # 0-1 CodeableConcept
      end

      class Treatment < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Treatment.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Treatment.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Treatment.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'description' => {'type'=>'string', 'path'=>'Treatment.description', 'min'=>0, 'max'=>1},
          'procedure' => {'valid_codes'=>{'http://hl7.org/fhir/v2/0373'=>['ACID', 'ALK', 'DEFB', 'FILT', 'LDLP', 'NEUT', 'RECA', 'UFIL']}, 'type'=>'CodeableConcept', 'path'=>'Treatment.procedure', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/specimen-treatment-procedure'}},
          'additive' => {'type'=>'Reference', 'path'=>'Treatment.additive', 'min'=>0, 'max'=>Float::INFINITY}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :description       # 0-1 string
        attr_accessor :procedure         # 0-1 CodeableConcept
        attr_accessor :additive          # 0-* [ Reference() ]
      end

      class Container < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'additive' => ['CodeableConcept', 'Reference']
        }
        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Container.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Container.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Container.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'identifier' => {'type'=>'Identifier', 'path'=>'Container.identifier', 'min'=>0, 'max'=>Float::INFINITY},
          'description' => {'type'=>'string', 'path'=>'Container.description', 'min'=>0, 'max'=>1},
          'type' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Container.type', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/specimen-container-type'}},
          'capacity' => {'type'=>'Quantity', 'path'=>'Container.capacity', 'min'=>0, 'max'=>1},
          'specimenQuantity' => {'type'=>'Quantity', 'path'=>'Container.specimenQuantity', 'min'=>0, 'max'=>1},
          'additiveCodeableConcept' => {'valid_codes'=>{'http://hl7.org/fhir/v2/0371'=>['ACDA', 'ACDB', 'ACET', 'AMIES', 'BACTM', 'BF10', 'BOR', 'BOUIN', 'BSKM', 'C32', 'C38', 'CARS', 'CARY', 'CHLTM', 'CTAD', 'EDTK', 'EDTK15', 'EDTK75', 'EDTN', 'ENT', 'ENT+', 'F10', 'FDP', 'FL10', 'FL100', 'HCL6', 'HEPA', 'HEPL', 'HEPN', 'HNO3', 'JKM', 'KARN', 'KOX', 'LIA', 'M4', 'M4RT', 'M5', 'MICHTM', 'MMDTM', 'NAF', 'NAPS', 'NONE', 'PAGE', 'PHENOL', 'PVA', 'RLM', 'SILICA', 'SPS', 'SST', 'STUTM', 'THROM', 'THYMOL', 'THYO', 'TOLU', 'URETM', 'VIRTM', 'WEST']}, 'type'=>'CodeableConcept', 'path'=>'Container.additive[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/v2-0371'}},
          'additiveReference' => {'type'=>'Reference', 'path'=>'Container.additive[x]', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                      # 0-1 id
        attr_accessor :extension               # 0-* [ Extension ]
        attr_accessor :modifierExtension       # 0-* [ Extension ]
        attr_accessor :identifier              # 0-* [ Identifier ]
        attr_accessor :description             # 0-1 string
        attr_accessor :type                    # 0-1 CodeableConcept
        attr_accessor :capacity                # 0-1 Quantity
        attr_accessor :specimenQuantity        # 0-1 Quantity
        attr_accessor :additiveCodeableConcept # 0-1 CodeableConcept
        attr_accessor :additiveReference       # 0-1 Reference()
      end

      attr_accessor :id                  # 0-1 id
      attr_accessor :meta                # 0-1 Meta
      attr_accessor :implicitRules       # 0-1 uri
      attr_accessor :language            # 0-1 code
      attr_accessor :text                # 0-1 Narrative
      attr_accessor :contained           # 0-* [ Resource ]
      attr_accessor :extension           # 0-* [ Extension ]
      attr_accessor :modifierExtension   # 0-* [ Extension ]
      attr_accessor :identifier          # 0-* [ Identifier ]
      attr_accessor :status              # 0-1 code
      attr_accessor :type                # 0-1 CodeableConcept
      attr_accessor :parent              # 0-* [ Reference() ]
      attr_accessor :subject             # 1-1 Reference()
      attr_accessor :accessionIdentifier # 0-1 Identifier
      attr_accessor :receivedTime        # 0-1 dateTime
      attr_accessor :collection          # 0-1 Specimen::Collection
      attr_accessor :treatment           # 0-* [ Specimen::Treatment ]
      attr_accessor :container           # 0-* [ Specimen::Container ]

      def resourceType
        'Specimen'
      end
    end
  end
end
