module FHIR
  module DSTU2
    class NutritionOrder < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['additive', 'datetime', 'encounter', 'formula', 'identifier', 'oraldiet', 'patient', 'provider', 'status', 'supplement']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'NutritionOrder.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'NutritionOrder.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'NutritionOrder.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'NutritionOrder.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'NutritionOrder.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'NutritionOrder.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'NutritionOrder.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'NutritionOrder.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'patient' => {'type'=>'Reference', 'path'=>'NutritionOrder.patient', 'min'=>1, 'max'=>1},
        'orderer' => {'type'=>'Reference', 'path'=>'NutritionOrder.orderer', 'min'=>0, 'max'=>1},
        'identifier' => {'type'=>'Identifier', 'path'=>'NutritionOrder.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'encounter' => {'type'=>'Reference', 'path'=>'NutritionOrder.encounter', 'min'=>0, 'max'=>1},
        'dateTime' => {'type'=>'dateTime', 'path'=>'NutritionOrder.dateTime', 'min'=>1, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/nutrition-order-status'=>['proposed', 'draft', 'planned', 'requested', 'active', 'on-hold', 'completed', 'cancelled']}, 'type'=>'code', 'path'=>'NutritionOrder.status', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/nutrition-order-status'}},
        'allergyIntolerance' => {'type'=>'Reference', 'path'=>'NutritionOrder.allergyIntolerance', 'min'=>0, 'max'=>Float::INFINITY},
        'foodPreferenceModifier' => {'valid_codes'=>{'http://hl7.org/fhir/diet'=>['vegetarian', 'dairy-free', 'nut-free', 'gluten-free', 'vegan', 'halal', 'kosher']}, 'type'=>'CodeableConcept', 'path'=>'NutritionOrder.foodPreferenceModifier', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/encounter-diet'}},
        'excludeFoodModifier' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'NutritionOrder.excludeFoodModifier', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/food-type'}},
        'oralDiet' => {'type'=>'NutritionOrder::OralDiet', 'path'=>'NutritionOrder.oralDiet', 'min'=>0, 'max'=>1},
        'supplement' => {'type'=>'NutritionOrder::Supplement', 'path'=>'NutritionOrder.supplement', 'min'=>0, 'max'=>Float::INFINITY},
        'enteralFormula' => {'type'=>'NutritionOrder::EnteralFormula', 'path'=>'NutritionOrder.enteralFormula', 'min'=>0, 'max'=>1}
      }

      class OralDiet < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'OralDiet.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'OralDiet.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'OralDiet.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'type' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'OralDiet.type', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/diet-type'}},
          'schedule' => {'type'=>'Timing', 'path'=>'OralDiet.schedule', 'min'=>0, 'max'=>Float::INFINITY},
          'nutrient' => {'type'=>'NutritionOrder::OralDiet::Nutrient', 'path'=>'OralDiet.nutrient', 'min'=>0, 'max'=>Float::INFINITY},
          'texture' => {'type'=>'NutritionOrder::OralDiet::Texture', 'path'=>'OralDiet.texture', 'min'=>0, 'max'=>Float::INFINITY},
          'fluidConsistencyType' => {'valid_codes'=>{'http://snomed.info/sct'=>['439031000124108', '439021000124105', '439041000124103', '439081000124109']}, 'type'=>'CodeableConcept', 'path'=>'OralDiet.fluidConsistencyType', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/consistency-type'}},
          'instruction' => {'type'=>'string', 'path'=>'OralDiet.instruction', 'min'=>0, 'max'=>1}
        }

        class Nutrient < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          METADATA = {
            'id' => {'type'=>'id', 'path'=>'Nutrient.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Nutrient.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Nutrient.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifier' => {'valid_codes'=>{'http://snomed.info/sct'=>['33463005', '39972003', '88480006']}, 'type'=>'CodeableConcept', 'path'=>'Nutrient.modifier', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/nutrient-code'}},
            'amount' => {'type'=>'Quantity', 'path'=>'Nutrient.amount', 'min'=>0, 'max'=>1}
          }

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :modifier          # 0-1 CodeableConcept
          attr_accessor :amount            # 0-1 Quantity
        end

        class Texture < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          METADATA = {
            'id' => {'type'=>'id', 'path'=>'Texture.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Texture.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Texture.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifier' => {'valid_codes'=>{'http://snomed.info/sct'=>['228053002', '439091000124107', '228049004', '441881000124103', '441761000124103', '441751000124100', '228059003', '441791000124106', '228055009', '228056005', '441771000124105', '228057001', '228058006', '228060008']}, 'type'=>'CodeableConcept', 'path'=>'Texture.modifier', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/texture-code'}},
            'foodType' => {'valid_codes'=>{'http://snomed.info/sct'=>['255620007', '28647000', '22836000', '72511004', '226760005', '226887002', '102263004', '74242007', '227415002', '264331002', '227518002', '44027008', '226529007', '227210005']}, 'type'=>'CodeableConcept', 'path'=>'Texture.foodType', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/modified-foodtype'}}
          }

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :modifier          # 0-1 CodeableConcept
          attr_accessor :foodType          # 0-1 CodeableConcept
        end

        attr_accessor :id                   # 0-1 id
        attr_accessor :extension            # 0-* [ Extension ]
        attr_accessor :modifierExtension    # 0-* [ Extension ]
        attr_accessor :type                 # 0-* [ CodeableConcept ]
        attr_accessor :schedule             # 0-* [ Timing ]
        attr_accessor :nutrient             # 0-* [ NutritionOrder::OralDiet::Nutrient ]
        attr_accessor :texture              # 0-* [ NutritionOrder::OralDiet::Texture ]
        attr_accessor :fluidConsistencyType # 0-* [ CodeableConcept ]
        attr_accessor :instruction          # 0-1 string
      end

      class Supplement < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Supplement.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Supplement.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Supplement.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'type' => {'valid_codes'=>{'http://snomed.info/sct'=>['442901000124106', '443031000124106', '443051000124104', '442911000124109', '443021000124108', '442971000124100', '442981000124102', '442991000124104', '443011000124100', '442961000124107', '442951000124105', '442941000124108', '442921000124101', '442931000124103', '444331000124106', '443361000124100', '443391000124108', '443401000124105', '443491000124103', '443501000124106', '443421000124100', '443471000124104', '444431000124104', '443451000124109', '444321000124108', '441561000124106', '443461000124106', '441531000124102', '443561000124107', '443481000124101', '441571000124104', '441591000124103', '441601000124106', '443351000124102', '443771000124106', '441671000124100', '443111000124101', '443431000124102', '443411000124108', '444361000124102', '444401000124107', '444381000124107', '444371000124109', '443441000124107', '442651000124102']}, 'type'=>'CodeableConcept', 'path'=>'Supplement.type', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/supplement-type'}},
          'productName' => {'type'=>'string', 'path'=>'Supplement.productName', 'min'=>0, 'max'=>1},
          'schedule' => {'type'=>'Timing', 'path'=>'Supplement.schedule', 'min'=>0, 'max'=>Float::INFINITY},
          'quantity' => {'type'=>'Quantity', 'path'=>'Supplement.quantity', 'min'=>0, 'max'=>1},
          'instruction' => {'type'=>'string', 'path'=>'Supplement.instruction', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :type              # 0-1 CodeableConcept
        attr_accessor :productName       # 0-1 string
        attr_accessor :schedule          # 0-* [ Timing ]
        attr_accessor :quantity          # 0-1 Quantity
        attr_accessor :instruction       # 0-1 string
      end

      class EnteralFormula < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'EnteralFormula.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'EnteralFormula.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'EnteralFormula.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'baseFormulaType' => {'valid_codes'=>{'http://snomed.info/sct'=>['443031000124106', '443051000124104', '442911000124109', '443021000124108', '442971000124100', '442981000124102', '442991000124104', '443011000124100', '442961000124107', '442951000124105', '442941000124108', '442921000124101', '442931000124103', '443361000124100', '443401000124105', '443491000124103', '443501000124106', '443421000124100', '443471000124104', '444431000124104', '443451000124109', '441561000124106', '443461000124106', '441531000124102', '443561000124107', '443481000124101', '441571000124104', '441591000124103', '441601000124106', '443351000124102', '443771000124106', '441671000124100', '443111000124101', '443431000124102', '443411000124108', '442651000124102']}, 'type'=>'CodeableConcept', 'path'=>'EnteralFormula.baseFormulaType', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/entformula-type'}},
          'baseFormulaProductName' => {'type'=>'string', 'path'=>'EnteralFormula.baseFormulaProductName', 'min'=>0, 'max'=>1},
          'additiveType' => {'valid_codes'=>{'http://hl7.org/fhir/entformula-additive'=>['lipid', 'protein', 'carbohydrate', 'fiber', 'water']}, 'type'=>'CodeableConcept', 'path'=>'EnteralFormula.additiveType', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/entformula-additive'}},
          'additiveProductName' => {'type'=>'string', 'path'=>'EnteralFormula.additiveProductName', 'min'=>0, 'max'=>1},
          'caloricDensity' => {'type'=>'Quantity', 'path'=>'EnteralFormula.caloricDensity', 'min'=>0, 'max'=>1},
          'routeofAdministration' => {'valid_codes'=>{'http://hl7.org/fhir/v3/RouteOfAdministration'=>['_RouteByMethod', 'SOAK', 'SHAMPOO', 'TRNSLING', 'PO', 'GARGLE', 'SUCK', '_Chew', 'CHEW', '_Diffusion', 'EXTCORPDIF', 'HEMODIFF', 'TRNSDERMD', '_Dissolve', 'DISSOLVE', 'SL', '_Douche', 'DOUCHE', '_ElectroOsmosisRoute', 'ELECTOSMOS', '_Enema', 'ENEMA', 'RETENEMA', '_Flush', 'IVFLUSH', '_Implantation', 'IDIMPLNT', 'IVITIMPLNT', 'SQIMPLNT', '_Infusion', 'EPI', 'IA', 'IC', 'ICOR', 'IOSSC', 'IT', 'IV', 'IVC', 'IVCC', 'IVCI', 'PCA', 'IVASCINFUS', 'SQINFUS', '_Inhalation', 'IPINHL', 'ORIFINHL', 'REBREATH', 'IPPB', 'NASINHL', 'NASINHLC', 'NEB', 'NASNEB', 'ORNEB', 'TRACH', 'VENT', 'VENTMASK', '_Injection', 'AMNINJ', 'BILINJ', 'CHOLINJ', 'CERVINJ', 'EPIDURINJ', 'EPIINJ', 'EPINJSP', 'EXTRAMNINJ', 'EXTCORPINJ', 'GBINJ', 'GINGINJ', 'BLADINJ', 'ENDOSININJ', 'HEMOPORT', 'IABDINJ', 'IAINJ', 'IAINJP', 'IAINJSP', 'IARTINJ', 'IBURSINJ', 'ICARDINJ', 'ICARDINJRP', 'ICARDINJSP', 'ICARINJP', 'ICARTINJ', 'ICAUDINJ', 'ICAVINJ', 'ICAVITINJ', 'ICEREBINJ', 'ICISTERNINJ', 'ICORONINJ', 'ICORONINJP', 'ICORPCAVINJ', 'IDINJ', 'IDISCINJ', 'IDUCTINJ', 'IDURINJ', 'IEPIDINJ', 'IEPITHINJ', 'ILESINJ', 'ILUMINJ', 'ILYMPJINJ', 'IM', 'IMD', 'IMZ', 'IMEDULINJ', 'INTERMENINJ', 'INTERSTITINJ', 'IOINJ', 'IOSSINJ', 'IOVARINJ', 'IPCARDINJ', 'IPERINJ', 'IPINJ', 'IPLRINJ', 'IPROSTINJ', 'IPUMPINJ', 'ISINJ', 'ISTERINJ', 'ISYNINJ', 'ITENDINJ', 'ITESTINJ', 'ITHORINJ', 'ITINJ', 'ITUBINJ', 'ITUMINJ', 'ITYMPINJ', 'IUINJ', 'IUINJC', 'IURETINJ', 'IVASCINJ', 'IVENTINJ', 'IVESINJ', 'IVINJ', 'IVINJBOL', 'IVPUSH', 'IVRPUSH', 'IVSPUSH', 'IVITINJ', 'PAINJ', 'PARENTINJ', 'PDONTINJ', 'PDPINJ', 'PDURINJ', 'PNINJ', 'PNSINJ', 'RBINJ', 'SCINJ', 'SLESINJ', 'SOFTISINJ', 'SQ', 'SUBARACHINJ', 'SUBMUCINJ', 'TRPLACINJ', 'TRTRACHINJ', 'URETHINJ', 'URETINJ', '_Insertion', 'CERVINS', 'IOSURGINS', 'IU', 'LPINS', 'PR', 'SQSURGINS', 'URETHINS', 'VAGINSI', '_Instillation', 'CECINSTL', 'EFT', 'ENTINSTL', 'GT', 'NGT', 'OGT', 'BLADINSTL', 'CAPDINSTL', 'CTINSTL', 'ETINSTL', 'GJT', 'IBRONCHINSTIL', 'IDUODINSTIL', 'IESOPHINSTIL', 'IGASTINSTIL', 'IILEALINJ', 'IOINSTL', 'ISININSTIL', 'ITRACHINSTIL', 'IUINSTL', 'JJTINSTL', 'LARYNGINSTIL', 'NASALINSTIL', 'NASOGASINSTIL', 'NTT', 'OJJ', 'OT', 'PDPINSTL', 'PNSINSTL', 'RECINSTL', 'RECTINSTL', 'SININSTIL', 'SOFTISINSTIL', 'TRACHINSTL', 'TRTYMPINSTIL', 'URETHINSTL', '_IontophoresisRoute', 'IONTO', '_Irrigation', 'GUIRR', 'IGASTIRR', 'ILESIRR', 'IOIRR', 'BLADIRR', 'BLADIRRC', 'BLADIRRT', 'RECIRR', '_LavageRoute', 'IGASTLAV', '_MucosalAbsorptionRoute', 'IDOUDMAB', 'ITRACHMAB', 'SMUCMAB', '_Nebulization', 'ETNEB', '_Rinse', 'DENRINSE', 'ORRINSE', '_SuppositoryRoute', 'URETHSUP', '_Swish', 'SWISHSPIT', 'SWISHSWAL', '_TopicalAbsorptionRoute', 'TTYMPTABSORP', '_TopicalApplication', 'DRESS', 'SWAB', 'TOPICAL', 'BUC', 'CERV', 'DEN', 'GIN', 'HAIR', 'ICORNTA', 'ICORONTA', 'IESOPHTA', 'IILEALTA', 'ILTOP', 'ILUMTA', 'IOTOP', 'LARYNGTA', 'MUC', 'NAIL', 'NASAL', 'OPTHALTA', 'ORALTA', 'ORMUC', 'OROPHARTA', 'PERIANAL', 'PERINEAL', 'PDONTTA', 'RECTAL', 'SCALP', 'OCDRESTA', 'SKIN', 'SUBCONJTA', 'TMUCTA', 'VAGINS', 'INSUF', 'TRNSDERM', '_RouteBySite', '_AmnioticFluidSacRoute', '_BiliaryRoute', '_BodySurfaceRoute', '_BuccalMucosaRoute', '_CecostomyRoute', '_CervicalRoute', '_EndocervicalRoute', '_EnteralRoute', '_EpiduralRoute', '_ExtraAmnioticRoute', '_ExtracorporealCirculationRoute', '_GastricRoute', '_GenitourinaryRoute', '_GingivalRoute', '_HairRoute', '_InterameningealRoute', '_InterstitialRoute', '_IntraabdominalRoute', '_IntraarterialRoute', '_IntraarticularRoute', '_IntrabronchialRoute', '_IntrabursalRoute', '_IntracardiacRoute', '_IntracartilaginousRoute', '_IntracaudalRoute', '_IntracavernosalRoute', '_IntracavitaryRoute', '_IntracerebralRoute', '_IntracervicalRoute', '_IntracisternalRoute', '_IntracornealRoute', '_IntracoronalRoute', '_IntracoronaryRoute', '_IntracorpusCavernosumRoute', '_IntradermalRoute', '_IntradiscalRoute', '_IntraductalRoute', '_IntraduodenalRoute', '_IntraduralRoute', '_IntraepidermalRoute', '_IntraepithelialRoute', '_IntraesophagealRoute', '_IntragastricRoute', '_IntrailealRoute', '_IntralesionalRoute', '_IntraluminalRoute', '_IntralymphaticRoute', '_IntramedullaryRoute', '_IntramuscularRoute', '_IntraocularRoute', '_IntraosseousRoute', '_IntraovarianRoute', '_IntrapericardialRoute', '_IntraperitonealRoute', '_IntrapleuralRoute', '_IntraprostaticRoute', '_IntrapulmonaryRoute', '_IntrasinalRoute', '_IntraspinalRoute', '_IntrasternalRoute', '_IntrasynovialRoute', '_IntratendinousRoute', '_IntratesticularRoute', '_IntrathecalRoute', '_IntrathoracicRoute', '_IntratrachealRoute', '_IntratubularRoute', '_IntratumorRoute', '_IntratympanicRoute', '_IntrauterineRoute', '_IntravascularRoute', '_IntravenousRoute', '_IntraventricularRoute', '_IntravesicleRoute', '_IntravitrealRoute', '_JejunumRoute', '_LacrimalPunctaRoute', '_LaryngealRoute', '_LingualRoute', '_MucousMembraneRoute', '_NailRoute', '_NasalRoute', '_OphthalmicRoute', '_OralRoute', '_OromucosalRoute', '_OropharyngealRoute', '_OticRoute', '_ParanasalSinusesRoute', '_ParenteralRoute', '_PerianalRoute', '_PeriarticularRoute', '_PeriduralRoute', '_PerinealRoute', '_PerineuralRoute', '_PeriodontalRoute', '_PulmonaryRoute', '_RectalRoute', '_RespiratoryTractRoute', '_RetrobulbarRoute', '_ScalpRoute', '_SinusUnspecifiedRoute', '_SkinRoute', '_SoftTissueRoute', '_SubarachnoidRoute', '_SubconjunctivalRoute', '_SubcutaneousRoute', '_SublesionalRoute', '_SublingualRoute', '_SubmucosalRoute', '_TracheostomyRoute', '_TransmucosalRoute', '_TransplacentalRoute', '_TranstrachealRoute', '_TranstympanicRoute', '_UreteralRoute', '_UrethralRoute', '_UrinaryBladderRoute', '_UrinaryTractRoute', '_VaginalRoute', '_VitreousHumourRoute']}, 'type'=>'CodeableConcept', 'path'=>'EnteralFormula.routeofAdministration', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/enteral-route'}},
          'administration' => {'type'=>'NutritionOrder::EnteralFormula::Administration', 'path'=>'EnteralFormula.administration', 'min'=>0, 'max'=>Float::INFINITY},
          'maxVolumeToDeliver' => {'type'=>'Quantity', 'path'=>'EnteralFormula.maxVolumeToDeliver', 'min'=>0, 'max'=>1},
          'administrationInstruction' => {'type'=>'string', 'path'=>'EnteralFormula.administrationInstruction', 'min'=>0, 'max'=>1}
        }

        class Administration < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          MULTIPLE_TYPES = {
            'rate' => ['Quantity', 'Ratio']
          }
          METADATA = {
            'id' => {'type'=>'id', 'path'=>'Administration.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Administration.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Administration.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'schedule' => {'type'=>'Timing', 'path'=>'Administration.schedule', 'min'=>0, 'max'=>1},
            'quantity' => {'type'=>'Quantity', 'path'=>'Administration.quantity', 'min'=>0, 'max'=>1},
            'rateQuantity' => {'type'=>'Quantity', 'path'=>'Administration.rate[x]', 'min'=>0, 'max'=>1},
            'rateRatio' => {'type'=>'Ratio', 'path'=>'Administration.rate[x]', 'min'=>0, 'max'=>1}
          }

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :schedule          # 0-1 Timing
          attr_accessor :quantity          # 0-1 Quantity
          attr_accessor :rateQuantity      # 0-1 Quantity
          attr_accessor :rateRatio         # 0-1 Ratio
        end

        attr_accessor :id                        # 0-1 id
        attr_accessor :extension                 # 0-* [ Extension ]
        attr_accessor :modifierExtension         # 0-* [ Extension ]
        attr_accessor :baseFormulaType           # 0-1 CodeableConcept
        attr_accessor :baseFormulaProductName    # 0-1 string
        attr_accessor :additiveType              # 0-1 CodeableConcept
        attr_accessor :additiveProductName       # 0-1 string
        attr_accessor :caloricDensity            # 0-1 Quantity
        attr_accessor :routeofAdministration     # 0-1 CodeableConcept
        attr_accessor :administration            # 0-* [ NutritionOrder::EnteralFormula::Administration ]
        attr_accessor :maxVolumeToDeliver        # 0-1 Quantity
        attr_accessor :administrationInstruction # 0-1 string
      end

      attr_accessor :id                     # 0-1 id
      attr_accessor :meta                   # 0-1 Meta
      attr_accessor :implicitRules          # 0-1 uri
      attr_accessor :language               # 0-1 code
      attr_accessor :text                   # 0-1 Narrative
      attr_accessor :contained              # 0-* [ Resource ]
      attr_accessor :extension              # 0-* [ Extension ]
      attr_accessor :modifierExtension      # 0-* [ Extension ]
      attr_accessor :patient                # 1-1 Reference()
      attr_accessor :orderer                # 0-1 Reference()
      attr_accessor :identifier             # 0-* [ Identifier ]
      attr_accessor :encounter              # 0-1 Reference()
      attr_accessor :dateTime               # 1-1 dateTime
      attr_accessor :status                 # 0-1 code
      attr_accessor :allergyIntolerance     # 0-* [ Reference() ]
      attr_accessor :foodPreferenceModifier # 0-* [ CodeableConcept ]
      attr_accessor :excludeFoodModifier    # 0-* [ CodeableConcept ]
      attr_accessor :oralDiet               # 0-1 NutritionOrder::OralDiet
      attr_accessor :supplement             # 0-* [ NutritionOrder::Supplement ]
      attr_accessor :enteralFormula         # 0-1 NutritionOrder::EnteralFormula

      def resourceType
        'NutritionOrder'
      end
    end
  end
end