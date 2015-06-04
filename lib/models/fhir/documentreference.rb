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
    class DocumentReference 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::DocumentReference
        
        SEARCH_PARAMS = [
            'subject',
            'confidentiality',
            'description',
            'language',
            'type',
            'relation',
            'setting',
            'relatedid',
            'patient',
            'relationship',
            'event',
            'class',
            'authenticator',
            'identifier',
            'period',
            'custodian',
            'indexed',
            'author',
            'created',
            'format',
            'relatedref',
            'location',
            'relatesto',
            'facility',
            'status'
        ]
        
        VALID_CODES = {
            status: [ "current", "superceded", "entered-in-error" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec relatesTo
        class DocumentReferenceRelatesToComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                code: [ "replaces", "transforms", "signs", "appends" ]
            }
            
            field :code, type: String
            validates :code, :inclusion => { in: VALID_CODES[:code] }
            validates_presence_of :code
            embeds_one :target, class_name:'FHIR::Reference'
            validates_presence_of :target
        end
        
        # This is an ugly hack to deal with embedded structures in the spec related
        class DocumentReferenceContextRelatedComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :identifier, class_name:'FHIR::Identifier'
            embeds_one :ref, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec context
        class DocumentReferenceContextComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_many :event, class_name:'FHIR::CodeableConcept'
            embeds_one :period, class_name:'FHIR::Period'
            embeds_one :facilityType, class_name:'FHIR::CodeableConcept'
            embeds_one :practiceSetting, class_name:'FHIR::CodeableConcept'
            embeds_one :sourcePatientInfo, class_name:'FHIR::Reference'
            embeds_many :related, class_name:'FHIR::DocumentReference::DocumentReferenceContextRelatedComponent'
        end
        
        embeds_one :masterIdentifier, class_name:'FHIR::Identifier'
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :subject, class_name:'FHIR::Reference'
        embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
        validates_presence_of :fhirType
        embeds_one :fhirClass, class_name:'FHIR::CodeableConcept'
        field :format, type: Array # Array of Strings
        embeds_many :author, class_name:'FHIR::Reference'
        validates_presence_of :author
        embeds_one :custodian, class_name:'FHIR::Reference'
        embeds_one :authenticator, class_name:'FHIR::Reference'
        field :created, type: String
        validates :created, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        field :indexed, type: String
        validates :indexed, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))))\Z/ }
        validates_presence_of :indexed
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        embeds_one :docStatus, class_name:'FHIR::CodeableConcept'
        embeds_many :relatesTo, class_name:'FHIR::DocumentReference::DocumentReferenceRelatesToComponent'
        field :description, type: String
        embeds_many :confidentiality, class_name:'FHIR::CodeableConcept'
        embeds_many :content, class_name:'FHIR::Attachment'
        validates_presence_of :content
        embeds_one :context, class_name:'FHIR::DocumentReference::DocumentReferenceContextComponent'
        track_history
    end
end
