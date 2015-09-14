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
                subtype: [ '110120', '110121', '110122', '110123', '110124', '110125', '110126', '110127', '110128', '110129', '110130', '110131', '110132', '110133', '110134', '110135', '110136', '110137', '110138', '110139', '110140', '110141', '110142' ],
                action: [ 'C', 'R', 'U', 'D', 'E' ],
                fhirType: [ 'rest', '110100', '110101', '110102', '110103', '110104', '110105', '110106', '110107', '110108', '110109', '110110', '110111', '110112', '110113', '110114' ],
                outcome: [ '0', '4', '8', '12' ]
            }
            
            embeds_one :fhirType, class_name:'FHIR::Coding'
            validates_presence_of :fhirType
            embeds_many :subtype, class_name:'FHIR::Coding'
            field :action, type: String
            field :dateTime, type: String
            validates :dateTime, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))))\Z/ }
            validates_presence_of :dateTime
            field :outcome, type: String
            field :outcomeDesc, type: String
            embeds_many :purposeOfEvent, class_name:'FHIR::Coding'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec network
        class AuditEventParticipantNetworkComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ '1', '2', '3', '4', '5' ]
            }
            
            field :address, type: String
            field :fhirType, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec participant
        class AuditEventParticipantComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                role: [ '110150', '110151', '110152', '110153', '110154', '110155' ],
                media: [ '110030', '110031', '110032', '110033', '110034', '110035', '110036', '110037', '110010', '110038' ]
            }
            
            embeds_many :role, class_name:'FHIR::CodeableConcept'
            embeds_one :reference, class_name:'FHIR::Reference'
            embeds_one :userId, class_name:'FHIR::Identifier'
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
            
            VALID_CODES = {
                fhirType: [ '1', '2', '3', '4', '5', '6', '7', '8', '9' ]
            }
            
            field :site, type: String
            embeds_one :identifier, class_name:'FHIR::Identifier'
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
            field :value, type: String
            validates_presence_of :value
        end
        
        # This is an ugly hack to deal with embedded structures in the spec object
        class AuditEventObjectComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                lifecycle: [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15' ],
                role: [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24' ],
                fhirType: [ '1', '2', '3', '4' ]
            }
            
            embeds_one :identifier, class_name:'FHIR::Identifier'
            embeds_one :reference, class_name:'FHIR::Reference'
            embeds_one :fhirType, class_name:'FHIR::Coding'
            embeds_one :role, class_name:'FHIR::Coding'
            embeds_one :lifecycle, class_name:'FHIR::Coding'
            embeds_many :securityLabel, class_name:'FHIR::Coding'
            field :name, type: String
            field :description, type: String
            field :query, type: String
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
