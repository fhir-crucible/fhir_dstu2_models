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
    class NamingSystem 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::NamingSystem
        
        SEARCH_PARAMS = [
            'date',
            'period',
            'kind',
            'type',
            'id-type',
            'responsible',
            'contact',
            'name',
            'context',
            'publisher',
            'telecom',
            'value',
            'replaced-by',
            'status'
        ]
        
        VALID_CODES = {
            kind: [ 'codesystem', 'identifier', 'root' ],
            useContext: [ 'AK', 'AL', 'AR', 'AS', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'FM', 'GA', 'GU', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MH', 'MI', 'MN', 'MO', 'MP', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'PR', 'PW', 'RI', 'SC', 'SD', 'TN', 'TX', 'UM', 'UT', 'VA', 'VI', 'VT', 'WA', 'WI', 'WV', 'WY', 'cardio', 'dent', 'dietary', 'midw', 'sysarch' ],
            fhirType: [ 'UDI', 'SNO', 'SB', 'PLAC', 'FILL', 'DL', 'PPN', 'BRN', 'MR', 'MCN', 'EN', 'TAX', 'NIIP', 'PRN', 'MD', 'DR' ],
            status: [ 'draft', 'active', 'retired' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec contact
        class NamingSystemContactComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :name, type: String
            embeds_many :telecom, class_name:'FHIR::ContactPoint'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec uniqueId
        class NamingSystemUniqueIdComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ 'oid', 'uuid', 'uri', 'other' ]
            }
            
            field :fhirType, type: String
            validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType] }
            validates_presence_of :fhirType
            field :value, type: String
            validates_presence_of :value
            field :preferred, type: Boolean
            embeds_one :period, class_name:'FHIR::Period'
        end
        
        field :name, type: String
        validates_presence_of :name
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        field :kind, type: String
        validates :kind, :inclusion => { in: VALID_CODES[:kind] }
        validates_presence_of :kind
        field :publisher, type: String
        embeds_many :contact, class_name:'FHIR::NamingSystem::NamingSystemContactComponent'
        field :responsible, type: String
        field :date, type: String
        validates :date, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        validates_presence_of :date
        embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
        field :description, type: String
        embeds_many :useContext, class_name:'FHIR::CodeableConcept'
        field :usage, type: String
        embeds_many :uniqueId, class_name:'FHIR::NamingSystem::NamingSystemUniqueIdComponent'
        validates_presence_of :uniqueId
        embeds_one :replacedBy, class_name:'FHIR::Reference'
        track_history
    end
end
