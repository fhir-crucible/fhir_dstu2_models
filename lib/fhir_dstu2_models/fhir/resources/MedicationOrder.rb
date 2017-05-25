module FHIR
  module DSTU2
    class MedicationOrder < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'reason' => ['CodeableConcept', 'Reference'],
        'medication' => ['CodeableConcept', 'Reference']
      }
      SEARCH_PARAMS = ['code', 'datewritten', 'encounter', 'identifier', 'medication', 'patient', 'prescriber', 'status']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'MedicationOrder.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'MedicationOrder.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'MedicationOrder.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'MedicationOrder.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'MedicationOrder.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'MedicationOrder.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'MedicationOrder.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'MedicationOrder.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'MedicationOrder.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'dateWritten' => {'type'=>'dateTime', 'path'=>'MedicationOrder.dateWritten', 'min'=>0, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/medication-order-status'=>['active', 'on-hold', 'completed', 'entered-in-error', 'stopped', 'draft']}, 'type'=>'code', 'path'=>'MedicationOrder.status', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/medication-order-status'}},
        'dateEnded' => {'type'=>'dateTime', 'path'=>'MedicationOrder.dateEnded', 'min'=>0, 'max'=>1},
        'reasonEnded' => {'type'=>'CodeableConcept', 'path'=>'MedicationOrder.reasonEnded', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
        'patient' => {'type'=>'Reference', 'path'=>'MedicationOrder.patient', 'min'=>0, 'max'=>1},
        'prescriber' => {'type'=>'Reference', 'path'=>'MedicationOrder.prescriber', 'min'=>0, 'max'=>1},
        'encounter' => {'type'=>'Reference', 'path'=>'MedicationOrder.encounter', 'min'=>0, 'max'=>1},
        'reasonCodeableConcept' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'MedicationOrder.reason[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/condition-code'}},
        'reasonReference' => {'type'=>'Reference', 'path'=>'MedicationOrder.reason[x]', 'min'=>0, 'max'=>1},
        'note' => {'type'=>'string', 'path'=>'MedicationOrder.note', 'min'=>0, 'max'=>1},
        'medicationCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'MedicationOrder.medication[x]', 'min'=>1, 'max'=>1},
        'medicationReference' => {'type'=>'Reference', 'path'=>'MedicationOrder.medication[x]', 'min'=>1, 'max'=>1},
        'dosageInstruction' => {'type'=>'MedicationOrder::DosageInstruction', 'path'=>'MedicationOrder.dosageInstruction', 'min'=>0, 'max'=>Float::INFINITY},
        'dispenseRequest' => {'type'=>'MedicationOrder::DispenseRequest', 'path'=>'MedicationOrder.dispenseRequest', 'min'=>0, 'max'=>1},
        'substitution' => {'type'=>'MedicationOrder::Substitution', 'path'=>'MedicationOrder.substitution', 'min'=>0, 'max'=>1},
        'priorPrescription' => {'type'=>'Reference', 'path'=>'MedicationOrder.priorPrescription', 'min'=>0, 'max'=>1}
      }

      class DosageInstruction < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'asNeeded' => ['boolean', 'CodeableConcept'],
          'site' => ['CodeableConcept', 'Reference'],
          'dose' => ['Range', 'Quantity'],
          'rate' => ['Ratio', 'Range']
        }
        METADATA = {
          'id' => {'type'=>'id', 'path'=>'DosageInstruction.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'DosageInstruction.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'DosageInstruction.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'text' => {'type'=>'string', 'path'=>'DosageInstruction.text', 'min'=>0, 'max'=>1},
          'additionalInstructions' => {'type'=>'CodeableConcept', 'path'=>'DosageInstruction.additionalInstructions', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
          'timing' => {'type'=>'Timing', 'path'=>'DosageInstruction.timing', 'min'=>0, 'max'=>1},
          'asNeededBoolean' => {'type'=>'boolean', 'path'=>'DosageInstruction.asNeeded[x]', 'min'=>0, 'max'=>1},
          'asNeededCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'DosageInstruction.asNeeded[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
          'siteCodeableConcept' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'DosageInstruction.site[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/approach-site-codes'}},
          'siteReference' => {'type'=>'Reference', 'path'=>'DosageInstruction.site[x]', 'min'=>0, 'max'=>1},
          'route' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'DosageInstruction.route', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/route-codes'}},
          'method' => {'local_name'=>'local_method', 'type'=>'CodeableConcept', 'path'=>'DosageInstruction.method', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
          'doseRange' => {'type'=>'Range', 'path'=>'DosageInstruction.dose[x]', 'min'=>0, 'max'=>1},
          'doseQuantity' => {'type'=>'Quantity', 'path'=>'DosageInstruction.dose[x]', 'min'=>0, 'max'=>1},
          'rateRatio' => {'type'=>'Ratio', 'path'=>'DosageInstruction.rate[x]', 'min'=>0, 'max'=>1},
          'rateRange' => {'type'=>'Range', 'path'=>'DosageInstruction.rate[x]', 'min'=>0, 'max'=>1},
          'maxDosePerPeriod' => {'type'=>'Ratio', 'path'=>'DosageInstruction.maxDosePerPeriod', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                      # 0-1 id
        attr_accessor :extension               # 0-* [ Extension ]
        attr_accessor :modifierExtension       # 0-* [ Extension ]
        attr_accessor :text                    # 0-1 string
        attr_accessor :additionalInstructions  # 0-1 CodeableConcept
        attr_accessor :timing                  # 0-1 Timing
        attr_accessor :asNeededBoolean         # 0-1 boolean
        attr_accessor :asNeededCodeableConcept # 0-1 CodeableConcept
        attr_accessor :siteCodeableConcept     # 0-1 CodeableConcept
        attr_accessor :siteReference           # 0-1 Reference()
        attr_accessor :route                   # 0-1 CodeableConcept
        attr_accessor :local_method            # 0-1 CodeableConcept
        attr_accessor :doseRange               # 0-1 Range
        attr_accessor :doseQuantity            # 0-1 Quantity
        attr_accessor :rateRatio               # 0-1 Ratio
        attr_accessor :rateRange               # 0-1 Range
        attr_accessor :maxDosePerPeriod        # 0-1 Ratio
      end

      class DispenseRequest < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'medication' => ['CodeableConcept', 'Reference']
        }
        METADATA = {
          'id' => {'type'=>'id', 'path'=>'DispenseRequest.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'DispenseRequest.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'DispenseRequest.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'medicationCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'DispenseRequest.medication[x]', 'min'=>0, 'max'=>1},
          'medicationReference' => {'type'=>'Reference', 'path'=>'DispenseRequest.medication[x]', 'min'=>0, 'max'=>1},
          'validityPeriod' => {'type'=>'Period', 'path'=>'DispenseRequest.validityPeriod', 'min'=>0, 'max'=>1},
          'numberOfRepeatsAllowed' => {'type'=>'positiveInt', 'path'=>'DispenseRequest.numberOfRepeatsAllowed', 'min'=>0, 'max'=>1},
          'quantity' => {'type'=>'Quantity', 'path'=>'DispenseRequest.quantity', 'min'=>0, 'max'=>1},
          'expectedSupplyDuration' => {'type'=>'Quantity', 'path'=>'DispenseRequest.expectedSupplyDuration', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                        # 0-1 id
        attr_accessor :extension                 # 0-* [ Extension ]
        attr_accessor :modifierExtension         # 0-* [ Extension ]
        attr_accessor :medicationCodeableConcept # 0-1 CodeableConcept
        attr_accessor :medicationReference       # 0-1 Reference()
        attr_accessor :validityPeriod            # 0-1 Period
        attr_accessor :numberOfRepeatsAllowed    # 0-1 positiveInt
        attr_accessor :quantity                  # 0-1 Quantity
        attr_accessor :expectedSupplyDuration    # 0-1 Quantity
      end

      class Substitution < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Substitution.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Substitution.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Substitution.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'type' => {'valid_codes'=>{'http://hl7.org/fhir/v3/substanceAdminSubstitution'=>['E', 'EC', 'BC', 'G', 'TE', 'TB', 'TG', 'F', 'N']}, 'type'=>'CodeableConcept', 'path'=>'Substitution.type', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/v3-ActSubstanceAdminSubstitutionCode'}},
          'reason' => {'valid_codes'=>{'http://hl7.org/fhir/v3/ActReason'=>['_ActAccommodationReason', 'ACCREQNA', 'FLRCNV', 'MEDNEC', 'PAT', '_ActCoverageReason', '_EligibilityActReasonCode', '_ActIneligibilityReason', 'COVSUS', 'DECSD', 'REGERR', '_CoverageEligibilityReason', 'AGE', 'CRIME', 'DIS', 'EMPLOY', 'FINAN', 'HEALTH', 'MULTI', 'PNC', 'STATUTORY', 'VEHIC', 'WORK', '_ActInformationManagementReason', '_ActHealthInformationManagementReason', '_ActConsentInformationAccessOverrideReason', 'OVRER', 'OVRPJ', 'OVRPS', 'OVRTPS', 'PurposeOfUse', 'HMARKT', 'HOPERAT', 'DONAT', 'FRAUD', 'GOV', 'HACCRED', 'HCOMPL', 'HDECD', 'HDIRECT', 'HLEGAL', 'HOUTCOMS', 'HPRGRP', 'HQUALIMP', 'HSYSADMIN', 'MEMADMIN', 'PATADMIN', 'PATSFTY', 'PERFMSR', 'RECORDMGT', 'TRAIN', 'HPAYMT', 'CLMATTCH', 'COVAUTH', 'COVERAGE', 'ELIGDTRM', 'ELIGVER', 'ENROLLM', 'REMITADV', 'HRESCH', 'CLINTRCH', 'PATRQT', 'FAMRQT', 'PWATRNY', 'SUPNWK', 'PUBHLTH', 'DISASTER', 'THREAT', 'TREAT', 'CAREMGT', 'CLINTRL', 'ETREAT', 'POPHLTH', '_ActInformationPrivacyReason', 'MARKT', 'OPERAT', 'LEGAL', 'ACCRED', 'COMPL', 'ENADMIN', 'OUTCOMS', 'PRGRPT', 'QUALIMP', 'SYSADMN', 'PAYMT', 'RESCH', 'SRVC', '_ActInvalidReason', 'ADVSTORAGE', 'COLDCHNBRK', 'EXPLOT', 'OUTSIDESCHED', 'PRODRECALL', '_ActInvoiceCancelReason', 'INCCOVPTY', 'INCINVOICE', 'INCPOLICY', 'INCPROV', '_ActNoImmunizationReason', 'IMMUNE', 'MEDPREC', 'OSTOCK', 'PATOBJ', 'PHILISOP', 'RELIG', 'VACEFF', 'VACSAF', '_ActSupplyFulfillmentRefusalReason', 'FRR01', 'FRR02', 'FRR03', 'FRR04', 'FRR05', 'FRR06', '_ClinicalResearchEventReason', 'RET', 'SCH', 'TRM', 'UNS', '_ClinicalResearchObservationReason', 'NPT', 'PPT', 'UPT', '_CombinedPharmacyOrderSuspendReasonCode', 'ALTCHOICE', 'CLARIF', 'DRUGHIGH', 'HOSPADM', 'LABINT', 'NON-AVAIL', 'PREG', 'SALG', 'SDDI', 'SDUPTHER', 'SINTOL', 'SURG', 'WASHOUT', '_ControlActNullificationReasonCode', 'ALTD', 'EIE', 'NORECMTCH', '_ControlActNullificationRefusalReasonType', 'INRQSTATE', 'NOMATCH', 'NOPRODMTCH', 'NOSERMTCH', 'NOVERMTCH', 'NOPERM', 'NOUSERPERM', 'NOAGNTPERM', 'NOUSRPERM', 'WRNGVER', '_ControlActReason', '_MedicationOrderAbortReasonCode', 'DISCONT', 'INEFFECT', 'MONIT', 'NOREQ', 'NOTCOVER', 'PREFUS', 'RECALL', 'REPLACE', 'DOSECHG', 'REPLACEFIX', 'UNABLE', '_MedicationOrderReleaseReasonCode', 'HOLDDONE', 'HOLDINAP', '_ModifyPrescriptionReasonType', 'ADMINERROR', 'CLINMOD', '_PharmacySupplyEventAbortReason', 'CONTRA', 'FOABORT', 'FOSUSP', 'NOPICK', 'PATDEC', 'QUANTCHG', '_PharmacySupplyEventStockReasonCode', 'FLRSTCK', 'LTC', 'OFFICE', 'PHARM', 'PROG', '_PharmacySupplyRequestRenewalRefusalReasonCode', 'ALREADYRX', 'FAMPHYS', 'MODIFY', 'NEEDAPMT', 'NOTAVAIL', 'NOTPAT', 'ONHOLD', 'PRNA', 'STOPMED', 'TOOEARLY', '_SupplyOrderAbortReasonCode', 'IMPROV', 'INTOL', 'NEWSTR', 'NEWTHER', '_GenericUpdateReasonCode', 'CHGDATA', 'FIXDATA', 'MDATA', 'NEWDATA', 'UMDATA', '_PatientProfileQueryReasonCode', 'ADMREV', 'PATCAR', 'PATREQ', 'PRCREV', 'REGUL', 'RSRCH', 'VALIDATION', '_PharmacySupplyRequestFulfillerRevisionRefusalReasonCode', 'LOCKED', 'UNKWNTARGET', '_RefusalReasonCode', '_SchedulingActReason', 'BLK', 'DEC', 'FIN', 'MED', 'MTG', 'PHY', '_StatusRevisionRefusalReasonCode', 'FILLED', '_SubstanceAdministrationPermissionRefusalReasonCode', 'PATINELIG', 'PROTUNMET', 'PROVUNAUTH', '_SubstanceAdminSubstitutionNotAllowedReason', 'ALGINT', 'COMPCON', 'THERCHAR', 'TRIAL', 'CT', 'FP', 'OS', 'RR', '_TransferActReason', 'ER', 'RQ', '_ActBillableServiceReason', '_ActBillableClinicalServiceReason', 'BONUS', 'CHD', 'DEP', 'ECH', 'EDU', 'EMP', 'ESP', 'FAM', 'IND', 'INVOICE', 'PROA', 'RECOV', 'RETRO', 'SPC', 'SPO', 'TRAN']}, 'type'=>'CodeableConcept', 'path'=>'Substitution.reason', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/v3-SubstanceAdminSubstitutionReason'}}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :type              # 1-1 CodeableConcept
        attr_accessor :reason            # 0-1 CodeableConcept
      end

      attr_accessor :id                        # 0-1 id
      attr_accessor :meta                      # 0-1 Meta
      attr_accessor :implicitRules             # 0-1 uri
      attr_accessor :language                  # 0-1 code
      attr_accessor :text                      # 0-1 Narrative
      attr_accessor :contained                 # 0-* [ Resource ]
      attr_accessor :extension                 # 0-* [ Extension ]
      attr_accessor :modifierExtension         # 0-* [ Extension ]
      attr_accessor :identifier                # 0-* [ Identifier ]
      attr_accessor :dateWritten               # 0-1 dateTime
      attr_accessor :status                    # 0-1 code
      attr_accessor :dateEnded                 # 0-1 dateTime
      attr_accessor :reasonEnded               # 0-1 CodeableConcept
      attr_accessor :patient                   # 0-1 Reference()
      attr_accessor :prescriber                # 0-1 Reference()
      attr_accessor :encounter                 # 0-1 Reference()
      attr_accessor :reasonCodeableConcept     # 0-1 CodeableConcept
      attr_accessor :reasonReference           # 0-1 Reference()
      attr_accessor :note                      # 0-1 string
      attr_accessor :medicationCodeableConcept # 1-1 CodeableConcept
      attr_accessor :medicationReference       # 1-1 Reference()
      attr_accessor :dosageInstruction         # 0-* [ MedicationOrder::DosageInstruction ]
      attr_accessor :dispenseRequest           # 0-1 MedicationOrder::DispenseRequest
      attr_accessor :substitution              # 0-1 MedicationOrder::Substitution
      attr_accessor :priorPrescription         # 0-1 Reference()

      def resourceType
        'MedicationOrder'
      end
    end
  end
end