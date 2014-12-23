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
    class AllergyIntolerance 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::AllergyIntolerance
        
        SEARCH_PARAMS = [
            'status',
            'subject',
            'onset',
            'last-date',
            'severity',
            'date',
            'type',
            'substance',
            'criticality',
            'category',
            'duration',
            'patient',
            'recorder',
            'route',
            'identifier',
            'manifestation'
            ]
        
        VALID_CODES = {
            criticality: [ "low", "high", "unassessible" ],
            category: [ "food", "medication", "environment" ],
            status: [ "unconfirmed", "confirmed", "resolved", "refuted" ],
            fhirType: [ "immune", "non-immune" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec event
        class AllergyIntoleranceEventComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                certainty: [ "unlikely", "likely", "confirmed" ],
                severity: [ "mild", "moderate", "severe" ]
            }
            
            embeds_one :substance, class_name:'FHIR::CodeableConcept'
            field :certainty, type: String
            validates :certainty, :inclusion => { in: VALID_CODES[:certainty], :allow_nil => true }
            embeds_many :manifestation, class_name:'FHIR::CodeableConcept'
            validates_presence_of :manifestation
            field :description, type: String
            field :onset, type: FHIR::PartialDateTime
            embeds_one :duration, class_name:'FHIR::Quantity'
            field :severity, type: String
            validates :severity, :inclusion => { in: VALID_CODES[:severity], :allow_nil => true }
            embeds_one :exposureRoute, class_name:'FHIR::CodeableConcept'
            field :comment, type: String
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        field :recordedDate, type: FHIR::PartialDateTime
        embeds_one :recorder, class_name:'FHIR::Reference'
        embeds_one :subject, class_name:'FHIR::Reference'
        validates_presence_of :subject
        embeds_one :substance, class_name:'FHIR::CodeableConcept'
        validates_presence_of :substance
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status], :allow_nil => true }
        field :criticality, type: String
        validates :criticality, :inclusion => { in: VALID_CODES[:criticality], :allow_nil => true }
        field :fhirType, type: String
        validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType], :allow_nil => true }
        field :category, type: String
        validates :category, :inclusion => { in: VALID_CODES[:category], :allow_nil => true }
        field :lastOccurence, type: FHIR::PartialDateTime
        field :comment, type: String
        embeds_many :event, class_name:'FHIR::AllergyIntolerance::AllergyIntoleranceEventComponent'
        track_history
    end
end
