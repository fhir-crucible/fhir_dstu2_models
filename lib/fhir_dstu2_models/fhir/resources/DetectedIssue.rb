module FHIR
  module DSTU2
    class DetectedIssue < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['author', 'category', 'date', 'identifier', 'implicated', 'patient']
      METADATA = {
        'id' => { 'type' => 'id', 'path' => 'DetectedIssue.id', 'min' => 0, 'max' => 1 },
        'meta' => { 'type' => 'Meta', 'path' => 'DetectedIssue.meta', 'min' => 0, 'max' => 1 },
        'implicitRules' => { 'type' => 'uri', 'path' => 'DetectedIssue.implicitRules', 'min' => 0, 'max' => 1 },
        'language' => { 'type' => 'code', 'path' => 'DetectedIssue.language', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://tools.ietf.org/html/bcp47' } },
        'text' => { 'type' => 'Narrative', 'path' => 'DetectedIssue.text', 'min' => 0, 'max' => 1 },
        'contained' => { 'type' => 'Resource', 'path' => 'DetectedIssue.contained', 'min' => 0, 'max' => Float::INFINITY },
        'extension' => { 'type' => 'Extension', 'path' => 'DetectedIssue.extension', 'min' => 0, 'max' => Float::INFINITY },
        'modifierExtension' => { 'type' => 'Extension', 'path' => 'DetectedIssue.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
        'patient' => { 'type' => 'Reference', 'path' => 'DetectedIssue.patient', 'min' => 0, 'max' => 1 },
        'category' => { 'valid_codes' => { 'http://hl7.org/fhir/v3/ActCode' => ['_ActAccountCode', 'ACCTRECEIVABLE', 'CASH', 'CC', 'AE', 'DN', 'DV', 'MC', 'V', 'PBILLACCT', '_ActAdjudicationCode', '_ActAdjudicationGroupCode', 'CONT', 'DAY', 'LOC', 'MONTH', 'PERIOD', 'PROV', 'WEEK', 'YEAR', 'AA', 'ANF', 'AR', 'AS', '_ActAdjudicationResultActionCode', 'DISPLAY', 'FORM', '_ActBillableModifierCode', 'CPTM', 'HCPCSA', '_ActBillingArrangementCode', 'BLK', 'CAP', 'CONTF', 'FINBILL', 'ROST', 'SESS', 'FFS', 'FFPS', 'FFCS', 'TFS', '_ActBoundedROICode', 'ROIFS', 'ROIPS', '_ActCareProvisionCode', '_ActCredentialedCareCode', '_ActCredentialedCareProvisionPersonCode', 'CACC', 'CAIC', 'CAMC', 'CANC', 'CAPC', 'CBGC', 'CCCC', 'CCGC', 'CCPC', 'CCSC', 'CDEC', 'CDRC', 'CEMC', 'CFPC', 'CIMC', 'CMGC', 'CNEC', 'CNMC', 'CNQC', 'CNSC', 'COGC', 'COMC', 'COPC', 'COSC', 'COTC', 'CPEC', 'CPGC', 'CPHC', 'CPRC', 'CPSC', 'CPYC', 'CROC', 'CRPC', 'CSUC', 'CTSC', 'CURC', 'CVSC', 'LGPC', '_ActCredentialedCareProvisionProgramCode', 'AALC', 'AAMC', 'ABHC', 'ACAC', 'ACHC', 'AHOC', 'ALTC', 'AOSC', 'CACS', 'CAMI', 'CAST', 'CBAR', 'CCAD', 'CCAR', 'CDEP', 'CDGD', 'CDIA', 'CEPI', 'CFEL', 'CHFC', 'CHRO', 'CHYP', 'CMIH', 'CMSC', 'COJR', 'CONC', 'COPD', 'CORT', 'CPAD', 'CPND', 'CPST', 'CSDM', 'CSIC', 'CSLD', 'CSPT', 'CTBU', 'CVDC', 'CWMA', 'CWOH', '_ActEncounterCode', 'AMB', 'EMER', 'FLD', 'HH', 'IMP', 'ACUTE', 'NONAC', 'PRENC', 'SS', 'VR', '_ActMedicalServiceCode', 'ALC', 'CARD', 'CHR', 'DNTL', 'DRGRHB', 'GENRL', 'MED', 'OBS', 'ONC', 'PALL', 'PED', 'PHAR', 'PHYRHB', 'PSYCH', 'SURG', '_ActClaimAttachmentCategoryCode', 'AUTOATTCH', 'DOCUMENT', 'HEALTHREC', 'IMG', 'LABRESULTS', 'MODEL', 'WIATTCH', 'XRAY', '_ActConsentType', 'ICOL', 'IDSCL', 'INFA', 'INFAO', 'INFASO', 'IRDSCL', 'RESEARCH', 'RSDID', 'RSREID', '_ActContainerRegistrationCode', 'ID', 'IP', 'L', 'M', 'O', 'R', 'X', '_ActControlVariable', 'AUTO', 'ENDC', 'REFLEX', '_ActCoverageConfirmationCode', '_ActCoverageAuthorizationConfirmationCode', 'AUTH', 'NAUTH', '_ActCoverageEligibilityConfirmationCode', 'ELG', 'NELG', '_ActCoverageLimitCode', '_ActCoverageQuantityLimitCode', 'COVPRD', 'LFEMX', 'NETAMT', 'PRDMX', 'UNITPRICE', 'UNITQTY', 'COVMX', '_ActCoveredPartyLimitCode', '_ActCoverageTypeCode', '_ActInsurancePolicyCode', 'EHCPOL', 'HSAPOL', 'AUTOPOL', 'COL', 'UNINSMOT', 'PUBLICPOL', 'DENTPRG', 'DISEASEPRG', 'CANPRG', 'ENDRENAL', 'HIVAIDS', 'MANDPOL', 'MENTPRG', 'SAFNET', 'SUBPRG', 'SUBSIDIZ', 'SUBSIDMC', 'SUBSUPP', 'WCBPOL', '_ActInsuranceTypeCode', '_ActHealthInsuranceTypeCode', 'DENTAL', 'DISEASE', 'DRUGPOL', 'HIP', 'LTC', 'MCPOL', 'POS', 'HMO', 'PPO', 'MENTPOL', 'SUBPOL', 'VISPOL', 'DIS', 'EWB', 'FLEXP', 'LIFE', 'ANNU', 'TLIFE', 'ULIFE', 'PNC', 'REI', 'SURPL', 'UMBRL', '_ActProgramTypeCode', 'CHAR', 'CRIME', 'EAP', 'GOVEMP', 'HIRISK', 'IND', 'MILITARY', 'RETIRE', 'SOCIAL', 'VET', '_ActDetectedIssueManagementCode', '_ActAdministrativeDetectedIssueManagementCode', '_AuthorizationIssueManagementCode', 'EMAUTH', '21', '1', '19', '2', '22', '23', '3', '4', '5', '6', '7', '14', '15', '16', '17', '18', '20', '8', '10', '11', '12', '13', '9', '_ActExposureCode', 'CHLDCARE', 'CONVEYNC', 'HLTHCARE', 'HOMECARE', 'HOSPPTNT', 'HOSPVSTR', 'HOUSEHLD', 'INMATE', 'INTIMATE', 'LTRMCARE', 'PLACE', 'PTNTCARE', 'SCHOOL2', 'SOCIAL2', 'SUBSTNCE', 'TRAVINT', 'WORK2', '_ActFinancialTransactionCode', 'CHRG', 'REV', '_ActIncidentCode', 'MVA', 'SCHOOL', 'SPT', 'WPA', '_ActInformationAccessCode', 'ACADR', 'ACALL', 'ACALLG', 'ACCONS', 'ACDEMO', 'ACDI', 'ACIMMUN', 'ACLAB', 'ACMED', 'ACMEDC', 'ACMEN', 'ACOBS', 'ACPOLPRG', 'ACPROV', 'ACPSERV', 'ACSUBSTAB', '_ActInformationAccessContextCode', 'INFAUT', 'INFCON', 'INFCRT', 'INFDNG', 'INFEMER', 'INFPWR', 'INFREG', '_ActInformationCategoryCode', 'ALLCAT', 'ALLGCAT', 'ARCAT', 'COBSCAT', 'DEMOCAT', 'DICAT', 'IMMUCAT', 'LABCAT', 'MEDCCAT', 'MENCAT', 'PSVCCAT', 'RXCAT', '_ActInvoiceElementCode', '_ActInvoiceAdjudicationPaymentCode', '_ActInvoiceAdjudicationPaymentGroupCode', 'ALEC', 'BONUS', 'CFWD', 'EDU', 'EPYMT', 'GARN', 'INVOICE', 'PINV', 'PPRD', 'PROA', 'RECOV', 'RETRO', 'TRAN', '_ActInvoiceAdjudicationPaymentSummaryCode', 'INVTYPE', 'PAYEE', 'PAYOR', 'SENDAPP', '_ActInvoiceDetailCode', '_ActInvoiceDetailClinicalProductCode', 'UNSPSC', '_ActInvoiceDetailDrugProductCode', 'GTIN', 'UPC', '_ActInvoiceDetailGenericCode', '_ActInvoiceDetailGenericAdjudicatorCode', 'COIN', 'COPAYMENT', 'DEDUCTIBLE', 'PAY', 'SPEND', 'COINS', '_ActInvoiceDetailGenericModifierCode', 'AFTHRS', 'ISOL', 'OOO', '_ActInvoiceDetailGenericProviderCode', 'CANCAPT', 'DSC', 'ESA', 'FFSTOP', 'FNLFEE', 'FRSTFEE', 'MARKUP', 'MISSAPT', 'PERFEE', 'PERMBNS', 'RESTOCK', 'TRAVEL', 'URGENT', '_ActInvoiceDetailTaxCode', 'FST', 'HST', 'PST', '_ActInvoiceDetailPreferredAccommodationCode', '_ActEncounterAccommodationCode', '_HL7AccommodationCode', 'I', 'P', 'S', 'SP', 'W', '_ActInvoiceDetailClinicalServiceCode', '_ActInvoiceGroupCode', '_ActInvoiceInterGroupCode', 'CPNDDRGING', 'CPNDINDING', 'CPNDSUPING', 'DRUGING', 'FRAMEING', 'LENSING', 'PRDING', '_ActInvoiceRootGroupCode', 'CPINV', 'CSINV', 'CSPINV', 'FININV', 'OHSINV', 'PAINV', 'RXCINV', 'RXDINV', 'SBFINV', 'VRXINV', '_ActInvoiceElementSummaryCode', '_InvoiceElementAdjudicated', 'ADNFPPELAT', 'ADNFPPELCT', 'ADNFPPMNAT', 'ADNFPPMNCT', 'ADNFSPELAT', 'ADNFSPELCT', 'ADNFSPMNAT', 'ADNFSPMNCT', 'ADNPPPELAT', 'ADNPPPELCT', 'ADNPPPMNAT', 'ADNPPPMNCT', 'ADNPSPELAT', 'ADNPSPELCT', 'ADNPSPMNAT', 'ADNPSPMNCT', 'ADPPPPELAT', 'ADPPPPELCT', 'ADPPPPMNAT', 'ADPPPPMNCT', 'ADPPSPELAT', 'ADPPSPELCT', 'ADPPSPMNAT', 'ADPPSPMNCT', 'ADRFPPELAT', 'ADRFPPELCT', 'ADRFPPMNAT', 'ADRFPPMNCT', 'ADRFSPELAT', 'ADRFSPELCT', 'ADRFSPMNAT', 'ADRFSPMNCT', '_InvoiceElementPaid', 'PDNFPPELAT', 'PDNFPPELCT', 'PDNFPPMNAT', 'PDNFPPMNCT', 'PDNFSPELAT', 'PDNFSPELCT', 'PDNFSPMNAT', 'PDNFSPMNCT', 'PDNPPPELAT', 'PDNPPPELCT', 'PDNPPPMNAT', 'PDNPPPMNCT', 'PDNPSPELAT', 'PDNPSPELCT', 'PDNPSPMNAT', 'PDNPSPMNCT', 'PDPPPPELAT', 'PDPPPPELCT', 'PDPPPPMNAT', 'PDPPPPMNCT', 'PDPPSPELAT', 'PDPPSPELCT', 'PDPPSPMNAT', 'PDPPSPMNCT', '_InvoiceElementSubmitted', 'SBBLELAT', 'SBBLELCT', 'SBNFELAT', 'SBNFELCT', 'SBPDELAT', 'SBPDELCT', '_ActInvoiceOverrideCode', 'COVGE', 'EFORM', 'FAX', 'GFTH', 'LATE', 'MANUAL', 'OOJ', 'ORTHO', 'PAPER', 'PIE', 'PYRDELAY', 'REFNR', 'REPSERV', 'UNRELAT', 'VERBAUTH', '_ActListCode', '_ActObservationList', 'CARELIST', 'CONDLIST', 'INTOLIST', 'PROBLIST', 'RISKLIST', 'GOALLIST', '_ActTherapyDurationWorkingListCode', '_ActMedicationTherapyDurationWorkingListCode', 'ACU', 'CHRON', 'ONET', 'PRN', 'MEDLIST', 'CURMEDLIST', 'DISCMEDLIST', 'HISTMEDLIST', '_ActMonitoringProtocolCode', 'CTLSUB', 'INV', 'LU', 'OTC', 'RX', 'SA', 'SAC', '_ActNonObservationIndicationCode', 'IND01', 'IND02', 'IND03', 'IND04', 'IND05', '_ActObservationVerificationType', 'VFPAPER', '_ActPaymentCode', 'ACH', 'CHK', 'DDP', 'NON', '_ActPharmacySupplyType', 'DF', 'EM', 'SO', 'FF', 'FFC', 'FFP', 'FFSS', 'TF', 'FS', 'MS', 'RF', 'UD', 'RFC', 'RFCS', 'RFF', 'RFFS', 'RFP', 'RFPS', 'RFS', 'TB', 'TBS', 'UDE', '_ActPolicyType', '_ActPrivacyPolicy', '_ActConsentDirective', 'EMRGONLY', 'NOPP', 'OPTIN', 'OPTOUT', '_InformationSensitivityPolicy', '_ActInformationSensitivityPolicy', 'ETH', 'GDIS', 'HIV', 'PSY', 'SCA', 'SDV', 'SEX', 'STD', 'TBOO', 'SICKLE', '_EntitySensitivityPolicyType', 'DEMO', 'DOB', 'GENDER', 'LIVARG', 'MARST', 'RACE', 'REL', '_RoleInformationSensitivityPolicy', 'B', 'EMPL', 'LOCIS', 'SSP', 'ADOL', 'CEL', 'DIA', 'DRGIS', 'EMP', 'PDS', 'PRS', 'COMPT', 'HRCOMPT', 'RESCOMPT', 'RMGTCOMPT', 'ActTrustPolicyType', 'TRSTACCRD', 'TRSTAGRE', 'TRSTASSUR', 'TRSTCERT', 'TRSTFWK', 'TRSTMEC', 'COVPOL', 'SecurityPolicy', 'ObligationPolicy', 'ANONY', 'AOD', 'AUDIT', 'AUDTR', 'CPLYCC', 'CPLYCD', 'CPLYJPP', 'CPLYOPP', 'CPLYOSP', 'CPLYPOL', 'DEID', 'DELAU', 'ENCRYPT', 'ENCRYPTR', 'ENCRYPTT', 'ENCRYPTU', 'HUAPRV', 'MASK', 'MINEC', 'PRIVMARK', 'PSEUD', 'REDACT', 'RefrainPolicy', 'NOAUTH', 'NOCOLLECT', 'NODSCLCD', 'NODSCLCDS', 'NOINTEGRATE', 'NOLIST', 'NOMOU', 'NOORGPOL', 'NOPAT', 'NOPERSISTP', 'NORDSCLCD', 'NORDSCLCDS', 'NORDSCLW', 'NORELINK', 'NOREUSE', 'NOVIP', 'ORCON', '_ActProductAcquisitionCode', 'LOAN', 'RENT', 'TRANSFER', 'SALE', '_ActSpecimenTransportCode', 'SREC', 'SSTOR', 'STRAN', '_ActSpecimenTreatmentCode', 'ACID', 'ALK', 'DEFB', 'FILT', 'LDLP', 'NEUT', 'RECA', 'UFIL', '_ActSubstanceAdministrationCode', 'DRUG', 'FD', 'IMMUNIZ', 'BOOSTER', 'INITIMMUNIZ', '_ActTaskCode', 'OE', 'LABOE', 'MEDOE', 'PATDOC', 'ALLERLREV', 'CLINNOTEE', 'DIAGLISTE', 'DISCHINSTE', 'DISCHSUME', 'PATEDUE', 'PATREPE', 'PROBLISTE', 'RADREPE', 'IMMLREV', 'REMLREV', 'WELLREMLREV', 'PATINFO', 'ALLERLE', 'CDSREV', 'CLINNOTEREV', 'DISCHSUMREV', 'DIAGLISTREV', 'IMMLE', 'LABRREV', 'MICRORREV', 'MICROORGRREV', 'MICROSENSRREV', 'MLREV', 'MARWLREV', 'OREV', 'PATREPREV', 'PROBLISTREV', 'RADREPREV', 'REMLE', 'WELLREMLE', 'RISKASSESS', 'FALLRISK', '_ActTransportationModeCode', '_ActPatientTransportationModeCode', 'AFOOT', 'AMBT', 'AMBAIR', 'AMBGRND', 'AMBHELO', 'LAWENF', 'PRVTRN', 'PUBTRN', '_ObservationType', '_ActSpecObsCode', 'ARTBLD', 'DILUTION', 'AUTO-HIGH', 'AUTO-LOW', 'PRE', 'RERUN', 'EVNFCTS', 'INTFR', 'FIBRIN', 'HEMOLYSIS', 'ICTERUS', 'LIPEMIA', 'VOLUME', 'AVAILABLE', 'CONSUMPTION', 'CURRENT', 'INITIAL', '_AnnotationType', '_ActPatientAnnotationType', 'ANNDI', 'ANNGEN', 'ANNIMM', 'ANNLAB', 'ANNMED', '_GeneticObservationType', 'GENE', '_ImmunizationObservationType', 'OBSANTC', 'OBSANTV', '_IndividualCaseSafetyReportType', 'PAT_ADV_EVNT', 'VAC_PROBLEM', '_LOINCObservationActContextAgeType', '21611-9', '21612-7', '29553-5', '30525-0', '30972-4', '_MedicationObservationType', 'REP_HALF_LIFE', 'SPLCOATING', 'SPLCOLOR', 'SPLIMAGE', 'SPLIMPRINT', 'SPLSCORING', 'SPLSHAPE', 'SPLSIZE', 'SPLSYMBOL', '_ObservationIssueTriggerCodedObservationType', '_CaseTransmissionMode', 'AIRTRNS', 'ANANTRNS', 'ANHUMTRNS', 'BDYFLDTRNS', 'BLDTRNS', 'DERMTRNS', 'ENVTRNS', 'FECTRNS', 'FOMTRNS', 'FOODTRNS', 'HUMHUMTRNS', 'INDTRNS', 'LACTTRNS', 'NOSTRNS', 'PARTRNS', 'PLACTRNS', 'SEXTRNS', 'TRNSFTRNS', 'VECTRNS', 'WATTRNS', '_ObservationQualityMeasureAttribute', 'AGGREGATE', 'COPY', 'CRS', 'DEF', 'DISC', 'FINALDT', 'GUIDE', 'IDUR', 'ITMCNT', 'KEY', 'MEDT', 'MSD', 'MSRADJ', 'MSRAGG', 'MSRIMPROV', 'MSRJUR', 'MSRRPTR', 'MSRRPTTIME', 'MSRSCORE', 'MSRSET', 'MSRTOPIC', 'MSRTP', 'MSRTYPE', 'RAT', 'REF', 'SDE', 'STRAT', 'TRANF', 'USE', '_ObservationSequenceType', 'TIME_ABSOLUTE', 'TIME_RELATIVE', '_ObservationSeriesType', '_ECGObservationSeriesType', 'REPRESENTATIVE_BEAT', 'RHYTHM', '_PatientImmunizationRelatedObservationType', 'CLSSRM', 'GRADE', 'SCHL', 'SCHLDIV', 'TEACHER', '_PopulationInclusionObservationType', 'DENEX', 'DENEXCEP', 'DENOM', 'IPOP', 'IPPOP', 'MSRPOPL', 'MSRPOPLEX', 'NUMER', 'NUMEX', '_PreferenceObservationType', 'PREFSTRENGTH', 'ADVERSE_REACTION', 'ASSERTION', 'CASESER', 'CDIO', 'CRIT', 'CTMO', 'DX', 'ADMDX', 'DISDX', 'INTDX', 'NOI', 'GISTIER', 'HHOBS', 'ISSUE', '_ActAdministrativeDetectedIssueCode', '_ActAdministrativeAuthorizationDetectedIssueCode', 'NAT', 'SUPPRESSED', 'VALIDAT', 'KEY204', 'KEY205', 'COMPLY', 'DUPTHPY', 'DUPTHPCLS', 'DUPTHPGEN', 'ABUSE', 'FRAUD', 'PLYDOC', 'PLYPHRM', 'DOSE', 'DOSECOND', 'DOSEDUR', 'DOSEDURH', 'DOSEDURHIND', 'DOSEDURL', 'DOSEDURLIND', 'DOSEH', 'DOSEHINDA', 'DOSEHIND', 'DOSEHINDSA', 'DOSEHINDW', 'DOSEIVL', 'DOSEIVLIND', 'DOSEL', 'DOSELINDA', 'DOSELIND', 'DOSELINDSA', 'DOSELINDW', 'MDOSE', 'OBSA', 'AGE', 'ADALRT', 'GEALRT', 'PEALRT', 'COND', 'HGHT', 'LACT', 'PREG', 'WGHT', 'CREACT', 'GEN', 'GEND', 'LAB', 'REACT', 'ALGY', 'INT', 'RREACT', 'RALG', 'RAR', 'RINT', 'BUS', 'CODE_INVAL', 'CODE_DEPREC', 'FORMAT', 'ILLEGAL', 'LEN_RANGE', 'LEN_LONG', 'LEN_SHORT', 'MISSCOND', 'MISSMAND', 'NODUPS', 'NOPERSIST', 'REP_RANGE', 'MAXOCCURS', 'MINOCCURS', '_ActAdministrativeRuleDetectedIssueCode', 'KEY206', 'OBSOLETE', '_ActSuppliedItemDetectedIssueCode', '_AdministrationDetectedIssueCode', '_AppropriatenessDetectedIssueCode', '_InteractionDetectedIssueCode', 'FOOD', 'TPROD', 'DRG', 'NHP', 'NONRX', 'PREVINEF', 'DACT', 'TIME', 'ALRTENDLATE', 'ALRTSTRTLATE', '_TimingDetectedIssueCode', 'ENDLATE', 'STRTLATE', '_SupplyDetectedIssueCode', 'ALLDONE', 'FULFIL', 'NOTACTN', 'NOTEQUIV', 'NOTEQUIVGEN', 'NOTEQUIVTHER', 'TIMING', 'INTERVAL', 'MINFREQ', 'HELD', 'TOOLATE', 'TOOSOON', 'HISTORIC', 'PATPREF', 'PATPREFALT', 'KSUBJ', 'KSUBT', 'OINT', 'ALG', 'DALG', 'EALG', 'FALG', 'DINT', 'DNAINT', 'EINT', 'ENAINT', 'FINT', 'FNAINT', 'NAINT', 'SEV', '_FDALabelData', 'FDACOATING', 'FDACOLOR', 'FDAIMPRINTCD', 'FDALOGO', 'FDASCORING', 'FDASHAPE', 'FDASIZE', '_ROIOverlayShape', 'CIRCLE', 'ELLIPSE', 'POINT', 'POLY', 'C', 'DIET', 'BR', 'DM', 'FAST', 'FORMULA', 'GF', 'LF', 'LP', 'LQ', 'LS', 'N', 'NF', 'PAF', 'PAR', 'RD', 'SCH', 'SUPPLEMENT', 'T', 'VLI', 'DRUGPRG', 'F', 'PRLMN', 'SECOBS', 'SECCATOBS', 'SECCLASSOBS', 'SECCONOBS', 'SECINTOBS', 'SECALTINTOBS', 'SECDATINTOBS', 'SECINTCONOBS', 'SECINTPRVOBS', 'SECINTPRVABOBS', 'SECINTPRVRBOBS', 'SECINTSTOBS', 'SECTRSTOBS', 'TRSTACCRDOBS', 'TRSTAGREOBS', 'TRSTCERTOBS', 'TRSTFWKOBS', 'TRSTLOAOBS', 'TRSTMECOBS', 'SUBSIDFFS', 'WRKCOMP', '_ActProcedureCode', '_ActBillableServiceCode', '_HL7DefinedActCodes', 'COPAY', 'DEDUCT', 'DOSEIND', 'PRA', 'STORE'] }, 'type' => 'CodeableConcept', 'path' => 'DetectedIssue.category', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'preferred', 'uri' => 'http://hl7.org/fhir/ValueSet/detectedissue-category' } },
        'severity' => { 'valid_codes' => { 'http://hl7.org/fhir/detectedissue-severity' => ['high', 'moderate', 'low'] }, 'type' => 'code', 'path' => 'DetectedIssue.severity', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/detectedissue-severity' } },
        'implicated' => { 'type' => 'Reference', 'path' => 'DetectedIssue.implicated', 'min' => 0, 'max' => Float::INFINITY },
        'detail' => { 'type' => 'string', 'path' => 'DetectedIssue.detail', 'min' => 0, 'max' => 1 },
        'date' => { 'type' => 'dateTime', 'path' => 'DetectedIssue.date', 'min' => 0, 'max' => 1 },
        'author' => { 'type' => 'Reference', 'path' => 'DetectedIssue.author', 'min' => 0, 'max' => 1 },
        'identifier' => { 'type' => 'Identifier', 'path' => 'DetectedIssue.identifier', 'min' => 0, 'max' => 1 },
        'reference' => { 'type' => 'uri', 'path' => 'DetectedIssue.reference', 'min' => 0, 'max' => 1 },
        'mitigation' => { 'type' => 'DetectedIssue::Mitigation', 'path' => 'DetectedIssue.mitigation', 'min' => 0, 'max' => Float::INFINITY }
      }

      class Mitigation < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Mitigation.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Mitigation.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Mitigation.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'action' => { 'valid_codes' => { 'http://hl7.org/fhir/v3/ActCode' => ['_ActAccountCode', 'ACCTRECEIVABLE', 'CASH', 'CC', 'AE', 'DN', 'DV', 'MC', 'V', 'PBILLACCT', '_ActAdjudicationCode', '_ActAdjudicationGroupCode', 'CONT', 'DAY', 'LOC', 'MONTH', 'PERIOD', 'PROV', 'WEEK', 'YEAR', 'AA', 'ANF', 'AR', 'AS', '_ActAdjudicationResultActionCode', 'DISPLAY', 'FORM', '_ActBillableModifierCode', 'CPTM', 'HCPCSA', '_ActBillingArrangementCode', 'BLK', 'CAP', 'CONTF', 'FINBILL', 'ROST', 'SESS', 'FFS', 'FFPS', 'FFCS', 'TFS', '_ActBoundedROICode', 'ROIFS', 'ROIPS', '_ActCareProvisionCode', '_ActCredentialedCareCode', '_ActCredentialedCareProvisionPersonCode', 'CACC', 'CAIC', 'CAMC', 'CANC', 'CAPC', 'CBGC', 'CCCC', 'CCGC', 'CCPC', 'CCSC', 'CDEC', 'CDRC', 'CEMC', 'CFPC', 'CIMC', 'CMGC', 'CNEC', 'CNMC', 'CNQC', 'CNSC', 'COGC', 'COMC', 'COPC', 'COSC', 'COTC', 'CPEC', 'CPGC', 'CPHC', 'CPRC', 'CPSC', 'CPYC', 'CROC', 'CRPC', 'CSUC', 'CTSC', 'CURC', 'CVSC', 'LGPC', '_ActCredentialedCareProvisionProgramCode', 'AALC', 'AAMC', 'ABHC', 'ACAC', 'ACHC', 'AHOC', 'ALTC', 'AOSC', 'CACS', 'CAMI', 'CAST', 'CBAR', 'CCAD', 'CCAR', 'CDEP', 'CDGD', 'CDIA', 'CEPI', 'CFEL', 'CHFC', 'CHRO', 'CHYP', 'CMIH', 'CMSC', 'COJR', 'CONC', 'COPD', 'CORT', 'CPAD', 'CPND', 'CPST', 'CSDM', 'CSIC', 'CSLD', 'CSPT', 'CTBU', 'CVDC', 'CWMA', 'CWOH', '_ActEncounterCode', 'AMB', 'EMER', 'FLD', 'HH', 'IMP', 'ACUTE', 'NONAC', 'PRENC', 'SS', 'VR', '_ActMedicalServiceCode', 'ALC', 'CARD', 'CHR', 'DNTL', 'DRGRHB', 'GENRL', 'MED', 'OBS', 'ONC', 'PALL', 'PED', 'PHAR', 'PHYRHB', 'PSYCH', 'SURG', '_ActClaimAttachmentCategoryCode', 'AUTOATTCH', 'DOCUMENT', 'HEALTHREC', 'IMG', 'LABRESULTS', 'MODEL', 'WIATTCH', 'XRAY', '_ActConsentType', 'ICOL', 'IDSCL', 'INFA', 'INFAO', 'INFASO', 'IRDSCL', 'RESEARCH', 'RSDID', 'RSREID', '_ActContainerRegistrationCode', 'ID', 'IP', 'L', 'M', 'O', 'R', 'X', '_ActControlVariable', 'AUTO', 'ENDC', 'REFLEX', '_ActCoverageConfirmationCode', '_ActCoverageAuthorizationConfirmationCode', 'AUTH', 'NAUTH', '_ActCoverageEligibilityConfirmationCode', 'ELG', 'NELG', '_ActCoverageLimitCode', '_ActCoverageQuantityLimitCode', 'COVPRD', 'LFEMX', 'NETAMT', 'PRDMX', 'UNITPRICE', 'UNITQTY', 'COVMX', '_ActCoveredPartyLimitCode', '_ActCoverageTypeCode', '_ActInsurancePolicyCode', 'EHCPOL', 'HSAPOL', 'AUTOPOL', 'COL', 'UNINSMOT', 'PUBLICPOL', 'DENTPRG', 'DISEASEPRG', 'CANPRG', 'ENDRENAL', 'HIVAIDS', 'MANDPOL', 'MENTPRG', 'SAFNET', 'SUBPRG', 'SUBSIDIZ', 'SUBSIDMC', 'SUBSUPP', 'WCBPOL', '_ActInsuranceTypeCode', '_ActHealthInsuranceTypeCode', 'DENTAL', 'DISEASE', 'DRUGPOL', 'HIP', 'LTC', 'MCPOL', 'POS', 'HMO', 'PPO', 'MENTPOL', 'SUBPOL', 'VISPOL', 'DIS', 'EWB', 'FLEXP', 'LIFE', 'ANNU', 'TLIFE', 'ULIFE', 'PNC', 'REI', 'SURPL', 'UMBRL', '_ActProgramTypeCode', 'CHAR', 'CRIME', 'EAP', 'GOVEMP', 'HIRISK', 'IND', 'MILITARY', 'RETIRE', 'SOCIAL', 'VET', '_ActDetectedIssueManagementCode', '_ActAdministrativeDetectedIssueManagementCode', '_AuthorizationIssueManagementCode', 'EMAUTH', '21', '1', '19', '2', '22', '23', '3', '4', '5', '6', '7', '14', '15', '16', '17', '18', '20', '8', '10', '11', '12', '13', '9', '_ActExposureCode', 'CHLDCARE', 'CONVEYNC', 'HLTHCARE', 'HOMECARE', 'HOSPPTNT', 'HOSPVSTR', 'HOUSEHLD', 'INMATE', 'INTIMATE', 'LTRMCARE', 'PLACE', 'PTNTCARE', 'SCHOOL2', 'SOCIAL2', 'SUBSTNCE', 'TRAVINT', 'WORK2', '_ActFinancialTransactionCode', 'CHRG', 'REV', '_ActIncidentCode', 'MVA', 'SCHOOL', 'SPT', 'WPA', '_ActInformationAccessCode', 'ACADR', 'ACALL', 'ACALLG', 'ACCONS', 'ACDEMO', 'ACDI', 'ACIMMUN', 'ACLAB', 'ACMED', 'ACMEDC', 'ACMEN', 'ACOBS', 'ACPOLPRG', 'ACPROV', 'ACPSERV', 'ACSUBSTAB', '_ActInformationAccessContextCode', 'INFAUT', 'INFCON', 'INFCRT', 'INFDNG', 'INFEMER', 'INFPWR', 'INFREG', '_ActInformationCategoryCode', 'ALLCAT', 'ALLGCAT', 'ARCAT', 'COBSCAT', 'DEMOCAT', 'DICAT', 'IMMUCAT', 'LABCAT', 'MEDCCAT', 'MENCAT', 'PSVCCAT', 'RXCAT', '_ActInvoiceElementCode', '_ActInvoiceAdjudicationPaymentCode', '_ActInvoiceAdjudicationPaymentGroupCode', 'ALEC', 'BONUS', 'CFWD', 'EDU', 'EPYMT', 'GARN', 'INVOICE', 'PINV', 'PPRD', 'PROA', 'RECOV', 'RETRO', 'TRAN', '_ActInvoiceAdjudicationPaymentSummaryCode', 'INVTYPE', 'PAYEE', 'PAYOR', 'SENDAPP', '_ActInvoiceDetailCode', '_ActInvoiceDetailClinicalProductCode', 'UNSPSC', '_ActInvoiceDetailDrugProductCode', 'GTIN', 'UPC', '_ActInvoiceDetailGenericCode', '_ActInvoiceDetailGenericAdjudicatorCode', 'COIN', 'COPAYMENT', 'DEDUCTIBLE', 'PAY', 'SPEND', 'COINS', '_ActInvoiceDetailGenericModifierCode', 'AFTHRS', 'ISOL', 'OOO', '_ActInvoiceDetailGenericProviderCode', 'CANCAPT', 'DSC', 'ESA', 'FFSTOP', 'FNLFEE', 'FRSTFEE', 'MARKUP', 'MISSAPT', 'PERFEE', 'PERMBNS', 'RESTOCK', 'TRAVEL', 'URGENT', '_ActInvoiceDetailTaxCode', 'FST', 'HST', 'PST', '_ActInvoiceDetailPreferredAccommodationCode', '_ActEncounterAccommodationCode', '_HL7AccommodationCode', 'I', 'P', 'S', 'SP', 'W', '_ActInvoiceDetailClinicalServiceCode', '_ActInvoiceGroupCode', '_ActInvoiceInterGroupCode', 'CPNDDRGING', 'CPNDINDING', 'CPNDSUPING', 'DRUGING', 'FRAMEING', 'LENSING', 'PRDING', '_ActInvoiceRootGroupCode', 'CPINV', 'CSINV', 'CSPINV', 'FININV', 'OHSINV', 'PAINV', 'RXCINV', 'RXDINV', 'SBFINV', 'VRXINV', '_ActInvoiceElementSummaryCode', '_InvoiceElementAdjudicated', 'ADNFPPELAT', 'ADNFPPELCT', 'ADNFPPMNAT', 'ADNFPPMNCT', 'ADNFSPELAT', 'ADNFSPELCT', 'ADNFSPMNAT', 'ADNFSPMNCT', 'ADNPPPELAT', 'ADNPPPELCT', 'ADNPPPMNAT', 'ADNPPPMNCT', 'ADNPSPELAT', 'ADNPSPELCT', 'ADNPSPMNAT', 'ADNPSPMNCT', 'ADPPPPELAT', 'ADPPPPELCT', 'ADPPPPMNAT', 'ADPPPPMNCT', 'ADPPSPELAT', 'ADPPSPELCT', 'ADPPSPMNAT', 'ADPPSPMNCT', 'ADRFPPELAT', 'ADRFPPELCT', 'ADRFPPMNAT', 'ADRFPPMNCT', 'ADRFSPELAT', 'ADRFSPELCT', 'ADRFSPMNAT', 'ADRFSPMNCT', '_InvoiceElementPaid', 'PDNFPPELAT', 'PDNFPPELCT', 'PDNFPPMNAT', 'PDNFPPMNCT', 'PDNFSPELAT', 'PDNFSPELCT', 'PDNFSPMNAT', 'PDNFSPMNCT', 'PDNPPPELAT', 'PDNPPPELCT', 'PDNPPPMNAT', 'PDNPPPMNCT', 'PDNPSPELAT', 'PDNPSPELCT', 'PDNPSPMNAT', 'PDNPSPMNCT', 'PDPPPPELAT', 'PDPPPPELCT', 'PDPPPPMNAT', 'PDPPPPMNCT', 'PDPPSPELAT', 'PDPPSPELCT', 'PDPPSPMNAT', 'PDPPSPMNCT', '_InvoiceElementSubmitted', 'SBBLELAT', 'SBBLELCT', 'SBNFELAT', 'SBNFELCT', 'SBPDELAT', 'SBPDELCT', '_ActInvoiceOverrideCode', 'COVGE', 'EFORM', 'FAX', 'GFTH', 'LATE', 'MANUAL', 'OOJ', 'ORTHO', 'PAPER', 'PIE', 'PYRDELAY', 'REFNR', 'REPSERV', 'UNRELAT', 'VERBAUTH', '_ActListCode', '_ActObservationList', 'CARELIST', 'CONDLIST', 'INTOLIST', 'PROBLIST', 'RISKLIST', 'GOALLIST', '_ActTherapyDurationWorkingListCode', '_ActMedicationTherapyDurationWorkingListCode', 'ACU', 'CHRON', 'ONET', 'PRN', 'MEDLIST', 'CURMEDLIST', 'DISCMEDLIST', 'HISTMEDLIST', '_ActMonitoringProtocolCode', 'CTLSUB', 'INV', 'LU', 'OTC', 'RX', 'SA', 'SAC', '_ActNonObservationIndicationCode', 'IND01', 'IND02', 'IND03', 'IND04', 'IND05', '_ActObservationVerificationType', 'VFPAPER', '_ActPaymentCode', 'ACH', 'CHK', 'DDP', 'NON', '_ActPharmacySupplyType', 'DF', 'EM', 'SO', 'FF', 'FFC', 'FFP', 'FFSS', 'TF', 'FS', 'MS', 'RF', 'UD', 'RFC', 'RFCS', 'RFF', 'RFFS', 'RFP', 'RFPS', 'RFS', 'TB', 'TBS', 'UDE', '_ActPolicyType', '_ActPrivacyPolicy', '_ActConsentDirective', 'EMRGONLY', 'NOPP', 'OPTIN', 'OPTOUT', '_InformationSensitivityPolicy', '_ActInformationSensitivityPolicy', 'ETH', 'GDIS', 'HIV', 'PSY', 'SCA', 'SDV', 'SEX', 'STD', 'TBOO', 'SICKLE', '_EntitySensitivityPolicyType', 'DEMO', 'DOB', 'GENDER', 'LIVARG', 'MARST', 'RACE', 'REL', '_RoleInformationSensitivityPolicy', 'B', 'EMPL', 'LOCIS', 'SSP', 'ADOL', 'CEL', 'DIA', 'DRGIS', 'EMP', 'PDS', 'PRS', 'COMPT', 'HRCOMPT', 'RESCOMPT', 'RMGTCOMPT', 'ActTrustPolicyType', 'TRSTACCRD', 'TRSTAGRE', 'TRSTASSUR', 'TRSTCERT', 'TRSTFWK', 'TRSTMEC', 'COVPOL', 'SecurityPolicy', 'ObligationPolicy', 'ANONY', 'AOD', 'AUDIT', 'AUDTR', 'CPLYCC', 'CPLYCD', 'CPLYJPP', 'CPLYOPP', 'CPLYOSP', 'CPLYPOL', 'DEID', 'DELAU', 'ENCRYPT', 'ENCRYPTR', 'ENCRYPTT', 'ENCRYPTU', 'HUAPRV', 'MASK', 'MINEC', 'PRIVMARK', 'PSEUD', 'REDACT', 'RefrainPolicy', 'NOAUTH', 'NOCOLLECT', 'NODSCLCD', 'NODSCLCDS', 'NOINTEGRATE', 'NOLIST', 'NOMOU', 'NOORGPOL', 'NOPAT', 'NOPERSISTP', 'NORDSCLCD', 'NORDSCLCDS', 'NORDSCLW', 'NORELINK', 'NOREUSE', 'NOVIP', 'ORCON', '_ActProductAcquisitionCode', 'LOAN', 'RENT', 'TRANSFER', 'SALE', '_ActSpecimenTransportCode', 'SREC', 'SSTOR', 'STRAN', '_ActSpecimenTreatmentCode', 'ACID', 'ALK', 'DEFB', 'FILT', 'LDLP', 'NEUT', 'RECA', 'UFIL', '_ActSubstanceAdministrationCode', 'DRUG', 'FD', 'IMMUNIZ', 'BOOSTER', 'INITIMMUNIZ', '_ActTaskCode', 'OE', 'LABOE', 'MEDOE', 'PATDOC', 'ALLERLREV', 'CLINNOTEE', 'DIAGLISTE', 'DISCHINSTE', 'DISCHSUME', 'PATEDUE', 'PATREPE', 'PROBLISTE', 'RADREPE', 'IMMLREV', 'REMLREV', 'WELLREMLREV', 'PATINFO', 'ALLERLE', 'CDSREV', 'CLINNOTEREV', 'DISCHSUMREV', 'DIAGLISTREV', 'IMMLE', 'LABRREV', 'MICRORREV', 'MICROORGRREV', 'MICROSENSRREV', 'MLREV', 'MARWLREV', 'OREV', 'PATREPREV', 'PROBLISTREV', 'RADREPREV', 'REMLE', 'WELLREMLE', 'RISKASSESS', 'FALLRISK', '_ActTransportationModeCode', '_ActPatientTransportationModeCode', 'AFOOT', 'AMBT', 'AMBAIR', 'AMBGRND', 'AMBHELO', 'LAWENF', 'PRVTRN', 'PUBTRN', '_ObservationType', '_ActSpecObsCode', 'ARTBLD', 'DILUTION', 'AUTO-HIGH', 'AUTO-LOW', 'PRE', 'RERUN', 'EVNFCTS', 'INTFR', 'FIBRIN', 'HEMOLYSIS', 'ICTERUS', 'LIPEMIA', 'VOLUME', 'AVAILABLE', 'CONSUMPTION', 'CURRENT', 'INITIAL', '_AnnotationType', '_ActPatientAnnotationType', 'ANNDI', 'ANNGEN', 'ANNIMM', 'ANNLAB', 'ANNMED', '_GeneticObservationType', 'GENE', '_ImmunizationObservationType', 'OBSANTC', 'OBSANTV', '_IndividualCaseSafetyReportType', 'PAT_ADV_EVNT', 'VAC_PROBLEM', '_LOINCObservationActContextAgeType', '21611-9', '21612-7', '29553-5', '30525-0', '30972-4', '_MedicationObservationType', 'REP_HALF_LIFE', 'SPLCOATING', 'SPLCOLOR', 'SPLIMAGE', 'SPLIMPRINT', 'SPLSCORING', 'SPLSHAPE', 'SPLSIZE', 'SPLSYMBOL', '_ObservationIssueTriggerCodedObservationType', '_CaseTransmissionMode', 'AIRTRNS', 'ANANTRNS', 'ANHUMTRNS', 'BDYFLDTRNS', 'BLDTRNS', 'DERMTRNS', 'ENVTRNS', 'FECTRNS', 'FOMTRNS', 'FOODTRNS', 'HUMHUMTRNS', 'INDTRNS', 'LACTTRNS', 'NOSTRNS', 'PARTRNS', 'PLACTRNS', 'SEXTRNS', 'TRNSFTRNS', 'VECTRNS', 'WATTRNS', '_ObservationQualityMeasureAttribute', 'AGGREGATE', 'COPY', 'CRS', 'DEF', 'DISC', 'FINALDT', 'GUIDE', 'IDUR', 'ITMCNT', 'KEY', 'MEDT', 'MSD', 'MSRADJ', 'MSRAGG', 'MSRIMPROV', 'MSRJUR', 'MSRRPTR', 'MSRRPTTIME', 'MSRSCORE', 'MSRSET', 'MSRTOPIC', 'MSRTP', 'MSRTYPE', 'RAT', 'REF', 'SDE', 'STRAT', 'TRANF', 'USE', '_ObservationSequenceType', 'TIME_ABSOLUTE', 'TIME_RELATIVE', '_ObservationSeriesType', '_ECGObservationSeriesType', 'REPRESENTATIVE_BEAT', 'RHYTHM', '_PatientImmunizationRelatedObservationType', 'CLSSRM', 'GRADE', 'SCHL', 'SCHLDIV', 'TEACHER', '_PopulationInclusionObservationType', 'DENEX', 'DENEXCEP', 'DENOM', 'IPOP', 'IPPOP', 'MSRPOPL', 'MSRPOPLEX', 'NUMER', 'NUMEX', '_PreferenceObservationType', 'PREFSTRENGTH', 'ADVERSE_REACTION', 'ASSERTION', 'CASESER', 'CDIO', 'CRIT', 'CTMO', 'DX', 'ADMDX', 'DISDX', 'INTDX', 'NOI', 'GISTIER', 'HHOBS', 'ISSUE', '_ActAdministrativeDetectedIssueCode', '_ActAdministrativeAuthorizationDetectedIssueCode', 'NAT', 'SUPPRESSED', 'VALIDAT', 'KEY204', 'KEY205', 'COMPLY', 'DUPTHPY', 'DUPTHPCLS', 'DUPTHPGEN', 'ABUSE', 'FRAUD', 'PLYDOC', 'PLYPHRM', 'DOSE', 'DOSECOND', 'DOSEDUR', 'DOSEDURH', 'DOSEDURHIND', 'DOSEDURL', 'DOSEDURLIND', 'DOSEH', 'DOSEHINDA', 'DOSEHIND', 'DOSEHINDSA', 'DOSEHINDW', 'DOSEIVL', 'DOSEIVLIND', 'DOSEL', 'DOSELINDA', 'DOSELIND', 'DOSELINDSA', 'DOSELINDW', 'MDOSE', 'OBSA', 'AGE', 'ADALRT', 'GEALRT', 'PEALRT', 'COND', 'HGHT', 'LACT', 'PREG', 'WGHT', 'CREACT', 'GEN', 'GEND', 'LAB', 'REACT', 'ALGY', 'INT', 'RREACT', 'RALG', 'RAR', 'RINT', 'BUS', 'CODE_INVAL', 'CODE_DEPREC', 'FORMAT', 'ILLEGAL', 'LEN_RANGE', 'LEN_LONG', 'LEN_SHORT', 'MISSCOND', 'MISSMAND', 'NODUPS', 'NOPERSIST', 'REP_RANGE', 'MAXOCCURS', 'MINOCCURS', '_ActAdministrativeRuleDetectedIssueCode', 'KEY206', 'OBSOLETE', '_ActSuppliedItemDetectedIssueCode', '_AdministrationDetectedIssueCode', '_AppropriatenessDetectedIssueCode', '_InteractionDetectedIssueCode', 'FOOD', 'TPROD', 'DRG', 'NHP', 'NONRX', 'PREVINEF', 'DACT', 'TIME', 'ALRTENDLATE', 'ALRTSTRTLATE', '_TimingDetectedIssueCode', 'ENDLATE', 'STRTLATE', '_SupplyDetectedIssueCode', 'ALLDONE', 'FULFIL', 'NOTACTN', 'NOTEQUIV', 'NOTEQUIVGEN', 'NOTEQUIVTHER', 'TIMING', 'INTERVAL', 'MINFREQ', 'HELD', 'TOOLATE', 'TOOSOON', 'HISTORIC', 'PATPREF', 'PATPREFALT', 'KSUBJ', 'KSUBT', 'OINT', 'ALG', 'DALG', 'EALG', 'FALG', 'DINT', 'DNAINT', 'EINT', 'ENAINT', 'FINT', 'FNAINT', 'NAINT', 'SEV', '_FDALabelData', 'FDACOATING', 'FDACOLOR', 'FDAIMPRINTCD', 'FDALOGO', 'FDASCORING', 'FDASHAPE', 'FDASIZE', '_ROIOverlayShape', 'CIRCLE', 'ELLIPSE', 'POINT', 'POLY', 'C', 'DIET', 'BR', 'DM', 'FAST', 'FORMULA', 'GF', 'LF', 'LP', 'LQ', 'LS', 'N', 'NF', 'PAF', 'PAR', 'RD', 'SCH', 'SUPPLEMENT', 'T', 'VLI', 'DRUGPRG', 'F', 'PRLMN', 'SECOBS', 'SECCATOBS', 'SECCLASSOBS', 'SECCONOBS', 'SECINTOBS', 'SECALTINTOBS', 'SECDATINTOBS', 'SECINTCONOBS', 'SECINTPRVOBS', 'SECINTPRVABOBS', 'SECINTPRVRBOBS', 'SECINTSTOBS', 'SECTRSTOBS', 'TRSTACCRDOBS', 'TRSTAGREOBS', 'TRSTCERTOBS', 'TRSTFWKOBS', 'TRSTLOAOBS', 'TRSTMECOBS', 'SUBSIDFFS', 'WRKCOMP', '_ActProcedureCode', '_ActBillableServiceCode', '_HL7DefinedActCodes', 'COPAY', 'DEDUCT', 'DOSEIND', 'PRA', 'STORE'] }, 'type' => 'CodeableConcept', 'path' => 'Mitigation.action', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'preferred', 'uri' => 'http://hl7.org/fhir/ValueSet/detectedissue-mitigation-action' } },
          'date' => { 'type' => 'dateTime', 'path' => 'Mitigation.date', 'min' => 0, 'max' => 1 },
          'author' => { 'type' => 'Reference', 'path' => 'Mitigation.author', 'min' => 0, 'max' => 1 }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :action            # 1-1 CodeableConcept
        attr_accessor :date              # 0-1 dateTime
        attr_accessor :author            # 0-1 Reference()
      end

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :patient           # 0-1 Reference()
      attr_accessor :category          # 0-1 CodeableConcept
      attr_accessor :severity          # 0-1 code
      attr_accessor :implicated        # 0-* [ Reference() ]
      attr_accessor :detail            # 0-1 string
      attr_accessor :date              # 0-1 dateTime
      attr_accessor :author            # 0-1 Reference()
      attr_accessor :identifier        # 0-1 Identifier
      attr_accessor :reference         # 0-1 uri
      attr_accessor :mitigation        # 0-* [ DetectedIssue::Mitigation ]

      def resourceType
        'DetectedIssue'
      end
    end
  end
end
