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
    class Location 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Location
        
        SEARCH_PARAMS = [
            'identifier',
            'partof',
            'near-distance',
            'address',
            'address-state',
            'type',
            'address-postalcode',
            'address-country',
            'organization',
            'name',
            'address-use',
            'near',
            'address-city',
            'status'
        ]
        
        VALID_CODES = {
            mode: [ 'instance', 'kind' ],
            physicalType: [ 'bu', 'wi', 'lvl', 'co', 'ro', 'bd', 've', 'ho', 'ca', 'rd', 'jdn', 'area' ],
            status: [ 'active', 'suspended', 'inactive' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec position
        class LocationPositionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :longitude, type: Float
            validates_presence_of :longitude
            field :latitude, type: Float
            validates_presence_of :latitude
            field :altitude, type: Float
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        field :status, type: String
        field :name, type: String
        field :description, type: String
        field :mode, type: String
        embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
        embeds_many :telecom, class_name:'FHIR::ContactPoint'
        embeds_one :address, class_name:'FHIR::Address'
        embeds_one :physicalType, class_name:'FHIR::CodeableConcept'
        embeds_one :position, class_name:'FHIR::Location::LocationPositionComponent'
        embeds_one :managingOrganization, class_name:'FHIR::Reference'
        embeds_one :partOf, class_name:'FHIR::Reference'
        track_history
    end
end
