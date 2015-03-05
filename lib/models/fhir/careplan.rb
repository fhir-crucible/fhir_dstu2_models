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
            'activitydetail',
            'condition',
            'patient',
            'participant'
            ]
        
        VALID_CODES = {
            status: [ "planned", "active", "completed" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec participant
        class CarePlanParticipantComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :role, class_name:'FHIR::CodeableConcept'
            embeds_one :member, class_name:'FHIR::Reference'
            validates_presence_of :member
        end
        
        # This is an ugly hack to deal with embedded structures in the spec goal
        class CarePlanGoalComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                status: [ "in progress", "achieved", "sustaining", "cancelled" ]
            }
            
            field :description, type: String
            validates_presence_of :description
            field :status, type: String
            validates :status, :inclusion => { in: VALID_CODES[:status], :allow_nil => true }
            field :notes, type: String
            embeds_many :concern, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec simple
        class CarePlanActivitySimpleComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                category: [ "diet", "drug", "encounter", "observation", "procedure", "supply", "other" ]
            }
            
            field :category, type: String
            validates :category, :inclusion => { in: VALID_CODES[:category] }
            validates_presence_of :category
            embeds_one :code, class_name:'FHIR::CodeableConcept'
            embeds_one :scheduledTiming, class_name:'FHIR::Timing'
            embeds_one :scheduledPeriod, class_name:'FHIR::Period'
            field :scheduledString, type: String
            embeds_one :location, class_name:'FHIR::Reference'
            embeds_many :performer, class_name:'FHIR::Reference'
            embeds_one :product, class_name:'FHIR::Reference'
            embeds_one :dailyAmount, class_name:'FHIR::Quantity'
            embeds_one :quantity, class_name:'FHIR::Quantity'
            field :details, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec activity
        class CarePlanActivityComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                status: [ "not started", "scheduled", "in progress", "on hold", "completed", "cancelled" ]
            }
            
            field :goal, type: Array # Array of Strings
            field :status, type: String
            validates :status, :inclusion => { in: VALID_CODES[:status], :allow_nil => true }
            field :prohibited, type: Boolean
            validates_presence_of :prohibited
            embeds_many :actionResulting, class_name:'FHIR::Reference'
            field :notes, type: String
            embeds_one :detail, class_name:'FHIR::Reference'
            embeds_one :simple, class_name:'FHIR::CarePlan::CarePlanActivitySimpleComponent'
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :patient, class_name:'FHIR::Reference'
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        embeds_one :period, class_name:'FHIR::Period'
        field :modified, type: FHIR::PartialDateTime
        embeds_many :concern, class_name:'FHIR::Reference'
        embeds_many :participant, class_name:'FHIR::CarePlan::CarePlanParticipantComponent'
        embeds_many :goal, class_name:'FHIR::CarePlan::CarePlanGoalComponent'
        embeds_many :activity, class_name:'FHIR::CarePlan::CarePlanActivityComponent'
        field :notes, type: String
        track_history
    end
end
