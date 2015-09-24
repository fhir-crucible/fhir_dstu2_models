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
    class TestScript 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::TestScript
        
        SEARCH_PARAMS = [
            'identifier',
            'testscript-test-capability',
            'testscript-setup-capability',
            'name',
            'description',
            'testscript-capability',
            'url'
        ]
        
        VALID_CODES = {
            useContext: [ 'AK', 'AL', 'AR', 'AS', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'FM', 'GA', 'GU', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MH', 'MI', 'MN', 'MO', 'MP', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'PR', 'PW', 'RI', 'SC', 'SD', 'TN', 'TX', 'UM', 'UT', 'VA', 'VI', 'VT', 'WA', 'WI', 'WV', 'WY', 'cardio', 'dent', 'dietary', 'midw', 'sysarch' ],
            status: [ 'draft', 'active', 'retired' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec contact
        class TestScriptContactComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :name, type: String
            embeds_many :telecom, class_name:'FHIR::ContactPoint'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec link
        class TestScriptMetadataLinkComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :url, type: String
            validates_presence_of :url
            field :description, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec capability
        class TestScriptMetadataCapabilityComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :required, type: Boolean
            field :fhirValidated, type: Boolean
            field :description, type: String
            field :destination, type: Integer
            field :link, type: Array # Array of Strings
            embeds_one :conformance, class_name:'FHIR::Reference'
            validates_presence_of :conformance
        end
        
        # This is an ugly hack to deal with embedded structures in the spec metadata
        class TestScriptMetadataComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_many :link, class_name:'FHIR::TestScript::TestScriptMetadataLinkComponent'
            embeds_many :capability, class_name:'FHIR::TestScript::TestScriptMetadataCapabilityComponent'
            validates_presence_of :capability
        end
        
        # This is an ugly hack to deal with embedded structures in the spec fixture
        class TestScriptFixtureComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :autocreate, type: Boolean
            field :autodelete, type: Boolean
            embeds_one :resource, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec variable
        class TestScriptVariableComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :name, type: String
            validates_presence_of :name
            field :headerField, type: String
            field :path, type: String
            field :sourceId, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec requestHeader
        class TestScriptSetupActionOperationRequestHeaderComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :field, type: String
            validates_presence_of :field
            field :value, type: String
            validates_presence_of :value
        end
        
        # This is an ugly hack to deal with embedded structures in the spec operation
        class TestScriptSetupActionOperationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                resource: [ 'Address', 'Age', 'Annotation', 'Attachment', 'BackboneElement', 'CodeableConcept', 'Coding', 'ContactPoint', 'Count', 'Distance', 'Duration', 'Element', 'ElementDefinition', 'Extension', 'HumanName', 'Identifier', 'Meta', 'Money', 'Narrative', 'Period', 'Quantity', 'Range', 'Ratio', 'Reference', 'SampledData', 'Signature', 'SimpleQuantity', 'Timing', 'base64Binary', 'boolean', 'code', 'date', 'dateTime', 'decimal', 'id', 'instant', 'integer', 'markdown', 'oid', 'positiveInt', 'string', 'time', 'unsignedInt', 'uri', 'uuid', 'xhtml', 'Account', 'AllergyIntolerance', 'Appointment', 'AppointmentResponse', 'AuditEvent', 'Basic', 'Binary', 'BodySite', 'Bundle', 'CarePlan', 'Claim', 'ClaimResponse', 'ClinicalImpression', 'Communication', 'CommunicationRequest', 'Composition', 'ConceptMap', 'Condition', 'Conformance', 'Contract', 'Coverage', 'DataElement', 'DetectedIssue', 'Device', 'DeviceComponent', 'DeviceMetric', 'DeviceUseRequest', 'DeviceUseStatement', 'DiagnosticOrder', 'DiagnosticReport', 'DocumentManifest', 'DocumentReference', 'DomainResource', 'EligibilityRequest', 'EligibilityResponse', 'Encounter', 'EnrollmentRequest', 'EnrollmentResponse', 'EpisodeOfCare', 'ExplanationOfBenefit', 'FamilyMemberHistory', 'Flag', 'Goal', 'Group', 'HealthcareService', 'ImagingObjectSelection', 'ImagingStudy', 'Immunization', 'ImmunizationRecommendation', 'ImplementationGuide', 'List', 'Location', 'Media', 'Medication', 'MedicationAdministration', 'MedicationDispense', 'MedicationOrder', 'MedicationStatement', 'MessageHeader', 'NamingSystem', 'NutritionOrder', 'Observation', 'OperationDefinition', 'OperationOutcome', 'Order', 'OrderResponse', 'Organization', 'Parameters', 'Patient', 'PaymentNotice', 'PaymentReconciliation', 'Person', 'Practitioner', 'Procedure', 'ProcedureRequest', 'ProcessRequest', 'ProcessResponse', 'Provenance', 'Questionnaire', 'QuestionnaireResponse', 'ReferralRequest', 'RelatedPerson', 'Resource', 'RiskAssessment', 'Schedule', 'SearchParameter', 'Slot', 'Specimen', 'StructureDefinition', 'Subscription', 'Substance', 'SupplyDelivery', 'SupplyRequest', 'TestScript', 'ValueSet', 'VisionPrescription' ],
                contentType: [ 'xml', 'json' ],
                fhirType: [ 'read', 'vread', 'update', 'delete', 'history', 'create', 'search', 'transaction', 'conformance', 'closure', 'document', 'everything', 'expand', 'find', 'lookup', 'meta', 'meta-add', 'meta-delete', 'populate', 'process-message', 'questionnaire', 'translate', 'validate', 'validate-code' ],
                accept: [ 'xml', 'json' ]
            }
            
            embeds_one :fhirType, class_name:'FHIR::Coding'
            field :resource, type: String
            validates :resource, :inclusion => { in: VALID_CODES[:resource], :allow_nil => true }
            field :label, type: String
            field :description, type: String
            field :accept, type: String
            validates :accept, :inclusion => { in: VALID_CODES[:accept], :allow_nil => true }
            field :contentType, type: String
            validates :contentType, :inclusion => { in: VALID_CODES[:contentType], :allow_nil => true }
            field :destination, type: Integer
            field :encodeRequestUrl, type: Boolean
            field :params, type: String
            embeds_many :requestHeader, class_name:'FHIR::TestScript::TestScriptSetupActionOperationRequestHeaderComponent'
            field :responseId, type: String
            field :sourceId, type: String
            field :targetId, type: String
            field :url, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec assert
        class TestScriptSetupActionAssertComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                resource: [ 'Address', 'Age', 'Annotation', 'Attachment', 'BackboneElement', 'CodeableConcept', 'Coding', 'ContactPoint', 'Count', 'Distance', 'Duration', 'Element', 'ElementDefinition', 'Extension', 'HumanName', 'Identifier', 'Meta', 'Money', 'Narrative', 'Period', 'Quantity', 'Range', 'Ratio', 'Reference', 'SampledData', 'Signature', 'SimpleQuantity', 'Timing', 'base64Binary', 'boolean', 'code', 'date', 'dateTime', 'decimal', 'id', 'instant', 'integer', 'markdown', 'oid', 'positiveInt', 'string', 'time', 'unsignedInt', 'uri', 'uuid', 'xhtml', 'Account', 'AllergyIntolerance', 'Appointment', 'AppointmentResponse', 'AuditEvent', 'Basic', 'Binary', 'BodySite', 'Bundle', 'CarePlan', 'Claim', 'ClaimResponse', 'ClinicalImpression', 'Communication', 'CommunicationRequest', 'Composition', 'ConceptMap', 'Condition', 'Conformance', 'Contract', 'Coverage', 'DataElement', 'DetectedIssue', 'Device', 'DeviceComponent', 'DeviceMetric', 'DeviceUseRequest', 'DeviceUseStatement', 'DiagnosticOrder', 'DiagnosticReport', 'DocumentManifest', 'DocumentReference', 'DomainResource', 'EligibilityRequest', 'EligibilityResponse', 'Encounter', 'EnrollmentRequest', 'EnrollmentResponse', 'EpisodeOfCare', 'ExplanationOfBenefit', 'FamilyMemberHistory', 'Flag', 'Goal', 'Group', 'HealthcareService', 'ImagingObjectSelection', 'ImagingStudy', 'Immunization', 'ImmunizationRecommendation', 'ImplementationGuide', 'List', 'Location', 'Media', 'Medication', 'MedicationAdministration', 'MedicationDispense', 'MedicationOrder', 'MedicationStatement', 'MessageHeader', 'NamingSystem', 'NutritionOrder', 'Observation', 'OperationDefinition', 'OperationOutcome', 'Order', 'OrderResponse', 'Organization', 'Parameters', 'Patient', 'PaymentNotice', 'PaymentReconciliation', 'Person', 'Practitioner', 'Procedure', 'ProcedureRequest', 'ProcessRequest', 'ProcessResponse', 'Provenance', 'Questionnaire', 'QuestionnaireResponse', 'ReferralRequest', 'RelatedPerson', 'Resource', 'RiskAssessment', 'Schedule', 'SearchParameter', 'Slot', 'Specimen', 'StructureDefinition', 'Subscription', 'Substance', 'SupplyDelivery', 'SupplyRequest', 'TestScript', 'ValueSet', 'VisionPrescription' ],
                response: [ 'okay', 'created', 'noContent', 'notModified', 'bad', 'forbidden', 'notFound', 'methodNotAllowed', 'conflict', 'gone', 'preconditionFailed', 'unprocessable' ],
                contentType: [ 'xml', 'json' ],
                operator: [ 'equals', 'notEquals', 'in', 'notIn', 'greaterThan', 'lessThan', 'empty', 'notEmpty', 'contains', 'notContains' ],
                direction: [ 'response', 'request' ]
            }
            
            field :label, type: String
            field :description, type: String
            field :direction, type: String
            validates :direction, :inclusion => { in: VALID_CODES[:direction], :allow_nil => true }
            field :compareToSourceId, type: String
            field :compareToSourcePath, type: String
            field :contentType, type: String
            validates :contentType, :inclusion => { in: VALID_CODES[:contentType], :allow_nil => true }
            field :headerField, type: String
            field :minimumId, type: String
            field :navigationLinks, type: Boolean
            field :operator, type: String
            validates :operator, :inclusion => { in: VALID_CODES[:operator], :allow_nil => true }
            field :path, type: String
            field :resource, type: String
            validates :resource, :inclusion => { in: VALID_CODES[:resource], :allow_nil => true }
            field :response, type: String
            validates :response, :inclusion => { in: VALID_CODES[:response], :allow_nil => true }
            field :responseCode, type: String
            field :sourceId, type: String
            field :validateProfileId, type: String
            field :value, type: String
            field :warningOnly, type: Boolean
        end
        
        # This is an ugly hack to deal with embedded structures in the spec action
        class TestScriptSetupActionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :operation, class_name:'FHIR::TestScript::TestScriptSetupActionOperationComponent'
            embeds_one :assert, class_name:'FHIR::TestScript::TestScriptSetupActionAssertComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec setup
        class TestScriptSetupComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :metadata, class_name:'FHIR::TestScript::TestScriptMetadataComponent'
            embeds_many :action, class_name:'FHIR::TestScript::TestScriptSetupActionComponent'
            validates_presence_of :action
        end
        
        # This is an ugly hack to deal with embedded structures in the spec action
        class TestScriptTestActionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :operation, class_name:'FHIR::TestScript::TestScriptSetupActionOperationComponent'
            embeds_one :assert, class_name:'FHIR::TestScript::TestScriptSetupActionAssertComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec test
        class TestScriptTestComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :name, type: String
            field :description, type: String
            embeds_one :metadata, class_name:'FHIR::TestScript::TestScriptMetadataComponent'
            embeds_many :action, class_name:'FHIR::TestScript::TestScriptTestActionComponent'
            validates_presence_of :action
        end
        
        # This is an ugly hack to deal with embedded structures in the spec action
        class TestScriptTeardownActionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :operation, class_name:'FHIR::TestScript::TestScriptSetupActionOperationComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec teardown
        class TestScriptTeardownComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_many :action, class_name:'FHIR::TestScript::TestScriptTeardownActionComponent'
            validates_presence_of :action
        end
        
        field :url, type: String
        validates_presence_of :url
        field :versionNum, type: String
        field :name, type: String
        validates_presence_of :name
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        embeds_one :identifier, class_name:'FHIR::Identifier'
        field :experimental, type: Boolean
        field :publisher, type: String
        embeds_many :contact, class_name:'FHIR::TestScript::TestScriptContactComponent'
        field :date, type: String
        validates :date, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        field :description, type: String
        embeds_many :useContext, class_name:'FHIR::CodeableConcept'
        field :requirements, type: String
        field :copyright, type: String
        embeds_one :metadata, class_name:'FHIR::TestScript::TestScriptMetadataComponent'
        field :multiserver, type: Boolean
        embeds_many :fixture, class_name:'FHIR::TestScript::TestScriptFixtureComponent'
        embeds_many :profile, class_name:'FHIR::Reference'
        embeds_many :variable, class_name:'FHIR::TestScript::TestScriptVariableComponent'
        embeds_one :setup, class_name:'FHIR::TestScript::TestScriptSetupComponent'
        embeds_many :test, class_name:'FHIR::TestScript::TestScriptTestComponent'
        embeds_one :teardown, class_name:'FHIR::TestScript::TestScriptTeardownComponent'
        track_history
    end
end
