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
    class Bundle 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Bundle
        
        SEARCH_PARAMS = [
            'message',
            'composition',
            'type'
            ]
        
        VALID_CODES = {
            fhirType: [ "document", "message", "transaction", "transaction-response", "history", "searchset", "collection" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec link
        class BundleLinkComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :relation, type: String
            validates_presence_of :relation
            field :url, type: String
            validates_presence_of :url
        end
        
        # This is an ugly hack to deal with embedded structures in the spec fhirDeleted
        class BundleEntryDeletedComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ "Alert", "AllergyIntolerance", "Appointment", "AppointmentResponse", "Basic", "Binary", "Bundle", "CarePlan", "CarePlan2", "ClaimResponse", "ClinicalAssessment", "Communication", "CommunicationRequest", "Composition", "ConceptMap", "Condition", "Conformance", "Contract", "Contraindication", "Coverage", "DataElement", "Device", "DeviceComponent", "DeviceMetric", "DeviceUseRequest", "DeviceUseStatement", "DiagnosticOrder", "DiagnosticReport", "DocumentManifest", "DocumentReference", "EligibilityRequest", "EligibilityResponse", "Encounter", "EnrollmentRequest", "EnrollmentResponse", "EpisodeOfCare", "ExplanationOfBenefit", "ExtensionDefinition", "FamilyHistory", "Goal", "Group", "HealthcareService", "ImagingObjectSelection", "ImagingStudy", "Immunization", "ImmunizationRecommendation", "InstitutionalClaim", "List", "Location", "Media", "Medication", "MedicationAdministration", "MedicationDispense", "MedicationPrescription", "MedicationStatement", "MessageHeader", "NamingSystem", "NutritionOrder", "Observation", "OperationDefinition", "OperationOutcome", "OralHealthClaim", "Order", "OrderResponse", "Organization", "Other", "Patient", "PaymentNotice", "PaymentReconciliation", "PendedRequest", "Person", "PharmacyClaim", "Practitioner", "Procedure", "ProcedureRequest", "ProfessionalClaim", "Profile", "Provenance", "Questionnaire", "QuestionnaireAnswers", "Readjudicate", "ReferralRequest", "RelatedPerson", "Reversal", "RiskAssessment", "Schedule", "SearchParameter", "SecurityEvent", "Slot", "Specimen", "StatusRequest", "StatusResponse", "Subscription", "Substance", "Supply", "SupportingDocumentation", "ValueSet", "VisionClaim", "VisionPrescription" ]
            }
            
            field :fhirType, type: String
            validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType] }
            validates_presence_of :fhirType
            field :resourceId, type: String
            validates_presence_of :resourceId
            field :versionId, type: String
            validates_presence_of :versionId
            field :instant, type: DateTime
            validates_presence_of :instant
        end
        
        # This is an ugly hack to deal with embedded structures in the spec entry
        class BundleEntryComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                status: [ "create", "update", "match", "include" ]
            }
            
            field :base, type: String
            field :status, type: String
            validates :status, :inclusion => { in: VALID_CODES[:status], :allow_nil => true }
            field :search, type: String
            field :score, type: Float
            embeds_one :fhirDeleted, class_name:'FHIR::Bundle::BundleEntryDeletedComponent'
            field :resourceType, type: String
            attr_accessor :resource
            # field :resource, type: FHIR::AnyType
        end
        
        field :fhirType, type: String
        validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType] }
        validates_presence_of :fhirType
        field :base, type: String
        field :total, type: Integer
        embeds_many :link, class_name:'FHIR::Bundle::BundleLinkComponent'
        embeds_many :entry, class_name:'FHIR::Bundle::BundleEntryComponent'
        field :signature, type: Moped::BSON::Binary
        track_history
    end
end
