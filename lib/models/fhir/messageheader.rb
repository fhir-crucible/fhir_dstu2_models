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
    class MessageHeader 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::MessageHeader
        
        SEARCH_PARAMS = [
            'destination-uri',
            'code',
            'data',
            'receiver',
            'src-id',
            'source-uri',
            'destination',
            'response-id',
            'source',
            'event',
            'timestamp'
            ]
        
        VALID_CODES = {
            event: [ "MedicationAdministration-Complete", "MedicationAdministration-Nullification", "MedicationAdministration-Recording", "MedicationAdministration-Update", "admin-notify", "conceptmap-translate", "diagnosticreport-provide", "observation-provide", "patient-link", "patient-unlink", "valueset-expand", "valueset-validate" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec response
        class MessageHeaderResponseComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                code: [ "ok", "transient-error", "fatal-error" ]
            }
            
            field :identifier, type: String
            validates_presence_of :identifier
            field :code, type: String
            validates :code, :inclusion => { in: VALID_CODES[:code] }
            validates_presence_of :code
            embeds_one :details, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec source
        class MessageSourceComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :name, type: String
            field :software, type: String
            field :versionNum, type: String
            embeds_one :contact, class_name:'FHIR::ContactPoint'
            field :endpoint, type: String
            validates_presence_of :endpoint
        end
        
        # This is an ugly hack to deal with embedded structures in the spec destination
        class MessageDestinationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :name, type: String
            embeds_one :target, class_name:'FHIR::Reference'
            field :endpoint, type: String
            validates_presence_of :endpoint
        end
        
        field :identifier, type: String
        validates_presence_of :identifier
        field :timestamp, type: DateTime
        validates_presence_of :timestamp
        embeds_one :event, class_name:'FHIR::Coding'
        validates_presence_of :event
        embeds_one :response, class_name:'FHIR::MessageHeader::MessageHeaderResponseComponent'
        embeds_one :source, class_name:'FHIR::MessageHeader::MessageSourceComponent'
        validates_presence_of :source
        embeds_many :destination, class_name:'FHIR::MessageHeader::MessageDestinationComponent'
        embeds_one :enterer, class_name:'FHIR::Reference'
        embeds_one :author, class_name:'FHIR::Reference'
        embeds_one :receiver, class_name:'FHIR::Reference'
        embeds_one :responsible, class_name:'FHIR::Reference'
        embeds_one :reason, class_name:'FHIR::CodeableConcept'
        embeds_many :data, class_name:'FHIR::Reference'
        track_history
    end
end
