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
    class AuditEvent 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::AuditEvent
        
        SEARCH_PARAMS = [
            'date',
            'address',
            'patientid',
            'source',
            'type',
            'altid',
            'participant',
            'reference',
            'site',
            'subtype',
            'identity',
            'patient',
            'object-type',
            'name',
            'action',
            'user',
            'desc',
            'policy'
            ]
        # This is an ugly hack to deal with embedded structures in the spec event
        class AuditEventEventComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                action: [ "C", "R", "U", "D", "E" ],
                outcome: [ "0", "4", "8", "12" ]
            }
            
            embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
            validates_presence_of :fhirType
            embeds_many :subtype, class_name:'FHIR::CodeableConcept'
            field :action, type: String
            validates :action, :inclusion => { in: VALID_CODES[:action], :allow_nil => true }
            field :dateTime, type: DateTime
            validates_presence_of :dateTime
            field :outcome, type: String
            validates :outcome, :inclusion => { in: VALID_CODES[:outcome], :allow_nil => true }
            field :outcomeDesc, type: String
            embeds_many :purposeOfEvent, class_name:'FHIR::Coding'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec network
        class AuditEventParticipantNetworkComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ "1", "2", "3", "4", "5" ]
            }
            
            field :identifier, type: String
            field :fhirType, type: String
            validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType], :allow_nil => true }
        end
        
        # This is an ugly hack to deal with embedded structures in the spec participant
        class AuditEventParticipantComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_many :role, class_name:'FHIR::CodeableConcept'
            embeds_one :reference, class_name:'FHIR::Reference'
            field :userId, type: String
            field :altId, type: String
            field :name, type: String
            field :requestor, type: Boolean
            validates_presence_of :requestor
            embeds_one :location, class_name:'FHIR::Reference'
            field :policy, type: Array # Array of Strings
            embeds_one :media, class_name:'FHIR::Coding'
            embeds_one :network, class_name:'FHIR::AuditEvent::AuditEventParticipantNetworkComponent'
            embeds_many :purposeOfUse, class_name:'FHIR::Coding'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec source
        class AuditEventSourceComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :site, type: String
            field :identifier, type: String
            validates_presence_of :identifier
            embeds_many :fhirType, class_name:'FHIR::Coding'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec detail
        class AuditEventObjectDetailComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :fhirType, type: String
            validates_presence_of :fhirType
            field :value, type: Moped::BSON::Binary
            validates_presence_of :value
        end
        
        # This is an ugly hack to deal with embedded structures in the spec object
        class AuditEventObjectComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                lifecycle: [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15" ],
                role: [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24" ],
                fhirType: [ "1", "2", "3", "4" ]
            }
            
            embeds_one :identifier, class_name:'FHIR::Identifier'
            embeds_one :reference, class_name:'FHIR::Reference'
            field :fhirType, type: String
            validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType], :allow_nil => true }
            field :role, type: String
            validates :role, :inclusion => { in: VALID_CODES[:role], :allow_nil => true }
            field :lifecycle, type: String
            validates :lifecycle, :inclusion => { in: VALID_CODES[:lifecycle], :allow_nil => true }
            embeds_one :sensitivity, class_name:'FHIR::CodeableConcept'
            field :name, type: String
            field :description, type: String
            field :query, type: Moped::BSON::Binary
            embeds_many :detail, class_name:'FHIR::AuditEvent::AuditEventObjectDetailComponent'
        end
        
        embeds_one :event, class_name:'FHIR::AuditEvent::AuditEventEventComponent'
        validates_presence_of :event
        embeds_many :participant, class_name:'FHIR::AuditEvent::AuditEventParticipantComponent'
        validates_presence_of :participant
        embeds_one :source, class_name:'FHIR::AuditEvent::AuditEventSourceComponent'
        validates_presence_of :source
        embeds_many :object, class_name:'FHIR::AuditEvent::AuditEventObjectComponent'
        track_history
    end
end
