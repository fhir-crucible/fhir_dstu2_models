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
    class ImplementationGuide 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::ImplementationGuide
        
        SEARCH_PARAMS = [
            'date',
            'dependency',
            'name',
            'context',
            'publisher',
            'description',
            'experimental',
            'version',
            'url',
            'status'
        ]
        
        VALID_CODES = {
            useContext: [ 'AK', 'AL', 'AR', 'AS', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'FM', 'GA', 'GU', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MH', 'MI', 'MN', 'MO', 'MP', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'PR', 'PW', 'RI', 'SC', 'SD', 'TN', 'TX', 'UM', 'UT', 'VA', 'VI', 'VT', 'WA', 'WI', 'WV', 'WY', 'cardio', 'dent', 'dietary', 'midw', 'sysarch' ],
            status: [ 'draft', 'active', 'retired' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec contact
        class ImplementationGuideContactComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :name, type: String
            embeds_many :telecom, class_name:'FHIR::ContactPoint'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec dependency
        class ImplementationGuideDependencyComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ 'reference', 'inclusion' ]
            }
            
            field :fhirType, type: String
            validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType] }
            validates_presence_of :fhirType
            field :uri, type: String
            validates_presence_of :uri
        end
        
        # This is an ugly hack to deal with embedded structures in the spec resource
        class ImplementationGuidePackageResourceComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                purpose: [ 'example', 'terminology', 'profile', 'extension', 'dictionary', 'logical' ]
            }
            
            MULTIPLE_TYPES = {
                source: [ 'sourceUri', 'sourceReference' ]
            }
            
            field :purpose, type: String
            validates :purpose, :inclusion => { in: VALID_CODES[:purpose] }
            validates_presence_of :purpose
            field :name, type: String
            field :description, type: String
            field :acronym, type: String
            field :sourceUri, type: String
            validates_presence_of :sourceUri
            embeds_one :sourceReference, class_name:'FHIR::Reference'
            validates_presence_of :sourceReference
            embeds_one :exampleFor, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec package
        class ImplementationGuidePackageComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :name, type: String
            validates_presence_of :name
            field :description, type: String
            embeds_many :resource, class_name:'FHIR::ImplementationGuide::ImplementationGuidePackageResourceComponent'
            validates_presence_of :resource
        end
        
        # This is an ugly hack to deal with embedded structures in the spec global
        class ImplementationGuideGlobalComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ 'Account', 'AllergyIntolerance', 'Appointment', 'AppointmentResponse', 'AuditEvent', 'Basic', 'Binary', 'BodySite', 'Bundle', 'CarePlan', 'Claim', 'ClaimResponse', 'ClinicalImpression', 'Communication', 'CommunicationRequest', 'Composition', 'ConceptMap', 'Condition', 'Conformance', 'Contract', 'Coverage', 'DataElement', 'DetectedIssue', 'Device', 'DeviceComponent', 'DeviceMetric', 'DeviceUseRequest', 'DeviceUseStatement', 'DiagnosticOrder', 'DiagnosticReport', 'DocumentManifest', 'DocumentReference', 'DomainResource', 'EligibilityRequest', 'EligibilityResponse', 'Encounter', 'EnrollmentRequest', 'EnrollmentResponse', 'EpisodeOfCare', 'ExplanationOfBenefit', 'FamilyMemberHistory', 'Flag', 'Goal', 'Group', 'HealthcareService', 'ImagingObjectSelection', 'ImagingStudy', 'Immunization', 'ImmunizationRecommendation', 'ImplementationGuide', 'List', 'Location', 'Media', 'Medication', 'MedicationAdministration', 'MedicationDispense', 'MedicationOrder', 'MedicationStatement', 'MessageHeader', 'NamingSystem', 'NutritionOrder', 'Observation', 'OperationDefinition', 'OperationOutcome', 'Order', 'OrderResponse', 'Organization', 'Parameters', 'Patient', 'PaymentNotice', 'PaymentReconciliation', 'Person', 'Practitioner', 'Procedure', 'ProcedureRequest', 'ProcessRequest', 'ProcessResponse', 'Provenance', 'Questionnaire', 'QuestionnaireResponse', 'ReferralRequest', 'RelatedPerson', 'Resource', 'RiskAssessment', 'Schedule', 'SearchParameter', 'Slot', 'Specimen', 'StructureDefinition', 'Subscription', 'Substance', 'SupplyDelivery', 'SupplyRequest', 'TestScript', 'ValueSet', 'VisionPrescription' ]
            }
            
            field :fhirType, type: String
            validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType] }
            validates_presence_of :fhirType
            embeds_one :profile, class_name:'FHIR::Reference'
            validates_presence_of :profile
        end
        
        # This is an ugly hack to deal with embedded structures in the spec page
        class ImplementationGuidePageComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                kind: [ 'page', 'example', 'list', 'include', 'directory', 'dictionary', 'toc', 'resource' ],
                fhirType: [ 'Account', 'AllergyIntolerance', 'Appointment', 'AppointmentResponse', 'AuditEvent', 'Basic', 'Binary', 'BodySite', 'Bundle', 'CarePlan', 'Claim', 'ClaimResponse', 'ClinicalImpression', 'Communication', 'CommunicationRequest', 'Composition', 'ConceptMap', 'Condition', 'Conformance', 'Contract', 'Coverage', 'DataElement', 'DetectedIssue', 'Device', 'DeviceComponent', 'DeviceMetric', 'DeviceUseRequest', 'DeviceUseStatement', 'DiagnosticOrder', 'DiagnosticReport', 'DocumentManifest', 'DocumentReference', 'DomainResource', 'EligibilityRequest', 'EligibilityResponse', 'Encounter', 'EnrollmentRequest', 'EnrollmentResponse', 'EpisodeOfCare', 'ExplanationOfBenefit', 'FamilyMemberHistory', 'Flag', 'Goal', 'Group', 'HealthcareService', 'ImagingObjectSelection', 'ImagingStudy', 'Immunization', 'ImmunizationRecommendation', 'ImplementationGuide', 'List', 'Location', 'Media', 'Medication', 'MedicationAdministration', 'MedicationDispense', 'MedicationOrder', 'MedicationStatement', 'MessageHeader', 'NamingSystem', 'NutritionOrder', 'Observation', 'OperationDefinition', 'OperationOutcome', 'Order', 'OrderResponse', 'Organization', 'Parameters', 'Patient', 'PaymentNotice', 'PaymentReconciliation', 'Person', 'Practitioner', 'Procedure', 'ProcedureRequest', 'ProcessRequest', 'ProcessResponse', 'Provenance', 'Questionnaire', 'QuestionnaireResponse', 'ReferralRequest', 'RelatedPerson', 'Resource', 'RiskAssessment', 'Schedule', 'SearchParameter', 'Slot', 'Specimen', 'StructureDefinition', 'Subscription', 'Substance', 'SupplyDelivery', 'SupplyRequest', 'TestScript', 'ValueSet', 'VisionPrescription' ]
            }
            
            SPECIAL_CODES = {
                format: 'MimeType'
            }
            
            field :source, type: String
            validates_presence_of :source
            field :name, type: String
            validates_presence_of :name
            field :kind, type: String
            validates :kind, :inclusion => { in: VALID_CODES[:kind] }
            validates_presence_of :kind
            field :fhirType, type: Array # Array of Strings
            validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType], :allow_nil => true }
            field :package, type: Array # Array of Strings
            field :format, type: String
            embeds_many :page, class_name:'FHIR::ImplementationGuide::ImplementationGuidePageComponent'
        end
        
        field :url, type: String
        validates_presence_of :url
        field :versionNum, type: String
        field :name, type: String
        validates_presence_of :name
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        field :experimental, type: Boolean
        field :publisher, type: String
        embeds_many :contact, class_name:'FHIR::ImplementationGuide::ImplementationGuideContactComponent'
        field :date, type: String
        validates :date, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        field :description, type: String
        embeds_many :useContext, class_name:'FHIR::CodeableConcept'
        field :copyright, type: String
        field :fhirVersion, type: String
        embeds_many :dependency, class_name:'FHIR::ImplementationGuide::ImplementationGuideDependencyComponent'
        embeds_many :package, class_name:'FHIR::ImplementationGuide::ImplementationGuidePackageComponent'
        validates_presence_of :package
        embeds_many :global, class_name:'FHIR::ImplementationGuide::ImplementationGuideGlobalComponent'
        field :binary, type: Array # Array of Strings
        embeds_one :page, class_name:'FHIR::ImplementationGuide::ImplementationGuidePageComponent'
        validates_presence_of :page
        track_history
    end
end
