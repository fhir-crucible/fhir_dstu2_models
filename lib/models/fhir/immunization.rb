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
    class Immunization 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Immunization
        
        SEARCH_PARAMS = [
            'date',
            'requester',
            'identifier',
            'reason',
            'performer',
            'reaction',
            'lot-number',
            'subject',
            'vaccine-type',
            'notgiven',
            'manufacturer',
            'dose-sequence',
            'patient',
            'reason-not-given',
            'location',
            'reaction-date'
            ]
        # This is an ugly hack to deal with embedded structures in the spec explanation
        class ImmunizationExplanationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_many :reason, class_name:'FHIR::CodeableConcept'
            embeds_many :reasonNotGiven, class_name:'FHIR::CodeableConcept'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec reaction
        class ImmunizationReactionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :date, type: FHIR::PartialDateTime
            embeds_one :detail, class_name:'FHIR::Reference'
            field :reported, type: Boolean
        end
        
        # This is an ugly hack to deal with embedded structures in the spec vaccinationProtocol
        class ImmunizationVaccinationProtocolComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :doseSequence, type: Integer
            validates_presence_of :doseSequence
            field :description, type: String
            embeds_one :authority, class_name:'FHIR::Reference'
            field :series, type: String
            field :seriesDoses, type: Integer
            embeds_one :doseTarget, class_name:'FHIR::CodeableConcept'
            validates_presence_of :doseTarget
            embeds_one :doseStatus, class_name:'FHIR::CodeableConcept'
            validates_presence_of :doseStatus
            embeds_one :doseStatusReason, class_name:'FHIR::CodeableConcept'
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        field :date, type: FHIR::PartialDateTime
        validates_presence_of :date
        embeds_one :vaccineType, class_name:'FHIR::CodeableConcept'
        validates_presence_of :vaccineType
        embeds_one :patient, class_name:'FHIR::Reference'
        validates_presence_of :patient
        field :wasNotGiven, type: Boolean
        validates_presence_of :wasNotGiven
        field :reported, type: Boolean
        validates_presence_of :reported
        embeds_one :performer, class_name:'FHIR::Reference'
        embeds_one :requester, class_name:'FHIR::Reference'
        embeds_one :encounter, class_name:'FHIR::Reference'
        embeds_one :manufacturer, class_name:'FHIR::Reference'
        embeds_one :location, class_name:'FHIR::Reference'
        field :lotNumber, type: String
        field :expirationDate, type: FHIR::PartialDateTime
        embeds_one :site, class_name:'FHIR::CodeableConcept'
        embeds_one :route, class_name:'FHIR::CodeableConcept'
        embeds_one :doseQuantity, class_name:'FHIR::Quantity'
        embeds_one :explanation, class_name:'FHIR::Immunization::ImmunizationExplanationComponent'
        embeds_many :reaction, class_name:'FHIR::Immunization::ImmunizationReactionComponent'
        embeds_many :vaccinationProtocol, class_name:'FHIR::Immunization::ImmunizationVaccinationProtocolComponent'
        track_history
    end
end
