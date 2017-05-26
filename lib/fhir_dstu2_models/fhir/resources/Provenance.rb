module FHIR
  module DSTU2
    class Provenance < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['agent', 'end', 'entity', 'entitytype', 'location', 'patient', 'sigtype', 'start', 'target', 'userid']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Provenance.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'Provenance.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'Provenance.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'Provenance.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'Provenance.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'Provenance.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'Provenance.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Provenance.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'target' => {'type'=>'Reference', 'path'=>'Provenance.target', 'min'=>1, 'max'=>Float::INFINITY},
        'period' => {'type'=>'Period', 'path'=>'Provenance.period', 'min'=>0, 'max'=>1},
        'recorded' => {'type'=>'instant', 'path'=>'Provenance.recorded', 'min'=>1, 'max'=>1},
        'reason' => {'valid_codes'=>{'http://hl7.org/fhir/v3/ActReason'=>['_ActAccommodationReason', 'ACCREQNA', 'FLRCNV', 'MEDNEC', 'PAT', '_ActCoverageReason', '_EligibilityActReasonCode', '_ActIneligibilityReason', 'COVSUS', 'DECSD', 'REGERR', '_CoverageEligibilityReason', 'AGE', 'CRIME', 'DIS', 'EMPLOY', 'FINAN', 'HEALTH', 'MULTI', 'PNC', 'STATUTORY', 'VEHIC', 'WORK', '_ActInformationManagementReason', '_ActHealthInformationManagementReason', '_ActConsentInformationAccessOverrideReason', 'OVRER', 'OVRPJ', 'OVRPS', 'OVRTPS', 'PurposeOfUse', 'HMARKT', 'HOPERAT', 'DONAT', 'FRAUD', 'GOV', 'HACCRED', 'HCOMPL', 'HDECD', 'HDIRECT', 'HLEGAL', 'HOUTCOMS', 'HPRGRP', 'HQUALIMP', 'HSYSADMIN', 'MEMADMIN', 'PATADMIN', 'PATSFTY', 'PERFMSR', 'RECORDMGT', 'TRAIN', 'HPAYMT', 'CLMATTCH', 'COVAUTH', 'COVERAGE', 'ELIGDTRM', 'ELIGVER', 'ENROLLM', 'REMITADV', 'HRESCH', 'CLINTRCH', 'PATRQT', 'FAMRQT', 'PWATRNY', 'SUPNWK', 'PUBHLTH', 'DISASTER', 'THREAT', 'TREAT', 'CAREMGT', 'CLINTRL', 'ETREAT', 'POPHLTH', '_ActInformationPrivacyReason', 'MARKT', 'OPERAT', 'LEGAL', 'ACCRED', 'COMPL', 'ENADMIN', 'OUTCOMS', 'PRGRPT', 'QUALIMP', 'SYSADMN', 'PAYMT', 'RESCH', 'SRVC', '_ActInvalidReason', 'ADVSTORAGE', 'COLDCHNBRK', 'EXPLOT', 'OUTSIDESCHED', 'PRODRECALL', '_ActInvoiceCancelReason', 'INCCOVPTY', 'INCINVOICE', 'INCPOLICY', 'INCPROV', '_ActNoImmunizationReason', 'IMMUNE', 'MEDPREC', 'OSTOCK', 'PATOBJ', 'PHILISOP', 'RELIG', 'VACEFF', 'VACSAF', '_ActSupplyFulfillmentRefusalReason', 'FRR01', 'FRR02', 'FRR03', 'FRR04', 'FRR05', 'FRR06', '_ClinicalResearchEventReason', 'RET', 'SCH', 'TRM', 'UNS', '_ClinicalResearchObservationReason', 'NPT', 'PPT', 'UPT', '_CombinedPharmacyOrderSuspendReasonCode', 'ALTCHOICE', 'CLARIF', 'DRUGHIGH', 'HOSPADM', 'LABINT', 'NON-AVAIL', 'PREG', 'SALG', 'SDDI', 'SDUPTHER', 'SINTOL', 'SURG', 'WASHOUT', '_ControlActNullificationReasonCode', 'ALTD', 'EIE', 'NORECMTCH', '_ControlActNullificationRefusalReasonType', 'INRQSTATE', 'NOMATCH', 'NOPRODMTCH', 'NOSERMTCH', 'NOVERMTCH', 'NOPERM', 'NOUSERPERM', 'NOAGNTPERM', 'NOUSRPERM', 'WRNGVER', '_ControlActReason', '_MedicationOrderAbortReasonCode', 'DISCONT', 'INEFFECT', 'MONIT', 'NOREQ', 'NOTCOVER', 'PREFUS', 'RECALL', 'REPLACE', 'DOSECHG', 'REPLACEFIX', 'UNABLE', '_MedicationOrderReleaseReasonCode', 'HOLDDONE', 'HOLDINAP', '_ModifyPrescriptionReasonType', 'ADMINERROR', 'CLINMOD', '_PharmacySupplyEventAbortReason', 'CONTRA', 'FOABORT', 'FOSUSP', 'NOPICK', 'PATDEC', 'QUANTCHG', '_PharmacySupplyEventStockReasonCode', 'FLRSTCK', 'LTC', 'OFFICE', 'PHARM', 'PROG', '_PharmacySupplyRequestRenewalRefusalReasonCode', 'ALREADYRX', 'FAMPHYS', 'MODIFY', 'NEEDAPMT', 'NOTAVAIL', 'NOTPAT', 'ONHOLD', 'PRNA', 'STOPMED', 'TOOEARLY', '_SupplyOrderAbortReasonCode', 'IMPROV', 'INTOL', 'NEWSTR', 'NEWTHER', '_GenericUpdateReasonCode', 'CHGDATA', 'FIXDATA', 'MDATA', 'NEWDATA', 'UMDATA', '_PatientProfileQueryReasonCode', 'ADMREV', 'PATCAR', 'PATREQ', 'PRCREV', 'REGUL', 'RSRCH', 'VALIDATION', '_PharmacySupplyRequestFulfillerRevisionRefusalReasonCode', 'LOCKED', 'UNKWNTARGET', '_RefusalReasonCode', '_SchedulingActReason', 'BLK', 'DEC', 'FIN', 'MED', 'MTG', 'PHY', '_StatusRevisionRefusalReasonCode', 'FILLED', '_SubstanceAdministrationPermissionRefusalReasonCode', 'PATINELIG', 'PROTUNMET', 'PROVUNAUTH', '_SubstanceAdminSubstitutionNotAllowedReason', 'ALGINT', 'COMPCON', 'THERCHAR', 'TRIAL', '_SubstanceAdminSubstitutionReason', 'CT', 'FP', 'OS', 'RR', '_TransferActReason', 'ER', 'RQ', '_ActBillableServiceReason', '_ActBillableClinicalServiceReason', 'BONUS', 'CHD', 'DEP', 'ECH', 'EDU', 'EMP', 'ESP', 'FAM', 'IND', 'INVOICE', 'PROA', 'RECOV', 'RETRO', 'SPC', 'SPO', 'TRAN']}, 'type'=>'CodeableConcept', 'path'=>'Provenance.reason', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/v3-PurposeOfUse'}},
        'activity' => {'valid_codes'=>{'http://hl7.org/fhir/v3/ActStatus'=>['normal', 'aborted', 'active', 'cancelled', 'completed', 'held', 'new', 'suspended', 'nullified', 'obsolete'], 'http://hl7.org/fhir/v3/DocumentCompletion'=>['AU', 'DI', 'DO', 'IN', 'IP', 'LA', 'NU', 'PA', 'UC']}, 'type'=>'CodeableConcept', 'path'=>'Provenance.activity', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/v3-ProvenanceEventCurrentState'}},
        'location' => {'type'=>'Reference', 'path'=>'Provenance.location', 'min'=>0, 'max'=>1},
        'policy' => {'type'=>'uri', 'path'=>'Provenance.policy', 'min'=>0, 'max'=>Float::INFINITY},
        'agent' => {'type'=>'Provenance::Agent', 'path'=>'Provenance.agent', 'min'=>0, 'max'=>Float::INFINITY},
        'entity' => {'type'=>'Provenance::Entity', 'path'=>'Provenance.entity', 'min'=>0, 'max'=>Float::INFINITY},
        'signature' => {'type'=>'Signature', 'path'=>'Provenance.signature', 'min'=>0, 'max'=>Float::INFINITY}
      }

      class Agent < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Agent.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Agent.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Agent.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'role' => {'valid_codes'=>{'http://hl7.org/fhir/provenance-participant-role'=>['enterer', 'performer', 'author', 'verifier', 'legal', 'attester', 'informant', 'custodian', 'assembler', 'composer']}, 'type'=>'Coding', 'path'=>'Agent.role', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/provenance-agent-role'}},
          'actor' => {'type'=>'Reference', 'path'=>'Agent.actor', 'min'=>0, 'max'=>1},
          'userId' => {'type'=>'Identifier', 'path'=>'Agent.userId', 'min'=>0, 'max'=>1},
          'relatedAgent' => {'type'=>'Provenance::Agent::RelatedAgent', 'path'=>'Agent.relatedAgent', 'min'=>0, 'max'=>Float::INFINITY}
        }

        class RelatedAgent < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          METADATA = {
            'id' => {'type'=>'id', 'path'=>'RelatedAgent.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'RelatedAgent.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'RelatedAgent.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'type' => {'valid_codes'=>{'http://hl7.org/fhir/v3/RoleLinkType'=>['REL', 'BACKUP', 'CONT', 'DIRAUTH', 'IDENT', 'INDAUTH', 'PART', 'REPL']}, 'type'=>'CodeableConcept', 'path'=>'RelatedAgent.type', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/v3-RoleLinkType'}},
            'target' => {'type'=>'uri', 'path'=>'RelatedAgent.target', 'min'=>1, 'max'=>1}
          }

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :type              # 1-1 CodeableConcept
          attr_accessor :target            # 1-1 uri
        end

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :role              # 1-1 Coding
        attr_accessor :actor             # 0-1 Reference()
        attr_accessor :userId            # 0-1 Identifier
        attr_accessor :relatedAgent      # 0-* [ Provenance::Agent::RelatedAgent ]
      end

      class Entity < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Entity.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Entity.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Entity.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'role' => {'valid_codes'=>{'http://hl7.org/fhir/provenance-entity-role'=>['derivation', 'revision', 'quotation', 'source']}, 'type'=>'code', 'path'=>'Entity.role', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/provenance-entity-role'}},
          'type' => {'valid_codes'=>{'http://hl7.org/fhir/resource-types'=>['Account', 'AllergyIntolerance', 'Appointment', 'AppointmentResponse', 'AuditEvent', 'Basic', 'Binary', 'BodySite', 'Bundle', 'CarePlan', 'Claim', 'ClaimResponse', 'ClinicalImpression', 'Communication', 'CommunicationRequest', 'Composition', 'ConceptMap', 'Condition', 'Conformance', 'Contract', 'Coverage', 'DataElement', 'DetectedIssue', 'Device', 'DeviceComponent', 'DeviceMetric', 'DeviceUseRequest', 'DeviceUseStatement', 'DiagnosticOrder', 'DiagnosticReport', 'DocumentManifest', 'DocumentReference', 'DomainResource', 'EligibilityRequest', 'EligibilityResponse', 'Encounter', 'EnrollmentRequest', 'EnrollmentResponse', 'EpisodeOfCare', 'ExplanationOfBenefit', 'FamilyMemberHistory', 'Flag', 'Goal', 'Group', 'HealthcareService', 'ImagingObjectSelection', 'ImagingStudy', 'Immunization', 'ImmunizationRecommendation', 'ImplementationGuide', 'List', 'Location', 'Media', 'Medication', 'MedicationAdministration', 'MedicationDispense', 'MedicationOrder', 'MedicationStatement', 'MessageHeader', 'NamingSystem', 'NutritionOrder', 'Observation', 'OperationDefinition', 'OperationOutcome', 'Order', 'OrderResponse', 'Organization', 'Parameters', 'Patient', 'PaymentNotice', 'PaymentReconciliation', 'Person', 'Practitioner', 'Procedure', 'ProcedureRequest', 'ProcessRequest', 'ProcessResponse', 'Provenance', 'Questionnaire', 'QuestionnaireResponse', 'ReferralRequest', 'RelatedPerson', 'Resource', 'RiskAssessment', 'Schedule', 'SearchParameter', 'Slot', 'Specimen', 'StructureDefinition', 'Subscription', 'Substance', 'SupplyDelivery', 'SupplyRequest', 'TestScript', 'ValueSet', 'VisionPrescription']}, 'type'=>'Coding', 'path'=>'Entity.type', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/resource-types'}},
          'reference' => {'type'=>'uri', 'path'=>'Entity.reference', 'min'=>1, 'max'=>1},
          'display' => {'type'=>'string', 'path'=>'Entity.display', 'min'=>0, 'max'=>1},
          'agent' => {'type'=>'Provenance::Agent', 'path'=>'Entity.agent', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :role              # 1-1 code
        attr_accessor :type              # 1-1 Coding
        attr_accessor :reference         # 1-1 uri
        attr_accessor :display           # 0-1 string
        attr_accessor :agent             # 0-1 Provenance::Agent
      end

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :target            # 1-* [ Reference() ]
      attr_accessor :period            # 0-1 Period
      attr_accessor :recorded          # 1-1 instant
      attr_accessor :reason            # 0-* [ CodeableConcept ]
      attr_accessor :activity          # 0-1 CodeableConcept
      attr_accessor :location          # 0-1 Reference()
      attr_accessor :policy            # 0-* [ uri ]
      attr_accessor :agent             # 0-* [ Provenance::Agent ]
      attr_accessor :entity            # 0-* [ Provenance::Entity ]
      attr_accessor :signature         # 0-* [ Signature ]

      def resourceType
        'Provenance'
      end
    end
  end
end