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
    class CarePlan 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::CarePlan
        
        SEARCH_PARAMS = [
            'date',
            'activitycode',
            'activitydate',
            'activityreference',
            'performer',
            'goal',
            'subject',
            'relatedcode',
            'participant',
            'relatedplan',
            'condition',
            'related',
            'patient'
        ]
        
        VALID_CODES = {
            status: [ 'proposed', 'draft', 'active', 'completed', 'cancelled' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec relatedPlan
        class CarePlanRelatedPlanComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                code: [ 'includes', 'replaces', 'fulfills' ]
            }
            
            field :code, type: String
            embeds_one :plan, class_name:'FHIR::Reference'
            validates_presence_of :plan
        end
        
        # This is an ugly hack to deal with embedded structures in the spec participant
        class CarePlanParticipantComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :role, class_name:'FHIR::CodeableConcept'
            embeds_one :member, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec detail
        class CarePlanActivityDetailComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                category: [ 'diet', 'drug', 'encounter', 'observation', 'procedure', 'supply', 'other' ],
                status: [ 'not-started', 'scheduled', 'in-progress', 'on-hold', 'completed', 'cancelled' ]
            }
            
            MULTIPLE_TYPES = {
                product: [ 'productCodeableConcept', 'productReference' ],
                scheduled: [ 'scheduledTiming', 'scheduledPeriod', 'scheduledString' ]
            }
            
            embeds_one :category, class_name:'FHIR::CodeableConcept'
            embeds_one :code, class_name:'FHIR::CodeableConcept'
            embeds_many :reasonCode, class_name:'FHIR::CodeableConcept'
            embeds_many :reasonReference, class_name:'FHIR::Reference'
            embeds_many :goal, class_name:'FHIR::Reference'
            field :status, type: String
            embeds_one :statusReason, class_name:'FHIR::CodeableConcept'
            field :prohibited, type: Boolean
            validates_presence_of :prohibited
            embeds_one :scheduledTiming, class_name:'FHIR::Timing'
            embeds_one :scheduledPeriod, class_name:'FHIR::Period'
            field :scheduledString, type: String
            embeds_one :location, class_name:'FHIR::Reference'
            embeds_many :performer, class_name:'FHIR::Reference'
            embeds_one :productCodeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :productReference, class_name:'FHIR::Reference'
            embeds_one :dailyAmount, class_name:'FHIR::Quantity'
            embeds_one :quantity, class_name:'FHIR::Quantity'
            field :description, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec activity
        class CarePlanActivityComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_many :actionResulting, class_name:'FHIR::Reference'
            embeds_many :progress, class_name:'FHIR::Annotation'
            embeds_one :reference, class_name:'FHIR::Reference'
            embeds_one :detail, class_name:'FHIR::CarePlan::CarePlanActivityDetailComponent'
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :subject, class_name:'FHIR::Reference'
        field :status, type: String
        validates_presence_of :status
        embeds_one :context, class_name:'FHIR::Reference'
        embeds_one :period, class_name:'FHIR::Period'
        embeds_many :author, class_name:'FHIR::Reference'
        field :modified, type: String
        validates :modified, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        embeds_many :category, class_name:'FHIR::CodeableConcept'
        field :description, type: String
        embeds_many :addresses, class_name:'FHIR::Reference'
        embeds_many :support, class_name:'FHIR::Reference'
        embeds_many :relatedPlan, class_name:'FHIR::CarePlan::CarePlanRelatedPlanComponent'
        embeds_many :participant, class_name:'FHIR::CarePlan::CarePlanParticipantComponent'
        embeds_many :goal, class_name:'FHIR::Reference'
        embeds_many :activity, class_name:'FHIR::CarePlan::CarePlanActivityComponent'
        embeds_one :note, class_name:'FHIR::Annotation'
        track_history
    end
end
