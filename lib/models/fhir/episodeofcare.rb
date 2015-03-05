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
    class EpisodeOfCare 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::EpisodeOfCare
        
        SEARCH_PARAMS = [
            'date',
            'identifier',
            'condition',
            'referral',
            'patient',
            'organization',
            'type',
            'care-manager',
            'status'
            ]
        
        VALID_CODES = {
            currentStatus: [ "planned", "active", "onhold", "finished", "withdrawn", "other" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec statusHistory
        class EpisodeOfCareStatusHistoryComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                status: [ "planned", "active", "onhold", "finished", "withdrawn", "other" ]
            }
            
            field :status, type: String
            validates :status, :inclusion => { in: VALID_CODES[:status] }
            validates_presence_of :status
            embeds_one :period, class_name:'FHIR::Period'
            validates_presence_of :period
        end
        
        # This is an ugly hack to deal with embedded structures in the spec careTeam
        class EpisodeOfCareCareTeamComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :member, class_name:'FHIR::Reference'
            embeds_many :role, class_name:'FHIR::CodeableConcept'
            embeds_one :period, class_name:'FHIR::Period'
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        field :currentStatus, type: String
        validates :currentStatus, :inclusion => { in: VALID_CODES[:currentStatus] }
        validates_presence_of :currentStatus
        embeds_many :statusHistory, class_name:'FHIR::EpisodeOfCare::EpisodeOfCareStatusHistoryComponent'
        embeds_many :fhirType, class_name:'FHIR::CodeableConcept'
        embeds_one :patient, class_name:'FHIR::Reference'
        validates_presence_of :patient
        embeds_one :managingOrganization, class_name:'FHIR::Reference'
        embeds_one :period, class_name:'FHIR::Period'
        embeds_many :condition, class_name:'FHIR::Reference'
        embeds_one :referralRequest, class_name:'FHIR::Reference'
        embeds_one :careManager, class_name:'FHIR::Reference'
        embeds_many :careTeam, class_name:'FHIR::EpisodeOfCare::EpisodeOfCareCareTeamComponent'
        track_history
    end
end
