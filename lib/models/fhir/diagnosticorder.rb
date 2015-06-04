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
    class DiagnosticOrder 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::DiagnosticOrder
        
        SEARCH_PARAMS = [
            'item-past-status',
            'identifier',
            'bodysite',
            'code',
            'event-date',
            'event-status-date',
            'subject',
            'encounter',
            'actor',
            'item-date',
            'item-status-date',
            'event-status',
            'item-status',
            'patient',
            'orderer',
            'specimen',
            'status'
        ]
        
        VALID_CODES = {
            priority: [ "routine", "urgent", "stat", "asap" ],
            status: [ "proposed", "draft", "planned", "requested", "received", "accepted", "in-progress", "review", "completed", "cancelled", "suspended", "rejected", "failed" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec event
        class DiagnosticOrderEventComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                status: [ "proposed", "draft", "planned", "requested", "received", "accepted", "in-progress", "review", "completed", "cancelled", "suspended", "rejected", "failed" ]
            }
            
            field :status, type: String
            validates :status, :inclusion => { in: VALID_CODES[:status] }
            validates_presence_of :status
            embeds_one :description, class_name:'FHIR::CodeableConcept'
            field :dateTime, type: String
            validates :dateTime, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
            validates_presence_of :dateTime
            embeds_one :actor, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec item
        class DiagnosticOrderItemComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                status: [ "proposed", "draft", "planned", "requested", "received", "accepted", "in-progress", "review", "completed", "cancelled", "suspended", "rejected", "failed" ]
            }
            
            MULTIPLE_TYPES = {
                bodySite: [ "bodySiteCodeableConcept", "bodySiteReference" ]
            }
            
            embeds_one :code, class_name:'FHIR::CodeableConcept'
            validates_presence_of :code
            embeds_many :specimen, class_name:'FHIR::Reference'
            embeds_one :bodySiteCodeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :bodySiteReference, class_name:'FHIR::Reference'
            field :status, type: String
            validates :status, :inclusion => { in: VALID_CODES[:status], :allow_nil => true }
            embeds_many :event, class_name:'FHIR::DiagnosticOrder::DiagnosticOrderEventComponent'
        end
        
        embeds_one :subject, class_name:'FHIR::Reference'
        validates_presence_of :subject
        embeds_one :orderer, class_name:'FHIR::Reference'
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :encounter, class_name:'FHIR::Reference'
        field :clinicalNotes, type: String
        embeds_many :supportingInformation, class_name:'FHIR::Reference'
        embeds_many :specimen, class_name:'FHIR::Reference'
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status], :allow_nil => true }
        field :priority, type: String
        validates :priority, :inclusion => { in: VALID_CODES[:priority], :allow_nil => true }
        embeds_many :event, class_name:'FHIR::DiagnosticOrder::DiagnosticOrderEventComponent'
        embeds_many :item, class_name:'FHIR::DiagnosticOrder::DiagnosticOrderItemComponent'
        track_history
    end
end
