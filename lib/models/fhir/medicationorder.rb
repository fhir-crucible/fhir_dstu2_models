# Copyright (c) 2011-2015, HL7, Inc & The MITRE Corporation
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without modification, 
# are permitted provided that the following conditions are met:
# 
#     * Redistributions of source code must retain the above copyright notice, this 
#       list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright notice, 
#       this list of conditions and the following disclaimer in the documentation 
#       and/or other materials provided with the distribution.
#     * Neither the name of HL7 nor the names of its contributors may be used to 
#       endorse or promote products derived from this software without specific 
#       prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
# IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT 
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
# POSSIBILITY OF SUCH DAMAGE.

module FHIR
    class MedicationOrder 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::MedicationOrder
        
        SEARCH_PARAMS = [
            'prescriber',
            'identifier',
            'code',
            'patient',
            'datewritten',
            'medication',
            'encounter',
            'status'
        ]
        
        VALID_CODES = {
            status: [ 'active', 'on-hold', 'completed', 'entered-in-error', 'stopped', 'draft' ]
        }
        
        MULTIPLE_TYPES = {
            reason: [ 'reasonCodeableConcept', 'reasonReference' ],
            medication: [ 'medicationCodeableConcept', 'medicationReference' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec dosageInstruction
        class MedicationOrderDosageInstructionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            MULTIPLE_TYPES = {
                asNeeded: [ 'asNeededBoolean', 'asNeededCodeableConcept' ],
                site: [ 'siteCodeableConcept', 'siteReference' ],
                dose: [ 'doseRange', 'doseQuantity' ],
                rate: [ 'rateRatio', 'rateRange' ]
            }
            
            field :text, type: String
            embeds_one :additionalInstructions, class_name:'FHIR::CodeableConcept'
            embeds_one :timing, class_name:'FHIR::Timing'
            field :asNeededBoolean, type: Boolean
            embeds_one :asNeededCodeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :siteCodeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :siteReference, class_name:'FHIR::Reference'
            embeds_one :route, class_name:'FHIR::CodeableConcept'
            embeds_one :method, class_name:'FHIR::CodeableConcept'
            embeds_one :doseRange, class_name:'FHIR::Range'
            embeds_one :doseQuantity, class_name:'FHIR::Quantity'
            embeds_one :rateRatio, class_name:'FHIR::Ratio'
            embeds_one :rateRange, class_name:'FHIR::Range'
            embeds_one :maxDosePerPeriod, class_name:'FHIR::Ratio'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec dispenseRequest
        class MedicationOrderDispenseRequestComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            MULTIPLE_TYPES = {
                medication: [ 'medicationCodeableConcept', 'medicationReference' ]
            }
            
            embeds_one :medicationCodeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :medicationReference, class_name:'FHIR::Reference'
            embeds_one :validityPeriod, class_name:'FHIR::Period'
            field :numberOfRepeatsAllowed, type: Integer
            embeds_one :quantity, class_name:'FHIR::Quantity'
            embeds_one :expectedSupplyDuration, class_name:'FHIR::Quantity'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec substitution
        class MedicationOrderSubstitutionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                reason: [ '_ActAccommodationReason', 'ACCREQNA', 'FLRCNV', 'MEDNEC', 'PAT', '_ActCoverageReason', '_EligibilityActReasonCode', '_ActIneligibilityReason', 'COVSUS', 'DECSD', 'REGERR', '_CoverageEligibilityReason', 'AGE', 'CRIME', 'DIS', 'EMPLOY', 'FINAN', 'HEALTH', 'MULTI', 'PNC', 'STATUTORY', 'VEHIC', 'WORK', '_ActInformationManagementReason', '_ActHealthInformationManagementReason', '_ActConsentInformationAccessOverrideReason', 'OVRER', 'OVRPJ', 'OVRPS', 'OVRTPS', 'PurposeOfUse', 'HMARKT', 'HOPERAT', 'DONAT', 'FRAUD', 'GOV', 'HACCRED', 'HCOMPL', 'HDECD', 'HDIRECT', 'HLEGAL', 'HOUTCOMS', 'HPRGRP', 'HQUALIMP', 'HSYSADMIN', 'MEMADMIN', 'PATADMIN', 'PATSFTY', 'PERFMSR', 'RECORDMGT', 'TRAIN', 'HPAYMT', 'CLMATTCH', 'COVAUTH', 'COVERAGE', 'ELIGDTRM', 'ELIGVER', 'ENROLLM', 'REMITADV', 'HRESCH', 'CLINTRCH', 'PATRQT', 'FAMRQT', 'PWATRNY', 'SUPNWK', 'PUBHLTH', 'DISASTER', 'THREAT', 'TREAT', 'CAREMGT', 'CLINTRL', 'ETREAT', 'POPHLTH', '_ActInformationPrivacyReason', 'MARKT', 'OPERAT', 'LEGAL', 'ACCRED', 'COMPL', 'ENADMIN', 'OUTCOMS', 'PRGRPT', 'QUALIMP', 'SYSADMN', 'PAYMT', 'RESCH', 'SRVC', '_ActInvalidReason', 'ADVSTORAGE', 'COLDCHNBRK', 'EXPLOT', 'OUTSIDESCHED', 'PRODRECALL', '_ActInvoiceCancelReason', 'INCCOVPTY', 'INCINVOICE', 'INCPOLICY', 'INCPROV', '_ActNoImmunizationReason', 'IMMUNE', 'MEDPREC', 'OSTOCK', 'PATOBJ', 'PHILISOP', 'RELIG', 'VACEFF', 'VACSAF', '_ActSupplyFulfillmentRefusalReason', 'FRR01', 'FRR02', 'FRR03', 'FRR04', 'FRR05', 'FRR06', '_ClinicalResearchEventReason', 'RET', 'SCH', 'TRM', 'UNS', '_ClinicalResearchObservationReason', 'NPT', 'PPT', 'UPT', '_CombinedPharmacyOrderSuspendReasonCode', 'ALTCHOICE', 'CLARIF', 'DRUGHIGH', 'HOSPADM', 'LABINT', 'NON-AVAIL', 'PREG', 'SALG', 'SDDI', 'SDUPTHER', 'SINTOL', 'SURG', 'WASHOUT', '_ControlActNullificationReasonCode', 'ALTD', 'EIE', 'NORECMTCH', '_ControlActNullificationRefusalReasonType', 'INRQSTATE', 'NOMATCH', 'NOPRODMTCH', 'NOSERMTCH', 'NOVERMTCH', 'NOPERM', 'NOUSERPERM', 'NOAGNTPERM', 'WRNGVER', '_ControlActReason', '_MedicationOrderAbortReasonCode', 'DISCONT', 'INEFFECT', 'MONIT', 'NOREQ', 'NOTCOVER', 'PREFUS', 'RECALL', 'REPLACE', 'DOSECHG', 'REPLACEFIX', 'UNABLE', '_MedicationOrderReleaseReasonCode', 'HOLDDONE', 'HOLDINAP', '_ModifyPrescriptionReasonType', 'ADMINERROR', 'CLINMOD', '_PharmacySupplyEventAbortReason', 'CONTRA', 'FOABORT', 'FOSUSP', 'NOPICK', 'PATDEC', 'QUANTCHG', '_PharmacySupplyEventStockReasonCode', 'FLRSTCK', 'LTC', 'OFFICE', 'PHARM', 'PROG', '_PharmacySupplyRequestRenewalRefusalReasonCode', 'ALREADYRX', 'FAMPHYS', 'MODIFY', 'NEEDAPMT', 'NOTAVAIL', 'NOTPAT', 'ONHOLD', 'PRNA', 'STOPMED', 'TOOEARLY', '_SupplyOrderAbortReasonCode', 'IMPROV', 'INTOL', 'NEWSTR', 'NEWTHER', '_GenericUpdateReasonCode', 'CHGDATA', 'FIXDATA', 'MDATA', 'NEWDATA', 'UMDATA', '_PatientProfileQueryReasonCode', 'ADMREV', 'PATCAR', 'PATREQ', 'PRCREV', 'REGUL', 'RSRCH', 'VALIDATION', '_PharmacySupplyRequestFulfillerRevisionRefusalReasonCode', 'LOCKED', 'UNKWNTARGET', '_RefusalReasonCode', '_SchedulingActReason', 'BLK', 'DEC', 'FIN', 'MED', 'MTG', 'PHY', '_StatusRevisionRefusalReasonCode', 'FILLED', '_SubstanceAdministrationPermissionRefusalReasonCode', 'PATINELIG', 'PROTUNMET', 'PROVUNAUTH', '_SubstanceAdminSubstitutionNotAllowedReason', 'ALGINT', 'COMPCON', 'THERCHAR', 'TRIAL', '_SubstanceAdminSubstitutionReason', 'CT', 'FP', 'OS', 'RR', '_TransferActReason', 'ER', 'RQ', '_SubstanceAdminSubstitutionReason', 'CT', 'FP', 'OS', 'RR' ],
                fhirType: [ '_ActSubstanceAdminSubstitutionCode', 'E', 'EC', 'BC', 'G', 'TE', 'TB', 'TG', 'F', 'N', '_ActSubstanceAdminSubstitutionCode', 'E', 'EC', 'BC', 'G', 'TE', 'TB', 'TG', 'F', 'N' ]
            }
            
            embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
            validates_presence_of :fhirType
            embeds_one :reason, class_name:'FHIR::CodeableConcept'
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        field :dateWritten, type: String
        validates :dateWritten, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status], :allow_nil => true }
        field :dateEnded, type: String
        validates :dateEnded, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        embeds_one :reasonEnded, class_name:'FHIR::CodeableConcept'
        embeds_one :patient, class_name:'FHIR::Reference'
        embeds_one :prescriber, class_name:'FHIR::Reference'
        embeds_one :encounter, class_name:'FHIR::Reference'
        embeds_one :reasonCodeableConcept, class_name:'FHIR::CodeableConcept'
        embeds_one :reasonReference, class_name:'FHIR::Reference'
        field :note, type: String
        embeds_one :medicationCodeableConcept, class_name:'FHIR::CodeableConcept'
        validates_presence_of :medicationCodeableConcept
        embeds_one :medicationReference, class_name:'FHIR::Reference'
        validates_presence_of :medicationReference
        embeds_many :dosageInstruction, class_name:'FHIR::MedicationOrder::MedicationOrderDosageInstructionComponent'
        embeds_one :dispenseRequest, class_name:'FHIR::MedicationOrder::MedicationOrderDispenseRequestComponent'
        embeds_one :substitution, class_name:'FHIR::MedicationOrder::MedicationOrderSubstitutionComponent'
        embeds_one :priorPrescription, class_name:'FHIR::Reference'
        track_history
    end
end
