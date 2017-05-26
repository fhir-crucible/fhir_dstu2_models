module FHIR
  module DSTU2
    class Immunization < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['date', 'dose-number', 'dose-sequence', 'identifier', 'information', 'patient', 'status', 'support', 'vaccine-type', 'date', 'dose-sequence', 'identifier', 'location', 'lot-number', 'manufacturer', 'notgiven', 'patient', 'performer', 'reaction', 'reaction-date', 'reason', 'reason-not-given', 'requester', 'status', 'vaccine-code']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Immunization.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'Immunization.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'Immunization.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'Immunization.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'Immunization.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'Immunization.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'Immunization.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Immunization.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'Immunization.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/medication-admin-status'=>['in-progress', 'on-hold', 'completed', 'entered-in-error', 'stopped']}, 'type'=>'code', 'path'=>'Immunization.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/medication-admin-status'}},
        'date' => {'type'=>'dateTime', 'path'=>'Immunization.date', 'min'=>0, 'max'=>1},
        'vaccineCode' => {'valid_codes'=>{'http://hl7.org/fhir/sid/cvx'=>[], 'urn:oid:1.2.36.1.2001.1005.17'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Immunization.vaccineCode', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/vaccine-code'}},
        'patient' => {'type'=>'Reference', 'path'=>'Immunization.patient', 'min'=>1, 'max'=>1},
        'wasNotGiven' => {'type'=>'boolean', 'path'=>'Immunization.wasNotGiven', 'min'=>1, 'max'=>1},
        'reported' => {'type'=>'boolean', 'path'=>'Immunization.reported', 'min'=>1, 'max'=>1},
        'performer' => {'type'=>'Reference', 'path'=>'Immunization.performer', 'min'=>0, 'max'=>1},
        'requester' => {'type'=>'Reference', 'path'=>'Immunization.requester', 'min'=>0, 'max'=>1},
        'encounter' => {'type'=>'Reference', 'path'=>'Immunization.encounter', 'min'=>0, 'max'=>1},
        'manufacturer' => {'type'=>'Reference', 'path'=>'Immunization.manufacturer', 'min'=>0, 'max'=>1},
        'location' => {'type'=>'Reference', 'path'=>'Immunization.location', 'min'=>0, 'max'=>1},
        'lotNumber' => {'type'=>'string', 'path'=>'Immunization.lotNumber', 'min'=>0, 'max'=>1},
        'expirationDate' => {'type'=>'date', 'path'=>'Immunization.expirationDate', 'min'=>0, 'max'=>1},
        'site' => {'valid_codes'=>{'http://hl7.org/fhir/v3/ActSite'=>['_HumanActSite', '_HumanSubstanceAdministrationSite', 'BE', 'BN', 'BU', 'LA', 'LAC', 'LACF', 'LD', 'LE', 'LEJ', 'LF', 'LG', 'LH', 'LIJ', 'LLAQ', 'LLFA', 'LMFA', 'LN', 'LPC', 'LSC', 'LT', 'LUA', 'LUAQ', 'LUFA', 'LVG', 'LVL', 'OD', 'OS', 'OU', 'PA', 'PERIN', 'RA', 'RAC', 'RACF', 'RD', 'RE', 'REJ', 'RF', 'RG', 'RH', 'RIJ', 'RLAQ', 'RLFA', 'RMFA', 'RN', 'RPC', 'RSC', 'RT', 'RUA', 'RUAQ', 'RUFA', 'RVG', 'RVL']}, 'type'=>'CodeableConcept', 'path'=>'Immunization.site', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/immunization-site'}},
        'route' => {'valid_codes'=>{'http://hl7.org/fhir/v3/RouteOfAdministration'=>['_RouteByMethod', 'SOAK', 'SHAMPOO', 'TRNSLING', 'PO', 'GARGLE', 'SUCK', '_Chew', 'CHEW', '_Diffusion', 'EXTCORPDIF', 'HEMODIFF', 'TRNSDERMD', '_Dissolve', 'DISSOLVE', 'SL', '_Douche', 'DOUCHE', '_ElectroOsmosisRoute', 'ELECTOSMOS', '_Enema', 'ENEMA', 'RETENEMA', '_Flush', 'IVFLUSH', '_Implantation', 'IDIMPLNT', 'IVITIMPLNT', 'SQIMPLNT', '_Infusion', 'EPI', 'IA', 'IC', 'ICOR', 'IOSSC', 'IT', 'IV', 'IVC', 'IVCC', 'IVCI', 'PCA', 'IVASCINFUS', 'SQINFUS', '_Inhalation', 'IPINHL', 'ORIFINHL', 'REBREATH', 'IPPB', 'NASINHL', 'NASINHLC', 'NEB', 'NASNEB', 'ORNEB', 'TRACH', 'VENT', 'VENTMASK', '_Injection', 'AMNINJ', 'BILINJ', 'CHOLINJ', 'CERVINJ', 'EPIDURINJ', 'EPIINJ', 'EPINJSP', 'EXTRAMNINJ', 'EXTCORPINJ', 'GBINJ', 'GINGINJ', 'BLADINJ', 'ENDOSININJ', 'HEMOPORT', 'IABDINJ', 'IAINJ', 'IAINJP', 'IAINJSP', 'IARTINJ', 'IBURSINJ', 'ICARDINJ', 'ICARDINJRP', 'ICARDINJSP', 'ICARINJP', 'ICARTINJ', 'ICAUDINJ', 'ICAVINJ', 'ICAVITINJ', 'ICEREBINJ', 'ICISTERNINJ', 'ICORONINJ', 'ICORONINJP', 'ICORPCAVINJ', 'IDINJ', 'IDISCINJ', 'IDUCTINJ', 'IDURINJ', 'IEPIDINJ', 'IEPITHINJ', 'ILESINJ', 'ILUMINJ', 'ILYMPJINJ', 'IM', 'IMD', 'IMZ', 'IMEDULINJ', 'INTERMENINJ', 'INTERSTITINJ', 'IOINJ', 'IOSSINJ', 'IOVARINJ', 'IPCARDINJ', 'IPERINJ', 'IPINJ', 'IPLRINJ', 'IPROSTINJ', 'IPUMPINJ', 'ISINJ', 'ISTERINJ', 'ISYNINJ', 'ITENDINJ', 'ITESTINJ', 'ITHORINJ', 'ITINJ', 'ITUBINJ', 'ITUMINJ', 'ITYMPINJ', 'IUINJ', 'IUINJC', 'IURETINJ', 'IVASCINJ', 'IVENTINJ', 'IVESINJ', 'IVINJ', 'IVINJBOL', 'IVPUSH', 'IVRPUSH', 'IVSPUSH', 'IVITINJ', 'PAINJ', 'PARENTINJ', 'PDONTINJ', 'PDPINJ', 'PDURINJ', 'PNINJ', 'PNSINJ', 'RBINJ', 'SCINJ', 'SLESINJ', 'SOFTISINJ', 'SQ', 'SUBARACHINJ', 'SUBMUCINJ', 'TRPLACINJ', 'TRTRACHINJ', 'URETHINJ', 'URETINJ', '_Insertion', 'CERVINS', 'IOSURGINS', 'IU', 'LPINS', 'PR', 'SQSURGINS', 'URETHINS', 'VAGINSI', '_Instillation', 'CECINSTL', 'EFT', 'ENTINSTL', 'GT', 'NGT', 'OGT', 'BLADINSTL', 'CAPDINSTL', 'CTINSTL', 'ETINSTL', 'GJT', 'IBRONCHINSTIL', 'IDUODINSTIL', 'IESOPHINSTIL', 'IGASTINSTIL', 'IILEALINJ', 'IOINSTL', 'ISININSTIL', 'ITRACHINSTIL', 'IUINSTL', 'JJTINSTL', 'LARYNGINSTIL', 'NASALINSTIL', 'NASOGASINSTIL', 'NTT', 'OJJ', 'OT', 'PDPINSTL', 'PNSINSTL', 'RECINSTL', 'RECTINSTL', 'SININSTIL', 'SOFTISINSTIL', 'TRACHINSTL', 'TRTYMPINSTIL', 'URETHINSTL', '_IontophoresisRoute', 'IONTO', '_Irrigation', 'GUIRR', 'IGASTIRR', 'ILESIRR', 'IOIRR', 'BLADIRR', 'BLADIRRC', 'BLADIRRT', 'RECIRR', '_LavageRoute', 'IGASTLAV', '_MucosalAbsorptionRoute', 'IDOUDMAB', 'ITRACHMAB', 'SMUCMAB', '_Nebulization', 'ETNEB', '_Rinse', 'DENRINSE', 'ORRINSE', '_SuppositoryRoute', 'URETHSUP', '_Swish', 'SWISHSPIT', 'SWISHSWAL', '_TopicalAbsorptionRoute', 'TTYMPTABSORP', '_TopicalApplication', 'DRESS', 'SWAB', 'TOPICAL', 'BUC', 'CERV', 'DEN', 'GIN', 'HAIR', 'ICORNTA', 'ICORONTA', 'IESOPHTA', 'IILEALTA', 'ILTOP', 'ILUMTA', 'IOTOP', 'LARYNGTA', 'MUC', 'NAIL', 'NASAL', 'OPTHALTA', 'ORALTA', 'ORMUC', 'OROPHARTA', 'PERIANAL', 'PERINEAL', 'PDONTTA', 'RECTAL', 'SCALP', 'OCDRESTA', 'SKIN', 'SUBCONJTA', 'TMUCTA', 'VAGINS', 'INSUF', 'TRNSDERM', '_RouteBySite', '_AmnioticFluidSacRoute', '_BiliaryRoute', '_BodySurfaceRoute', '_BuccalMucosaRoute', '_CecostomyRoute', '_CervicalRoute', '_EndocervicalRoute', '_EnteralRoute', '_EpiduralRoute', '_ExtraAmnioticRoute', '_ExtracorporealCirculationRoute', '_GastricRoute', '_GenitourinaryRoute', '_GingivalRoute', '_HairRoute', '_InterameningealRoute', '_InterstitialRoute', '_IntraabdominalRoute', '_IntraarterialRoute', '_IntraarticularRoute', '_IntrabronchialRoute', '_IntrabursalRoute', '_IntracardiacRoute', '_IntracartilaginousRoute', '_IntracaudalRoute', '_IntracavernosalRoute', '_IntracavitaryRoute', '_IntracerebralRoute', '_IntracervicalRoute', '_IntracisternalRoute', '_IntracornealRoute', '_IntracoronalRoute', '_IntracoronaryRoute', '_IntracorpusCavernosumRoute', '_IntradermalRoute', '_IntradiscalRoute', '_IntraductalRoute', '_IntraduodenalRoute', '_IntraduralRoute', '_IntraepidermalRoute', '_IntraepithelialRoute', '_IntraesophagealRoute', '_IntragastricRoute', '_IntrailealRoute', '_IntralesionalRoute', '_IntraluminalRoute', '_IntralymphaticRoute', '_IntramedullaryRoute', '_IntramuscularRoute', '_IntraocularRoute', '_IntraosseousRoute', '_IntraovarianRoute', '_IntrapericardialRoute', '_IntraperitonealRoute', '_IntrapleuralRoute', '_IntraprostaticRoute', '_IntrapulmonaryRoute', '_IntrasinalRoute', '_IntraspinalRoute', '_IntrasternalRoute', '_IntrasynovialRoute', '_IntratendinousRoute', '_IntratesticularRoute', '_IntrathecalRoute', '_IntrathoracicRoute', '_IntratrachealRoute', '_IntratubularRoute', '_IntratumorRoute', '_IntratympanicRoute', '_IntrauterineRoute', '_IntravascularRoute', '_IntravenousRoute', '_IntraventricularRoute', '_IntravesicleRoute', '_IntravitrealRoute', '_JejunumRoute', '_LacrimalPunctaRoute', '_LaryngealRoute', '_LingualRoute', '_MucousMembraneRoute', '_NailRoute', '_NasalRoute', '_OphthalmicRoute', '_OralRoute', '_OromucosalRoute', '_OropharyngealRoute', '_OticRoute', '_ParanasalSinusesRoute', '_ParenteralRoute', '_PerianalRoute', '_PeriarticularRoute', '_PeriduralRoute', '_PerinealRoute', '_PerineuralRoute', '_PeriodontalRoute', '_PulmonaryRoute', '_RectalRoute', '_RespiratoryTractRoute', '_RetrobulbarRoute', '_ScalpRoute', '_SinusUnspecifiedRoute', '_SkinRoute', '_SoftTissueRoute', '_SubarachnoidRoute', '_SubconjunctivalRoute', '_SubcutaneousRoute', '_SublesionalRoute', '_SublingualRoute', '_SubmucosalRoute', '_TracheostomyRoute', '_TransmucosalRoute', '_TransplacentalRoute', '_TranstrachealRoute', '_TranstympanicRoute', '_UreteralRoute', '_UrethralRoute', '_UrinaryBladderRoute', '_UrinaryTractRoute', '_VaginalRoute', '_VitreousHumourRoute']}, 'type'=>'CodeableConcept', 'path'=>'Immunization.route', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/immunization-route'}},
        'doseQuantity' => {'type'=>'Quantity', 'path'=>'Immunization.doseQuantity', 'min'=>0, 'max'=>1},
        'note' => {'type'=>'Annotation', 'path'=>'Immunization.note', 'min'=>0, 'max'=>Float::INFINITY},
        'explanation' => {'type'=>'Immunization::Explanation', 'path'=>'Immunization.explanation', 'min'=>0, 'max'=>1},
        'reaction' => {'type'=>'Immunization::Reaction', 'path'=>'Immunization.reaction', 'min'=>0, 'max'=>Float::INFINITY},
        'vaccinationProtocol' => {'type'=>'Immunization::VaccinationProtocol', 'path'=>'Immunization.vaccinationProtocol', 'min'=>0, 'max'=>Float::INFINITY}
      }

      class Explanation < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Explanation.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Explanation.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Explanation.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'reason' => {'valid_codes'=>{'http://snomed.info/sct'=>['429060002', '281657000']}, 'type'=>'CodeableConcept', 'path'=>'Explanation.reason', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/immunization-reason'}},
          'reasonNotGiven' => {'valid_codes'=>{'http://hl7.org/fhir/v3/ActReason'=>['_ActAccommodationReason', 'ACCREQNA', 'FLRCNV', 'MEDNEC', 'PAT', '_ActCoverageReason', '_EligibilityActReasonCode', '_ActIneligibilityReason', 'COVSUS', 'DECSD', 'REGERR', '_CoverageEligibilityReason', 'AGE', 'CRIME', 'DIS', 'EMPLOY', 'FINAN', 'HEALTH', 'MULTI', 'PNC', 'STATUTORY', 'VEHIC', 'WORK', '_ActInformationManagementReason', '_ActHealthInformationManagementReason', '_ActConsentInformationAccessOverrideReason', 'OVRER', 'OVRPJ', 'OVRPS', 'OVRTPS', 'PurposeOfUse', 'HMARKT', 'HOPERAT', 'DONAT', 'FRAUD', 'GOV', 'HACCRED', 'HCOMPL', 'HDECD', 'HDIRECT', 'HLEGAL', 'HOUTCOMS', 'HPRGRP', 'HQUALIMP', 'HSYSADMIN', 'MEMADMIN', 'PATADMIN', 'PATSFTY', 'PERFMSR', 'RECORDMGT', 'TRAIN', 'HPAYMT', 'CLMATTCH', 'COVAUTH', 'COVERAGE', 'ELIGDTRM', 'ELIGVER', 'ENROLLM', 'REMITADV', 'HRESCH', 'CLINTRCH', 'PATRQT', 'FAMRQT', 'PWATRNY', 'SUPNWK', 'PUBHLTH', 'DISASTER', 'THREAT', 'TREAT', 'CAREMGT', 'CLINTRL', 'ETREAT', 'POPHLTH', '_ActInformationPrivacyReason', 'MARKT', 'OPERAT', 'LEGAL', 'ACCRED', 'COMPL', 'ENADMIN', 'OUTCOMS', 'PRGRPT', 'QUALIMP', 'SYSADMN', 'PAYMT', 'RESCH', 'SRVC', '_ActInvalidReason', 'ADVSTORAGE', 'COLDCHNBRK', 'EXPLOT', 'OUTSIDESCHED', 'PRODRECALL', '_ActInvoiceCancelReason', 'INCCOVPTY', 'INCINVOICE', 'INCPOLICY', 'INCPROV', '_ActNoImmunizationReason', 'IMMUNE', 'MEDPREC', 'OSTOCK', 'PATOBJ', 'PHILISOP', 'RELIG', 'VACEFF', 'VACSAF', '_ActSupplyFulfillmentRefusalReason', 'FRR01', 'FRR02', 'FRR03', 'FRR04', 'FRR05', 'FRR06', '_ClinicalResearchEventReason', 'RET', 'SCH', 'TRM', 'UNS', '_ClinicalResearchObservationReason', 'NPT', 'PPT', 'UPT', '_CombinedPharmacyOrderSuspendReasonCode', 'ALTCHOICE', 'CLARIF', 'DRUGHIGH', 'HOSPADM', 'LABINT', 'NON-AVAIL', 'PREG', 'SALG', 'SDDI', 'SDUPTHER', 'SINTOL', 'SURG', 'WASHOUT', '_ControlActNullificationReasonCode', 'ALTD', 'EIE', 'NORECMTCH', '_ControlActNullificationRefusalReasonType', 'INRQSTATE', 'NOMATCH', 'NOPRODMTCH', 'NOSERMTCH', 'NOVERMTCH', 'NOPERM', 'NOUSERPERM', 'NOAGNTPERM', 'NOUSRPERM', 'WRNGVER', '_ControlActReason', '_MedicationOrderAbortReasonCode', 'DISCONT', 'INEFFECT', 'MONIT', 'NOREQ', 'NOTCOVER', 'PREFUS', 'RECALL', 'REPLACE', 'DOSECHG', 'REPLACEFIX', 'UNABLE', '_MedicationOrderReleaseReasonCode', 'HOLDDONE', 'HOLDINAP', '_ModifyPrescriptionReasonType', 'ADMINERROR', 'CLINMOD', '_PharmacySupplyEventAbortReason', 'CONTRA', 'FOABORT', 'FOSUSP', 'NOPICK', 'PATDEC', 'QUANTCHG', '_PharmacySupplyEventStockReasonCode', 'FLRSTCK', 'LTC', 'OFFICE', 'PHARM', 'PROG', '_PharmacySupplyRequestRenewalRefusalReasonCode', 'ALREADYRX', 'FAMPHYS', 'MODIFY', 'NEEDAPMT', 'NOTAVAIL', 'NOTPAT', 'ONHOLD', 'PRNA', 'STOPMED', 'TOOEARLY', '_SupplyOrderAbortReasonCode', 'IMPROV', 'INTOL', 'NEWSTR', 'NEWTHER', '_GenericUpdateReasonCode', 'CHGDATA', 'FIXDATA', 'MDATA', 'NEWDATA', 'UMDATA', '_PatientProfileQueryReasonCode', 'ADMREV', 'PATCAR', 'PATREQ', 'PRCREV', 'REGUL', 'RSRCH', 'VALIDATION', '_PharmacySupplyRequestFulfillerRevisionRefusalReasonCode', 'LOCKED', 'UNKWNTARGET', '_RefusalReasonCode', '_SchedulingActReason', 'BLK', 'DEC', 'FIN', 'MED', 'MTG', 'PHY', '_StatusRevisionRefusalReasonCode', 'FILLED', '_SubstanceAdministrationPermissionRefusalReasonCode', 'PATINELIG', 'PROTUNMET', 'PROVUNAUTH', '_SubstanceAdminSubstitutionNotAllowedReason', 'ALGINT', 'COMPCON', 'THERCHAR', 'TRIAL', '_SubstanceAdminSubstitutionReason', 'CT', 'FP', 'OS', 'RR', '_TransferActReason', 'ER', 'RQ', '_ActBillableServiceReason', '_ActBillableClinicalServiceReason', 'BONUS', 'CHD', 'DEP', 'ECH', 'EDU', 'EMP', 'ESP', 'FAM', 'IND', 'INVOICE', 'PROA', 'RECOV', 'RETRO', 'SPC', 'SPO', 'TRAN'], 'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Explanation.reasonNotGiven', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/no-immunization-reason'}}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :reason            # 0-* [ CodeableConcept ]
        attr_accessor :reasonNotGiven    # 0-* [ CodeableConcept ]
      end

      class Reaction < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Reaction.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Reaction.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Reaction.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'date' => {'type'=>'dateTime', 'path'=>'Reaction.date', 'min'=>0, 'max'=>1},
          'detail' => {'type'=>'Reference', 'path'=>'Reaction.detail', 'min'=>0, 'max'=>1},
          'reported' => {'type'=>'boolean', 'path'=>'Reaction.reported', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :date              # 0-1 dateTime
        attr_accessor :detail            # 0-1 Reference()
        attr_accessor :reported          # 0-1 boolean
      end

      class VaccinationProtocol < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'VaccinationProtocol.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'VaccinationProtocol.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'VaccinationProtocol.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'doseSequence' => {'type'=>'positiveInt', 'path'=>'VaccinationProtocol.doseSequence', 'min'=>1, 'max'=>1},
          'description' => {'type'=>'string', 'path'=>'VaccinationProtocol.description', 'min'=>0, 'max'=>1},
          'authority' => {'type'=>'Reference', 'path'=>'VaccinationProtocol.authority', 'min'=>0, 'max'=>1},
          'series' => {'type'=>'string', 'path'=>'VaccinationProtocol.series', 'min'=>0, 'max'=>1},
          'seriesDoses' => {'type'=>'positiveInt', 'path'=>'VaccinationProtocol.seriesDoses', 'min'=>0, 'max'=>1},
          'targetDisease' => {'valid_codes'=>{'http://snomed.info/sct'=>['1857005', '397430003', '14189004', '36989005', '36653000', '76902006', '709410003', '27836007', '398102009']}, 'type'=>'CodeableConcept', 'path'=>'VaccinationProtocol.targetDisease', 'min'=>1, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/vaccination-protocol-dose-target'}},
          'doseStatus' => {'valid_codes'=>{'http://hl7.org/fhir/vaccination-protocol-dose-status'=>['count', 'nocount']}, 'type'=>'CodeableConcept', 'path'=>'VaccinationProtocol.doseStatus', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/vaccination-protocol-dose-status'}},
          'doseStatusReason' => {'valid_codes'=>{'http://hl7.org/fhir/vaccination-protocol-dose-status-reason'=>['advstorage', 'coldchbrk', 'explot', 'outsidesched', 'prodrecall']}, 'type'=>'CodeableConcept', 'path'=>'VaccinationProtocol.doseStatusReason', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/vaccination-protocol-dose-status-reason'}}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :doseSequence      # 1-1 positiveInt
        attr_accessor :description       # 0-1 string
        attr_accessor :authority         # 0-1 Reference()
        attr_accessor :series            # 0-1 string
        attr_accessor :seriesDoses       # 0-1 positiveInt
        attr_accessor :targetDisease     # 1-* [ CodeableConcept ]
        attr_accessor :doseStatus        # 1-1 CodeableConcept
        attr_accessor :doseStatusReason  # 0-1 CodeableConcept
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
      attr_accessor :status              # 1-1 code
      attr_accessor :date                # 0-1 dateTime
      attr_accessor :vaccineCode         # 1-1 CodeableConcept
      attr_accessor :patient             # 1-1 Reference()
      attr_accessor :wasNotGiven         # 1-1 boolean
      attr_accessor :reported            # 1-1 boolean
      attr_accessor :performer           # 0-1 Reference()
      attr_accessor :requester           # 0-1 Reference()
      attr_accessor :encounter           # 0-1 Reference()
      attr_accessor :manufacturer        # 0-1 Reference()
      attr_accessor :location            # 0-1 Reference()
      attr_accessor :lotNumber           # 0-1 string
      attr_accessor :expirationDate      # 0-1 date
      attr_accessor :site                # 0-1 CodeableConcept
      attr_accessor :route               # 0-1 CodeableConcept
      attr_accessor :doseQuantity        # 0-1 Quantity
      attr_accessor :note                # 0-* [ Annotation ]
      attr_accessor :explanation         # 0-1 Immunization::Explanation
      attr_accessor :reaction            # 0-* [ Immunization::Reaction ]
      attr_accessor :vaccinationProtocol # 0-* [ Immunization::VaccinationProtocol ]

      def resourceType
        'Immunization'
      end
    end
  end
end