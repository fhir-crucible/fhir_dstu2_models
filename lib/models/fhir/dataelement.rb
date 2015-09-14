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
    class DataElement 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::DataElement
        
        SEARCH_PARAMS = [
            'date',
            'identifier',
            'code',
            'stringency',
            'name',
            'context',
            'publisher',
            'description',
            'version',
            'url',
            'status'
        ]
        
        VALID_CODES = {
            stringency: [ 'comparable', 'fully-specified', 'equivalent', 'convertable', 'scaleable', 'flexible' ],
            status: [ 'draft', 'active', 'retired' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec contact
        class DataElementContactComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :name, type: String
            embeds_many :telecom, class_name:'FHIR::ContactPoint'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec mapping
        class DataElementMappingComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :fhirIdentity, type: String
            validates_presence_of :fhirIdentity
            field :uri, type: String
            field :name, type: String
            field :comments, type: String
        end
        
        field :url, type: String
        embeds_many :identifier, class_name:'FHIR::Identifier'
        field :versionNum, type: String
        field :name, type: String
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        field :experimental, type: Boolean
        field :publisher, type: String
        embeds_many :contact, class_name:'FHIR::DataElement::DataElementContactComponent'
        field :date, type: String
        validates :date, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        embeds_many :useContext, class_name:'FHIR::CodeableConcept'
        field :copyright, type: String
        field :stringency, type: String
        embeds_many :mapping, class_name:'FHIR::DataElement::DataElementMappingComponent'
        embeds_many :element, class_name:'FHIR::ElementDefinition'
        validates_presence_of :element
        track_history
    end
end
