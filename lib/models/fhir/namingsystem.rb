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
    class NamingSystem 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::NamingSystem
        
        SEARCH_PARAMS = [
            ]
        
        VALID_CODES = {
            fhirType: [ "codesystem", "identifier", "root" ],
            status: [ "proposed", "active", "retired" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec uniqueId
        class NamingSystemUniqueIdComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ "oid", "uuid", "uri", "other" ]
            }
            
            field :fhirType, type: String
            validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType] }
            validates_presence_of :fhirType
            field :value, type: String
            validates_presence_of :value
            field :preferred, type: Boolean
            embeds_one :period, class_name:'FHIR::Period'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec contact
        class NamingSystemContactComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :name, class_name:'FHIR::HumanName'
            embeds_many :telecom, class_name:'FHIR::ContactPoint'
        end
        
        field :fhirType, type: String
        validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType] }
        validates_presence_of :fhirType
        field :name, type: String
        validates_presence_of :name
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        field :country, type: String
        embeds_one :category, class_name:'FHIR::CodeableConcept'
        field :responsible, type: String
        field :description, type: String
        field :usage, type: String
        embeds_many :uniqueId, class_name:'FHIR::NamingSystem::NamingSystemUniqueIdComponent'
        validates_presence_of :uniqueId
        embeds_one :contact, class_name:'FHIR::NamingSystem::NamingSystemContactComponent'
        embeds_one :replacedBy, class_name:'FHIR::Reference'
        track_history
    end
end
