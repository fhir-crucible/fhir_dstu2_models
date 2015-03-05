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
    class Person 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Person
        
        SEARCH_PARAMS = [
            'identifier',
            'phonetic',
            'address',
            'birthdate',
            'gender',
            'organization',
            'name',
            'telecom'
            ]
        
        VALID_CODES = {
            gender: [ "male", "female", "other", "unknown" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec link
        class PersonLinkComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                assurance: [ "level1", "level2", "level3", "level4" ]
            }
            
            embeds_one :other, class_name:'FHIR::Reference'
            validates_presence_of :other
            field :assurance, type: String
            validates :assurance, :inclusion => { in: VALID_CODES[:assurance], :allow_nil => true }
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_many :name, class_name:'FHIR::HumanName'
        embeds_many :telecom, class_name:'FHIR::ContactPoint'
        field :gender, type: String
        validates :gender, :inclusion => { in: VALID_CODES[:gender], :allow_nil => true }
        field :birthDate, type: FHIR::PartialDateTime
        embeds_many :address, class_name:'FHIR::Address'
        embeds_one :photo, class_name:'FHIR::Attachment'
        embeds_one :managingOrganization, class_name:'FHIR::Reference'
        field :active, type: Boolean
        embeds_many :link, class_name:'FHIR::Person::PersonLinkComponent'
        track_history
    end
end
