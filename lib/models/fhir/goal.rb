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
    class Goal 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Goal
        
        SEARCH_PARAMS = [
            'patient'
            ]
        
        VALID_CODES = {
            status: [ "proposed", "planned", "in-progress", "achieved", "sustaining", "cancelled", "accepted", "rejected" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec outcome
        class GoalOutcomeComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :resultCodeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :resultReference, class_name:'FHIR::Reference'
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :patient, class_name:'FHIR::Reference'
        field :targetDate, type: FHIR::PartialDateTime
        field :description, type: String
        validates_presence_of :description
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        field :statusDate, type: FHIR::PartialDateTime
        embeds_one :author, class_name:'FHIR::Reference'
        embeds_one :priority, class_name:'FHIR::CodeableConcept'
        embeds_many :concern, class_name:'FHIR::Reference'
        field :notes, type: String
        embeds_many :outcome, class_name:'FHIR::Goal::GoalOutcomeComponent'
        track_history
    end
end
