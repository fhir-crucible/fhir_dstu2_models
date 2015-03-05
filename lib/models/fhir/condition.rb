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
    class Condition 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Condition
        
        SEARCH_PARAMS = [
            'severity',
            'code',
            'evidence',
            'date-asserted',
            'subject',
            'dueto-item',
            'encounter',
            'onset',
            'asserter',
            'stage',
            'following-item',
            'patient',
            'dueto-code',
            'location',
            'category',
            'following-code',
            'status'
            ]
        
        VALID_CODES = {
            status: [ "provisional", "working", "confirmed", "refuted" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec stage
        class ConditionStageComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :summary, class_name:'FHIR::CodeableConcept'
            embeds_many :assessment, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec evidence
        class ConditionEvidenceComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :code, class_name:'FHIR::CodeableConcept'
            embeds_many :detail, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec location
        class ConditionLocationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :code, class_name:'FHIR::CodeableConcept'
            field :detail, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec dueTo
        class ConditionDueToComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :codeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :target, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec occurredFollowing
        class ConditionOccurredFollowingComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :codeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :target, class_name:'FHIR::Reference'
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :subject, class_name:'FHIR::Reference'
        validates_presence_of :subject
        embeds_one :encounter, class_name:'FHIR::Reference'
        embeds_one :asserter, class_name:'FHIR::Reference'
        field :dateAsserted, type: FHIR::PartialDateTime
        embeds_one :code, class_name:'FHIR::CodeableConcept'
        validates_presence_of :code
        embeds_one :category, class_name:'FHIR::CodeableConcept'
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        embeds_one :certainty, class_name:'FHIR::CodeableConcept'
        embeds_one :severity, class_name:'FHIR::CodeableConcept'
        field :onsetDateTime, type: FHIR::PartialDateTime
        embeds_one :onsetAge, class_name:'FHIR::Quantity'
        field :abatementDate, type: FHIR::PartialDateTime
        embeds_one :abatementAge, class_name:'FHIR::Quantity'
        field :abatementBoolean, type: Boolean
        embeds_one :stage, class_name:'FHIR::Condition::ConditionStageComponent'
        embeds_many :evidence, class_name:'FHIR::Condition::ConditionEvidenceComponent'
        embeds_many :location, class_name:'FHIR::Condition::ConditionLocationComponent'
        embeds_many :dueTo, class_name:'FHIR::Condition::ConditionDueToComponent'
        embeds_many :occurredFollowing, class_name:'FHIR::Condition::ConditionOccurredFollowingComponent'
        field :notes, type: String
        track_history
    end
end
