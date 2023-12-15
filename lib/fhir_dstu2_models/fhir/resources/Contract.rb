module FHIR
  module DSTU2
    class Contract < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'binding' => ['Attachment', 'Reference']
      }
      SEARCH_PARAMS = ['actor', 'identifier', 'patient', 'signer', 'subject']
      METADATA = {
        'id' => { 'type' => 'id', 'path' => 'Contract.id', 'min' => 0, 'max' => 1 },
        'meta' => { 'type' => 'Meta', 'path' => 'Contract.meta', 'min' => 0, 'max' => 1 },
        'implicitRules' => { 'type' => 'uri', 'path' => 'Contract.implicitRules', 'min' => 0, 'max' => 1 },
        'language' => { 'type' => 'code', 'path' => 'Contract.language', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://tools.ietf.org/html/bcp47' } },
        'text' => { 'type' => 'Narrative', 'path' => 'Contract.text', 'min' => 0, 'max' => 1 },
        'contained' => { 'type' => 'Resource', 'path' => 'Contract.contained', 'min' => 0, 'max' => Float::INFINITY },
        'extension' => { 'type' => 'Extension', 'path' => 'Contract.extension', 'min' => 0, 'max' => Float::INFINITY },
        'modifierExtension' => { 'type' => 'Extension', 'path' => 'Contract.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
        'identifier' => { 'type' => 'Identifier', 'path' => 'Contract.identifier', 'min' => 0, 'max' => 1 },
        'issued' => { 'type' => 'dateTime', 'path' => 'Contract.issued', 'min' => 0, 'max' => 1 },
        'applies' => { 'type' => 'Period', 'path' => 'Contract.applies', 'min' => 0, 'max' => 1 },
        'subject' => { 'type' => 'Reference', 'path' => 'Contract.subject', 'min' => 0, 'max' => Float::INFINITY },
        'authority' => { 'type' => 'Reference', 'path' => 'Contract.authority', 'min' => 0, 'max' => Float::INFINITY },
        'domain' => { 'type' => 'Reference', 'path' => 'Contract.domain', 'min' => 0, 'max' => Float::INFINITY },
        'type' => { 'valid_codes' => { 'http://hl7.org/fhir/contracttypecodes' => ['privacy', 'disclosure'] }, 'type' => 'CodeableConcept', 'path' => 'Contract.type', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/contract-type' } },
        'subType' => { 'valid_codes' => { 'http://hl7.org/fhir/contractsubtypecodes' => ['disclosure-CA', 'disclosure-US'] }, 'type' => 'CodeableConcept', 'path' => 'Contract.subType', 'min' => 0, 'max' => Float::INFINITY, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/contract-subtype' } },
        'action' => { 'valid_codes' => { 'http://www.hl7.org/fhir/contractaction' => ['action-a', 'action-b'] }, 'type' => 'CodeableConcept', 'path' => 'Contract.action', 'min' => 0, 'max' => Float::INFINITY, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/contract-action' } },
        'actionReason' => { 'valid_codes' => { 'http://hl7.org/fhir/v3/ActReason' => ['_ActAccommodationReason', 'ACCREQNA', 'FLRCNV', 'MEDNEC', 'PAT', '_ActCoverageReason', '_EligibilityActReasonCode', '_ActIneligibilityReason', 'COVSUS', 'DECSD', 'REGERR', '_CoverageEligibilityReason', 'AGE', 'CRIME', 'DIS', 'EMPLOY', 'FINAN', 'HEALTH', 'MULTI', 'PNC', 'STATUTORY', 'VEHIC', 'WORK', '_ActInformationManagementReason', '_ActHealthInformationManagementReason', '_ActConsentInformationAccessOverrideReason', 'OVRER', 'OVRPJ', 'OVRPS', 'OVRTPS', 'PurposeOfUse', 'HMARKT', 'HOPERAT', 'DONAT', 'FRAUD', 'GOV', 'HACCRED', 'HCOMPL', 'HDECD', 'HDIRECT', 'HLEGAL', 'HOUTCOMS', 'HPRGRP', 'HQUALIMP', 'HSYSADMIN', 'MEMADMIN', 'PATADMIN', 'PATSFTY', 'PERFMSR', 'RECORDMGT', 'TRAIN', 'HPAYMT', 'CLMATTCH', 'COVAUTH', 'COVERAGE', 'ELIGDTRM', 'ELIGVER', 'ENROLLM', 'REMITADV', 'HRESCH', 'CLINTRCH', 'PATRQT', 'FAMRQT', 'PWATRNY', 'SUPNWK', 'PUBHLTH', 'DISASTER', 'THREAT', 'TREAT', 'CAREMGT', 'CLINTRL', 'ETREAT', 'POPHLTH', '_ActInformationPrivacyReason', 'MARKT', 'OPERAT', 'LEGAL', 'ACCRED', 'COMPL', 'ENADMIN', 'OUTCOMS', 'PRGRPT', 'QUALIMP', 'SYSADMN', 'PAYMT', 'RESCH', 'SRVC', '_ActInvalidReason', 'ADVSTORAGE', 'COLDCHNBRK', 'EXPLOT', 'OUTSIDESCHED', 'PRODRECALL', '_ActInvoiceCancelReason', 'INCCOVPTY', 'INCINVOICE', 'INCPOLICY', 'INCPROV', '_ActNoImmunizationReason', 'IMMUNE', 'MEDPREC', 'OSTOCK', 'PATOBJ', 'PHILISOP', 'RELIG', 'VACEFF', 'VACSAF', '_ActSupplyFulfillmentRefusalReason', 'FRR01', 'FRR02', 'FRR03', 'FRR04', 'FRR05', 'FRR06', '_ClinicalResearchEventReason', 'RET', 'SCH', 'TRM', 'UNS', '_ClinicalResearchObservationReason', 'NPT', 'PPT', 'UPT', '_CombinedPharmacyOrderSuspendReasonCode', 'ALTCHOICE', 'CLARIF', 'DRUGHIGH', 'HOSPADM', 'LABINT', 'NON-AVAIL', 'PREG', 'SALG', 'SDDI', 'SDUPTHER', 'SINTOL', 'SURG', 'WASHOUT', '_ControlActNullificationReasonCode', 'ALTD', 'EIE', 'NORECMTCH', '_ControlActNullificationRefusalReasonType', 'INRQSTATE', 'NOMATCH', 'NOPRODMTCH', 'NOSERMTCH', 'NOVERMTCH', 'NOPERM', 'NOUSERPERM', 'NOAGNTPERM', 'NOUSRPERM', 'WRNGVER', '_ControlActReason', '_MedicationOrderAbortReasonCode', 'DISCONT', 'INEFFECT', 'MONIT', 'NOREQ', 'NOTCOVER', 'PREFUS', 'RECALL', 'REPLACE', 'DOSECHG', 'REPLACEFIX', 'UNABLE', '_MedicationOrderReleaseReasonCode', 'HOLDDONE', 'HOLDINAP', '_ModifyPrescriptionReasonType', 'ADMINERROR', 'CLINMOD', '_PharmacySupplyEventAbortReason', 'CONTRA', 'FOABORT', 'FOSUSP', 'NOPICK', 'PATDEC', 'QUANTCHG', '_PharmacySupplyEventStockReasonCode', 'FLRSTCK', 'LTC', 'OFFICE', 'PHARM', 'PROG', '_PharmacySupplyRequestRenewalRefusalReasonCode', 'ALREADYRX', 'FAMPHYS', 'MODIFY', 'NEEDAPMT', 'NOTAVAIL', 'NOTPAT', 'ONHOLD', 'PRNA', 'STOPMED', 'TOOEARLY', '_SupplyOrderAbortReasonCode', 'IMPROV', 'INTOL', 'NEWSTR', 'NEWTHER', '_GenericUpdateReasonCode', 'CHGDATA', 'FIXDATA', 'MDATA', 'NEWDATA', 'UMDATA', '_PatientProfileQueryReasonCode', 'ADMREV', 'PATCAR', 'PATREQ', 'PRCREV', 'REGUL', 'RSRCH', 'VALIDATION', '_PharmacySupplyRequestFulfillerRevisionRefusalReasonCode', 'LOCKED', 'UNKWNTARGET', '_RefusalReasonCode', '_SchedulingActReason', 'BLK', 'DEC', 'FIN', 'MED', 'MTG', 'PHY', '_StatusRevisionRefusalReasonCode', 'FILLED', '_SubstanceAdministrationPermissionRefusalReasonCode', 'PATINELIG', 'PROTUNMET', 'PROVUNAUTH', '_SubstanceAdminSubstitutionNotAllowedReason', 'ALGINT', 'COMPCON', 'THERCHAR', 'TRIAL', '_SubstanceAdminSubstitutionReason', 'CT', 'FP', 'OS', 'RR', '_TransferActReason', 'ER', 'RQ', '_ActBillableServiceReason', '_ActBillableClinicalServiceReason', 'BONUS', 'CHD', 'DEP', 'ECH', 'EDU', 'EMP', 'ESP', 'FAM', 'IND', 'INVOICE', 'PROA', 'RECOV', 'RETRO', 'SPC', 'SPO', 'TRAN'] }, 'type' => 'CodeableConcept', 'path' => 'Contract.actionReason', 'min' => 0, 'max' => Float::INFINITY, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/v3-PurposeOfUse' } },
        'actor' => { 'type' => 'Contract::Actor', 'path' => 'Contract.actor', 'min' => 0, 'max' => Float::INFINITY },
        'valuedItem' => { 'type' => 'Contract::ValuedItem', 'path' => 'Contract.valuedItem', 'min' => 0, 'max' => Float::INFINITY },
        'signer' => { 'type' => 'Contract::Signer', 'path' => 'Contract.signer', 'min' => 0, 'max' => Float::INFINITY },
        'term' => { 'type' => 'Contract::Term', 'path' => 'Contract.term', 'min' => 0, 'max' => Float::INFINITY },
        'bindingAttachment' => { 'type' => 'Attachment', 'path' => 'Contract.binding[x]', 'min' => 0, 'max' => 1 },
        'bindingReference' => { 'type' => 'Reference', 'path' => 'Contract.binding[x]', 'min' => 0, 'max' => 1 },
        'friendly' => { 'type' => 'Contract::Friendly', 'path' => 'Contract.friendly', 'min' => 0, 'max' => Float::INFINITY },
        'legal' => { 'type' => 'Contract::Legal', 'path' => 'Contract.legal', 'min' => 0, 'max' => Float::INFINITY },
        'rule' => { 'type' => 'Contract::Rule', 'path' => 'Contract.rule', 'min' => 0, 'max' => Float::INFINITY }
      }

      class Actor < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Actor.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Actor.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Actor.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'entity' => { 'type' => 'Reference', 'path' => 'Actor.entity', 'min' => 1, 'max' => 1 },
          'role' => { 'valid_codes' => { 'http://www.hl7.org/fhir/contractactorrole' => ['practitioner', 'patient'] }, 'type' => 'CodeableConcept', 'path' => 'Actor.role', 'min' => 0, 'max' => Float::INFINITY, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/contract-actorrole' } }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :entity            # 1-1 Reference()
        attr_accessor :role              # 0-* [ CodeableConcept ]
      end

      class ValuedItem < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'entity' => ['CodeableConcept', 'Reference']
        }
        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'ValuedItem.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'ValuedItem.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'ValuedItem.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'entityCodeableConcept' => { 'type' => 'CodeableConcept', 'path' => 'ValuedItem.entity[x]', 'min' => 0, 'max' => 1 },
          'entityReference' => { 'type' => 'Reference', 'path' => 'ValuedItem.entity[x]', 'min' => 0, 'max' => 1 },
          'identifier' => { 'type' => 'Identifier', 'path' => 'ValuedItem.identifier', 'min' => 0, 'max' => 1 },
          'effectiveTime' => { 'type' => 'dateTime', 'path' => 'ValuedItem.effectiveTime', 'min' => 0, 'max' => 1 },
          'quantity' => { 'type' => 'Quantity', 'path' => 'ValuedItem.quantity', 'min' => 0, 'max' => 1 },
          'unitPrice' => { 'type' => 'Quantity', 'path' => 'ValuedItem.unitPrice', 'min' => 0, 'max' => 1 },
          'factor' => { 'type' => 'decimal', 'path' => 'ValuedItem.factor', 'min' => 0, 'max' => 1 },
          'points' => { 'type' => 'decimal', 'path' => 'ValuedItem.points', 'min' => 0, 'max' => 1 },
          'net' => { 'type' => 'Quantity', 'path' => 'ValuedItem.net', 'min' => 0, 'max' => 1 }
        }

        attr_accessor :id                    # 0-1 id
        attr_accessor :extension             # 0-* [ Extension ]
        attr_accessor :modifierExtension     # 0-* [ Extension ]
        attr_accessor :entityCodeableConcept # 0-1 CodeableConcept
        attr_accessor :entityReference       # 0-1 Reference()
        attr_accessor :identifier            # 0-1 Identifier
        attr_accessor :effectiveTime         # 0-1 dateTime
        attr_accessor :quantity              # 0-1 Quantity
        attr_accessor :unitPrice             # 0-1 Quantity
        attr_accessor :factor                # 0-1 decimal
        attr_accessor :points                # 0-1 decimal
        attr_accessor :net                   # 0-1 Quantity
      end

      class Signer < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Signer.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Signer.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Signer.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'type' => { 'valid_codes' => { 'http://hl7.org/fhir/contractsignertypecodes' => ['1.2.840.10065.1.12.1.1', '1.2.840.10065.1.12.1.2', '1.2.840.10065.1.12.1.3', '1.2.840.10065.1.12.1.4', '1.2.840.10065.1.12.1.5', '1.2.840.10065.1.12.1.6', '1.2.840.10065.1.12.1.7', '1.2.840.10065.1.12.1.8', '1.2.840.10065.1.12.1.9', '1.2.840.10065.1.12.1.10', '1.2.840.10065.1.12.1.11', '1.2.840.10065.1.12.1.12', '1.2.840.10065.1.12.1.13', '1.2.840.10065.1.12.1.14', '1.2.840.10065.1.12.1.15', '1.2.840.10065.1.12.1.16', '1.2.840.10065.1.12.1.17'] }, 'type' => 'Coding', 'path' => 'Signer.type', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'preferred', 'uri' => 'http://hl7.org/fhir/ValueSet/contract-signer-type' } },
          'party' => { 'type' => 'Reference', 'path' => 'Signer.party', 'min' => 1, 'max' => 1 },
          'signature' => { 'type' => 'string', 'path' => 'Signer.signature', 'min' => 1, 'max' => 1 }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :type              # 1-1 Coding
        attr_accessor :party             # 1-1 Reference()
        attr_accessor :signature         # 1-1 string
      end

      class Term < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Term.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Term.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Term.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'identifier' => { 'type' => 'Identifier', 'path' => 'Term.identifier', 'min' => 0, 'max' => 1 },
          'issued' => { 'type' => 'dateTime', 'path' => 'Term.issued', 'min' => 0, 'max' => 1 },
          'applies' => { 'type' => 'Period', 'path' => 'Term.applies', 'min' => 0, 'max' => 1 },
          'type' => { 'valid_codes' => { 'http://hl7.org/fhir/contracttermtypecodes' => ['OralHealth', 'Vision'] }, 'type' => 'CodeableConcept', 'path' => 'Term.type', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/contract-term-type' } },
          'subType' => { 'valid_codes' => { 'http://hl7.org/fhir/contracttermsubtypecodes' => ['OralHealth-Basic', 'OralHealth-Major', 'OralHealth-Orthodontic'] }, 'type' => 'CodeableConcept', 'path' => 'Term.subType', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/contract-term-subtype' } },
          'subject' => { 'type' => 'Reference', 'path' => 'Term.subject', 'min' => 0, 'max' => 1 },
          'action' => { 'valid_codes' => { 'http://www.hl7.org/fhir/contractaction' => ['action-a', 'action-b'] }, 'type' => 'CodeableConcept', 'path' => 'Term.action', 'min' => 0, 'max' => Float::INFINITY, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/contract-action' } },
          'actionReason' => { 'valid_codes' => { 'http://hl7.org/fhir/v3/ActReason' => ['_ActAccommodationReason', 'ACCREQNA', 'FLRCNV', 'MEDNEC', 'PAT', '_ActCoverageReason', '_EligibilityActReasonCode', '_ActIneligibilityReason', 'COVSUS', 'DECSD', 'REGERR', '_CoverageEligibilityReason', 'AGE', 'CRIME', 'DIS', 'EMPLOY', 'FINAN', 'HEALTH', 'MULTI', 'PNC', 'STATUTORY', 'VEHIC', 'WORK', '_ActInformationManagementReason', '_ActHealthInformationManagementReason', '_ActConsentInformationAccessOverrideReason', 'OVRER', 'OVRPJ', 'OVRPS', 'OVRTPS', 'PurposeOfUse', 'HMARKT', 'HOPERAT', 'DONAT', 'FRAUD', 'GOV', 'HACCRED', 'HCOMPL', 'HDECD', 'HDIRECT', 'HLEGAL', 'HOUTCOMS', 'HPRGRP', 'HQUALIMP', 'HSYSADMIN', 'MEMADMIN', 'PATADMIN', 'PATSFTY', 'PERFMSR', 'RECORDMGT', 'TRAIN', 'HPAYMT', 'CLMATTCH', 'COVAUTH', 'COVERAGE', 'ELIGDTRM', 'ELIGVER', 'ENROLLM', 'REMITADV', 'HRESCH', 'CLINTRCH', 'PATRQT', 'FAMRQT', 'PWATRNY', 'SUPNWK', 'PUBHLTH', 'DISASTER', 'THREAT', 'TREAT', 'CAREMGT', 'CLINTRL', 'ETREAT', 'POPHLTH', '_ActInformationPrivacyReason', 'MARKT', 'OPERAT', 'LEGAL', 'ACCRED', 'COMPL', 'ENADMIN', 'OUTCOMS', 'PRGRPT', 'QUALIMP', 'SYSADMN', 'PAYMT', 'RESCH', 'SRVC', '_ActInvalidReason', 'ADVSTORAGE', 'COLDCHNBRK', 'EXPLOT', 'OUTSIDESCHED', 'PRODRECALL', '_ActInvoiceCancelReason', 'INCCOVPTY', 'INCINVOICE', 'INCPOLICY', 'INCPROV', '_ActNoImmunizationReason', 'IMMUNE', 'MEDPREC', 'OSTOCK', 'PATOBJ', 'PHILISOP', 'RELIG', 'VACEFF', 'VACSAF', '_ActSupplyFulfillmentRefusalReason', 'FRR01', 'FRR02', 'FRR03', 'FRR04', 'FRR05', 'FRR06', '_ClinicalResearchEventReason', 'RET', 'SCH', 'TRM', 'UNS', '_ClinicalResearchObservationReason', 'NPT', 'PPT', 'UPT', '_CombinedPharmacyOrderSuspendReasonCode', 'ALTCHOICE', 'CLARIF', 'DRUGHIGH', 'HOSPADM', 'LABINT', 'NON-AVAIL', 'PREG', 'SALG', 'SDDI', 'SDUPTHER', 'SINTOL', 'SURG', 'WASHOUT', '_ControlActNullificationReasonCode', 'ALTD', 'EIE', 'NORECMTCH', '_ControlActNullificationRefusalReasonType', 'INRQSTATE', 'NOMATCH', 'NOPRODMTCH', 'NOSERMTCH', 'NOVERMTCH', 'NOPERM', 'NOUSERPERM', 'NOAGNTPERM', 'NOUSRPERM', 'WRNGVER', '_ControlActReason', '_MedicationOrderAbortReasonCode', 'DISCONT', 'INEFFECT', 'MONIT', 'NOREQ', 'NOTCOVER', 'PREFUS', 'RECALL', 'REPLACE', 'DOSECHG', 'REPLACEFIX', 'UNABLE', '_MedicationOrderReleaseReasonCode', 'HOLDDONE', 'HOLDINAP', '_ModifyPrescriptionReasonType', 'ADMINERROR', 'CLINMOD', '_PharmacySupplyEventAbortReason', 'CONTRA', 'FOABORT', 'FOSUSP', 'NOPICK', 'PATDEC', 'QUANTCHG', '_PharmacySupplyEventStockReasonCode', 'FLRSTCK', 'LTC', 'OFFICE', 'PHARM', 'PROG', '_PharmacySupplyRequestRenewalRefusalReasonCode', 'ALREADYRX', 'FAMPHYS', 'MODIFY', 'NEEDAPMT', 'NOTAVAIL', 'NOTPAT', 'ONHOLD', 'PRNA', 'STOPMED', 'TOOEARLY', '_SupplyOrderAbortReasonCode', 'IMPROV', 'INTOL', 'NEWSTR', 'NEWTHER', '_GenericUpdateReasonCode', 'CHGDATA', 'FIXDATA', 'MDATA', 'NEWDATA', 'UMDATA', '_PatientProfileQueryReasonCode', 'ADMREV', 'PATCAR', 'PATREQ', 'PRCREV', 'REGUL', 'RSRCH', 'VALIDATION', '_PharmacySupplyRequestFulfillerRevisionRefusalReasonCode', 'LOCKED', 'UNKWNTARGET', '_RefusalReasonCode', '_SchedulingActReason', 'BLK', 'DEC', 'FIN', 'MED', 'MTG', 'PHY', '_StatusRevisionRefusalReasonCode', 'FILLED', '_SubstanceAdministrationPermissionRefusalReasonCode', 'PATINELIG', 'PROTUNMET', 'PROVUNAUTH', '_SubstanceAdminSubstitutionNotAllowedReason', 'ALGINT', 'COMPCON', 'THERCHAR', 'TRIAL', '_SubstanceAdminSubstitutionReason', 'CT', 'FP', 'OS', 'RR', '_TransferActReason', 'ER', 'RQ', '_ActBillableServiceReason', '_ActBillableClinicalServiceReason', 'BONUS', 'CHD', 'DEP', 'ECH', 'EDU', 'EMP', 'ESP', 'FAM', 'IND', 'INVOICE', 'PROA', 'RECOV', 'RETRO', 'SPC', 'SPO', 'TRAN'] }, 'type' => 'CodeableConcept', 'path' => 'Term.actionReason', 'min' => 0, 'max' => Float::INFINITY, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/v3-PurposeOfUse' } },
          'actor' => { 'type' => 'Contract::Term::Actor', 'path' => 'Term.actor', 'min' => 0, 'max' => Float::INFINITY },
          'text' => { 'type' => 'string', 'path' => 'Term.text', 'min' => 0, 'max' => 1 },
          'valuedItem' => { 'type' => 'Contract::Term::ValuedItem', 'path' => 'Term.valuedItem', 'min' => 0, 'max' => Float::INFINITY },
          'group' => { 'type' => 'Contract::Term', 'path' => 'Term.group', 'min' => 0, 'max' => Float::INFINITY }
        }

        class Actor < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          METADATA = {
            'id' => { 'type' => 'id', 'path' => 'Actor.id', 'min' => 0, 'max' => 1 },
            'extension' => { 'type' => 'Extension', 'path' => 'Actor.extension', 'min' => 0, 'max' => Float::INFINITY },
            'modifierExtension' => { 'type' => 'Extension', 'path' => 'Actor.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
            'entity' => { 'type' => 'Reference', 'path' => 'Actor.entity', 'min' => 1, 'max' => 1 },
            'role' => { 'valid_codes' => { 'http://www.hl7.org/fhir/contractactorrole' => ['practitioner', 'patient'] }, 'type' => 'CodeableConcept', 'path' => 'Actor.role', 'min' => 0, 'max' => Float::INFINITY, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/contract-actorrole' } }
          }

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :entity            # 1-1 Reference()
          attr_accessor :role              # 0-* [ CodeableConcept ]
        end

        class ValuedItem < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          MULTIPLE_TYPES = {
            'entity' => ['CodeableConcept', 'Reference']
          }
          METADATA = {
            'id' => { 'type' => 'id', 'path' => 'ValuedItem.id', 'min' => 0, 'max' => 1 },
            'extension' => { 'type' => 'Extension', 'path' => 'ValuedItem.extension', 'min' => 0, 'max' => Float::INFINITY },
            'modifierExtension' => { 'type' => 'Extension', 'path' => 'ValuedItem.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
            'entityCodeableConcept' => { 'type' => 'CodeableConcept', 'path' => 'ValuedItem.entity[x]', 'min' => 0, 'max' => 1 },
            'entityReference' => { 'type' => 'Reference', 'path' => 'ValuedItem.entity[x]', 'min' => 0, 'max' => 1 },
            'identifier' => { 'type' => 'Identifier', 'path' => 'ValuedItem.identifier', 'min' => 0, 'max' => 1 },
            'effectiveTime' => { 'type' => 'dateTime', 'path' => 'ValuedItem.effectiveTime', 'min' => 0, 'max' => 1 },
            'quantity' => { 'type' => 'Quantity', 'path' => 'ValuedItem.quantity', 'min' => 0, 'max' => 1 },
            'unitPrice' => { 'type' => 'Quantity', 'path' => 'ValuedItem.unitPrice', 'min' => 0, 'max' => 1 },
            'factor' => { 'type' => 'decimal', 'path' => 'ValuedItem.factor', 'min' => 0, 'max' => 1 },
            'points' => { 'type' => 'decimal', 'path' => 'ValuedItem.points', 'min' => 0, 'max' => 1 },
            'net' => { 'type' => 'Quantity', 'path' => 'ValuedItem.net', 'min' => 0, 'max' => 1 }
          }

          attr_accessor :id                    # 0-1 id
          attr_accessor :extension             # 0-* [ Extension ]
          attr_accessor :modifierExtension     # 0-* [ Extension ]
          attr_accessor :entityCodeableConcept # 0-1 CodeableConcept
          attr_accessor :entityReference       # 0-1 Reference()
          attr_accessor :identifier            # 0-1 Identifier
          attr_accessor :effectiveTime         # 0-1 dateTime
          attr_accessor :quantity              # 0-1 Quantity
          attr_accessor :unitPrice             # 0-1 Quantity
          attr_accessor :factor                # 0-1 decimal
          attr_accessor :points                # 0-1 decimal
          attr_accessor :net                   # 0-1 Quantity
        end

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :identifier        # 0-1 Identifier
        attr_accessor :issued            # 0-1 dateTime
        attr_accessor :applies           # 0-1 Period
        attr_accessor :type              # 0-1 CodeableConcept
        attr_accessor :subType           # 0-1 CodeableConcept
        attr_accessor :subject           # 0-1 Reference()
        attr_accessor :action            # 0-* [ CodeableConcept ]
        attr_accessor :actionReason      # 0-* [ CodeableConcept ]
        attr_accessor :actor             # 0-* [ Contract::Term::Actor ]
        attr_accessor :text              # 0-1 string
        attr_accessor :valuedItem        # 0-* [ Contract::Term::ValuedItem ]
        attr_accessor :group             # 0-* [ Contract::Term ]
      end

      class Friendly < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'content' => ['Attachment', 'Reference']
        }
        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Friendly.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Friendly.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Friendly.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'contentAttachment' => { 'type' => 'Attachment', 'path' => 'Friendly.content[x]', 'min' => 1, 'max' => 1 },
          'contentReference' => { 'type' => 'Reference', 'path' => 'Friendly.content[x]', 'min' => 1, 'max' => 1 }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :contentAttachment # 1-1 Attachment
        attr_accessor :contentReference  # 1-1 Reference()
      end

      class Legal < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'content' => ['Attachment', 'Reference']
        }
        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Legal.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Legal.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Legal.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'contentAttachment' => { 'type' => 'Attachment', 'path' => 'Legal.content[x]', 'min' => 1, 'max' => 1 },
          'contentReference' => { 'type' => 'Reference', 'path' => 'Legal.content[x]', 'min' => 1, 'max' => 1 }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :contentAttachment # 1-1 Attachment
        attr_accessor :contentReference  # 1-1 Reference()
      end

      class Rule < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'content' => ['Attachment', 'Reference']
        }
        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Rule.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Rule.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Rule.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'contentAttachment' => { 'type' => 'Attachment', 'path' => 'Rule.content[x]', 'min' => 1, 'max' => 1 },
          'contentReference' => { 'type' => 'Reference', 'path' => 'Rule.content[x]', 'min' => 1, 'max' => 1 }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :contentAttachment # 1-1 Attachment
        attr_accessor :contentReference  # 1-1 Reference()
      end

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :identifier        # 0-1 Identifier
      attr_accessor :issued            # 0-1 dateTime
      attr_accessor :applies           # 0-1 Period
      attr_accessor :subject           # 0-* [ Reference() ]
      attr_accessor :authority         # 0-* [ Reference() ]
      attr_accessor :domain            # 0-* [ Reference() ]
      attr_accessor :type              # 0-1 CodeableConcept
      attr_accessor :subType           # 0-* [ CodeableConcept ]
      attr_accessor :action            # 0-* [ CodeableConcept ]
      attr_accessor :actionReason      # 0-* [ CodeableConcept ]
      attr_accessor :actor             # 0-* [ Contract::Actor ]
      attr_accessor :valuedItem        # 0-* [ Contract::ValuedItem ]
      attr_accessor :signer            # 0-* [ Contract::Signer ]
      attr_accessor :term              # 0-* [ Contract::Term ]
      attr_accessor :bindingAttachment # 0-1 Attachment
      attr_accessor :bindingReference  # 0-1 Reference()
      attr_accessor :friendly          # 0-* [ Contract::Friendly ]
      attr_accessor :legal             # 0-* [ Contract::Legal ]
      attr_accessor :rule              # 0-* [ Contract::Rule ]

      def resourceType
        'Contract'
      end
    end
  end
end
