# Copyright (c) 2011-2014, HL7, Inc & The MITRE Corporation
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
    class Conformance 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Conformance
        
        SEARCH_PARAMS = [
            'date',
            'software',
            'resource',
            'profile',
            'format',
            'description',
            'fhirversion',
            'version',
            'url',
            'supported-profile',
            'mode',
            'security',
            'name',
            'publisher',
            'event',
            'status'
            ]
        
        VALID_CODES = {
            status: [ "draft", "active", "retired" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec contact
        class ConformanceContactComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :name, type: String
            embeds_many :telecom, class_name:'FHIR::ContactPoint'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec software
        class ConformanceSoftwareComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :name, type: String
            validates_presence_of :name
            field :versionNum, type: String
            field :releaseDate, type: FHIR::PartialDateTime
        end
        
        # This is an ugly hack to deal with embedded structures in the spec implementation
        class ConformanceImplementationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :description, type: String
            validates_presence_of :description
            field :url, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec certificate
        class ConformanceRestSecurityCertificateComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :fhirType, type: String
            field :blob, type: Moped::BSON::Binary
        end
        
        # This is an ugly hack to deal with embedded structures in the spec security
        class ConformanceRestSecurityComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                service: [ "OAuth", "OAuth2", "NTLM", "Basic", "Kerberos" ]
            }
            
            field :cors, type: Boolean
            embeds_many :service, class_name:'FHIR::CodeableConcept'
            field :description, type: String
            embeds_many :certificate, class_name:'FHIR::Conformance::ConformanceRestSecurityCertificateComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec interaction
        class ResourceInteractionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                code: [ "read", "vread", "update", "delete", "history-instance", "validate", "history-type", "create", "search-type" ]
            }
            
            field :code, type: String
            validates :code, :inclusion => { in: VALID_CODES[:code] }
            validates_presence_of :code
            field :documentation, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec searchParam
        class ConformanceRestResourceSearchParamComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ "number", "date", "string", "token", "reference", "composite", "quantity", "uri" ],
                target: [ "AllergyIntolerance", "Appointment", "AppointmentResponse", "AuditEvent", "Basic", "Binary", "BodySite", "Bundle", "CarePlan", "Claim", "ClaimResponse", "ClinicalImpression", "Communication", "CommunicationRequest", "Composition", "ConceptMap", "Condition", "Conformance", "Contract", "Contraindication", "Coverage", "DataElement", "Device", "DeviceComponent", "DeviceMetric", "DeviceUseRequest", "DeviceUseStatement", "DiagnosticOrder", "DiagnosticReport", "DocumentManifest", "DocumentReference", "EligibilityRequest", "EligibilityResponse", "Encounter", "EnrollmentRequest", "EnrollmentResponse", "EpisodeOfCare", "ExplanationOfBenefit", "FamilyMemberHistory", "Flag", "Goal", "Group", "HealthcareService", "ImagingObjectSelection", "ImagingStudy", "Immunization", "ImmunizationRecommendation", "List", "Location", "Media", "Medication", "MedicationAdministration", "MedicationDispense", "MedicationPrescription", "MedicationStatement", "MessageHeader", "NamingSystem", "NutritionOrder", "Observation", "OperationDefinition", "OperationOutcome", "Order", "OrderResponse", "Organization", "Patient", "PaymentNotice", "PaymentReconciliation", "Person", "Practitioner", "Procedure", "ProcedureRequest", "ProcessRequest", "ProcessResponse", "Provenance", "Questionnaire", "QuestionnaireAnswers", "ReferralRequest", "RelatedPerson", "RiskAssessment", "Schedule", "SearchParameter", "Slot", "Specimen", "StructureDefinition", "Subscription", "Substance", "Supply", "TestScript", "ValueSet", "VisionPrescription" ]
            }
            
            field :name, type: String
            validates_presence_of :name
            field :definition, type: String
            field :fhirType, type: String
            validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType] }
            validates_presence_of :fhirType
            field :documentation, type: String
            field :target, type: Array # Array of Strings
            validates :target, :inclusion => { in: VALID_CODES[:target], :allow_nil => true }
            field :chain, type: Array # Array of Strings
        end
        
        # This is an ugly hack to deal with embedded structures in the spec resource
        class ConformanceRestResourceComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                versioning: [ "no-version", "versioned", "versioned-update" ],
                fhirType: [ "AllergyIntolerance", "Appointment", "AppointmentResponse", "AuditEvent", "Basic", "Binary", "BodySite", "Bundle", "CarePlan", "Claim", "ClaimResponse", "ClinicalImpression", "Communication", "CommunicationRequest", "Composition", "ConceptMap", "Condition", "Conformance", "Contract", "Contraindication", "Coverage", "DataElement", "Device", "DeviceComponent", "DeviceMetric", "DeviceUseRequest", "DeviceUseStatement", "DiagnosticOrder", "DiagnosticReport", "DocumentManifest", "DocumentReference", "EligibilityRequest", "EligibilityResponse", "Encounter", "EnrollmentRequest", "EnrollmentResponse", "EpisodeOfCare", "ExplanationOfBenefit", "FamilyMemberHistory", "Flag", "Goal", "Group", "HealthcareService", "ImagingObjectSelection", "ImagingStudy", "Immunization", "ImmunizationRecommendation", "List", "Location", "Media", "Medication", "MedicationAdministration", "MedicationDispense", "MedicationPrescription", "MedicationStatement", "MessageHeader", "NamingSystem", "NutritionOrder", "Observation", "OperationDefinition", "OperationOutcome", "Order", "OrderResponse", "Organization", "Patient", "PaymentNotice", "PaymentReconciliation", "Person", "Practitioner", "Procedure", "ProcedureRequest", "ProcessRequest", "ProcessResponse", "Provenance", "Questionnaire", "QuestionnaireAnswers", "ReferralRequest", "RelatedPerson", "RiskAssessment", "Schedule", "SearchParameter", "Slot", "Specimen", "StructureDefinition", "Subscription", "Substance", "Supply", "TestScript", "ValueSet", "VisionPrescription" ]
            }
            
            field :fhirType, type: String
            validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType] }
            validates_presence_of :fhirType
            embeds_one :profile, class_name:'FHIR::Reference'
            embeds_many :interaction, class_name:'FHIR::Conformance::ResourceInteractionComponent'
            validates_presence_of :interaction
            field :versioning, type: String
            validates :versioning, :inclusion => { in: VALID_CODES[:versioning], :allow_nil => true }
            field :readHistory, type: Boolean
            field :updateCreate, type: Boolean
            field :conditionalCreate, type: Boolean
            field :conditionalUpdate, type: Boolean
            field :conditionalDelete, type: Boolean
            field :searchInclude, type: Array # Array of Strings
            embeds_many :searchParam, class_name:'FHIR::Conformance::ConformanceRestResourceSearchParamComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec interaction
        class SystemInteractionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                code: [ "transaction", "search-system", "history-system" ]
            }
            
            field :code, type: String
            validates :code, :inclusion => { in: VALID_CODES[:code] }
            validates_presence_of :code
            field :documentation, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec operation
        class ConformanceRestOperationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :name, type: String
            validates_presence_of :name
            embeds_one :definition, class_name:'FHIR::Reference'
            validates_presence_of :definition
        end
        
        # This is an ugly hack to deal with embedded structures in the spec rest
        class ConformanceRestComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                mode: [ "client", "server" ]
            }
            
            field :mode, type: String
            validates :mode, :inclusion => { in: VALID_CODES[:mode] }
            validates_presence_of :mode
            field :documentation, type: String
            embeds_one :security, class_name:'FHIR::Conformance::ConformanceRestSecurityComponent'
            embeds_many :resource, class_name:'FHIR::Conformance::ConformanceRestResourceComponent'
            validates_presence_of :resource
            embeds_many :interaction, class_name:'FHIR::Conformance::SystemInteractionComponent'
            embeds_many :operation, class_name:'FHIR::Conformance::ConformanceRestOperationComponent'
            field :documentMailbox, type: Array # Array of Strings
            field :compartment, type: Array # Array of Strings
        end
        
        # This is an ugly hack to deal with embedded structures in the spec event
        class ConformanceMessagingEventComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                mode: [ "sender", "receiver" ],
                protocol: [ "http", "ftp", "mllp" ],
                code: [ "MedicationAdministration-Complete", "MedicationAdministration-Nullification", "MedicationAdministration-Recording", "MedicationAdministration-Update", "admin-notify", "diagnosticreport-provide", "observation-provide", "patient-link", "patient-unlink", "valueset-expand" ],
                focus: [ "AllergyIntolerance", "Appointment", "AppointmentResponse", "AuditEvent", "Basic", "Binary", "BodySite", "Bundle", "CarePlan", "Claim", "ClaimResponse", "ClinicalImpression", "Communication", "CommunicationRequest", "Composition", "ConceptMap", "Condition", "Conformance", "Contract", "Contraindication", "Coverage", "DataElement", "Device", "DeviceComponent", "DeviceMetric", "DeviceUseRequest", "DeviceUseStatement", "DiagnosticOrder", "DiagnosticReport", "DocumentManifest", "DocumentReference", "EligibilityRequest", "EligibilityResponse", "Encounter", "EnrollmentRequest", "EnrollmentResponse", "EpisodeOfCare", "ExplanationOfBenefit", "FamilyMemberHistory", "Flag", "Goal", "Group", "HealthcareService", "ImagingObjectSelection", "ImagingStudy", "Immunization", "ImmunizationRecommendation", "List", "Location", "Media", "Medication", "MedicationAdministration", "MedicationDispense", "MedicationPrescription", "MedicationStatement", "MessageHeader", "NamingSystem", "NutritionOrder", "Observation", "OperationDefinition", "OperationOutcome", "Order", "OrderResponse", "Organization", "Patient", "PaymentNotice", "PaymentReconciliation", "Person", "Practitioner", "Procedure", "ProcedureRequest", "ProcessRequest", "ProcessResponse", "Provenance", "Questionnaire", "QuestionnaireAnswers", "ReferralRequest", "RelatedPerson", "RiskAssessment", "Schedule", "SearchParameter", "Slot", "Specimen", "StructureDefinition", "Subscription", "Substance", "Supply", "TestScript", "ValueSet", "VisionPrescription" ],
                category: [ "Consequence", "Currency", "Notification" ]
            }
            
            embeds_one :code, class_name:'FHIR::Coding'
            validates_presence_of :code
            field :category, type: String
            validates :category, :inclusion => { in: VALID_CODES[:category], :allow_nil => true }
            field :mode, type: String
            validates :mode, :inclusion => { in: VALID_CODES[:mode] }
            validates_presence_of :mode
            embeds_many :protocol, class_name:'FHIR::Coding'
            field :focus, type: String
            validates :focus, :inclusion => { in: VALID_CODES[:focus] }
            validates_presence_of :focus
            embeds_one :request, class_name:'FHIR::Reference'
            validates_presence_of :request
            embeds_one :response, class_name:'FHIR::Reference'
            validates_presence_of :response
            field :documentation, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec messaging
        class ConformanceMessagingComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :endpoint, type: String
            embeds_one :reliableCache, class_name:'FHIR::unsignedInt'
            field :documentation, type: String
            embeds_many :event, class_name:'FHIR::Conformance::ConformanceMessagingEventComponent'
            validates_presence_of :event
        end
        
        # This is an ugly hack to deal with embedded structures in the spec document
        class ConformanceDocumentComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                mode: [ "producer", "consumer" ]
            }
            
            field :mode, type: String
            validates :mode, :inclusion => { in: VALID_CODES[:mode] }
            validates_presence_of :mode
            field :documentation, type: String
            embeds_one :profile, class_name:'FHIR::Reference'
            validates_presence_of :profile
        end
        
        field :url, type: String
        field :versionNum, type: String
        field :name, type: String
        field :publisher, type: String
        embeds_many :contact, class_name:'FHIR::Conformance::ConformanceContactComponent'
        field :description, type: String
        field :requirements, type: String
        field :copyright, type: String
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status], :allow_nil => true }
        field :experimental, type: Boolean
        field :date, type: FHIR::PartialDateTime
        validates_presence_of :date
        embeds_one :software, class_name:'FHIR::Conformance::ConformanceSoftwareComponent'
        embeds_one :implementation, class_name:'FHIR::Conformance::ConformanceImplementationComponent'
        field :fhirVersion, type: String
        validates_presence_of :fhirVersion
        field :acceptUnknown, type: Boolean
        validates_presence_of :acceptUnknown
        field :format, type: Array # Array of Strings
        validates_presence_of :format
        embeds_many :profile, class_name:'FHIR::Reference'
        embeds_many :rest, class_name:'FHIR::Conformance::ConformanceRestComponent'
        embeds_many :messaging, class_name:'FHIR::Conformance::ConformanceMessagingComponent'
        embeds_many :document, class_name:'FHIR::Conformance::ConformanceDocumentComponent'
        track_history
    end
end
