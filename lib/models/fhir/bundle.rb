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
    class Bundle 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Bundle
        
        SEARCH_PARAMS = [
            'composition',
            'type',
            'message'
        ]
        
        VALID_CODES = {
            fhirType: [ 'document', 'message', 'transaction', 'transaction-response', 'batch', 'batch-response', 'history', 'searchset', 'collection' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec link
        class BundleLinkComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :relation, type: String
            validates_presence_of :relation
            field :url, type: String
            validates_presence_of :url
        end
        
        # This is an ugly hack to deal with embedded structures in the spec search
        class BundleEntrySearchComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                mode: [ 'match', 'include', 'outcome' ]
            }
            
            field :mode, type: String
            field :score, type: Float
        end
        
        # This is an ugly hack to deal with embedded structures in the spec request
        class BundleEntryRequestComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                method: [ 'GET', 'POST', 'PUT', 'DELETE' ]
            }
            
            field :method, type: String
            validates_presence_of :method
            field :url, type: String
            validates_presence_of :url
            field :ifNoneMatch, type: String
            field :ifModifiedSince, type: String
            validates :ifModifiedSince, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))))\Z/ }
            field :ifMatch, type: String
            field :ifNoneExist, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec response
        class BundleEntryResponseComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :status, type: String
            validates_presence_of :status
            field :location, type: String
            field :etag, type: String
            field :lastModified, type: String
            validates :lastModified, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))))\Z/ }
        end
        
        # This is an ugly hack to deal with embedded structures in the spec entry
        class BundleEntryComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_many :link, class_name:'FHIR::Bundle::BundleLinkComponent'
            field :fullUrl, type: String
            field :resourceType, type: String
            attr_accessor :resource
            # field :resource, type: FHIR::AnyType
            embeds_one :search, class_name:'FHIR::Bundle::BundleEntrySearchComponent'
            embeds_one :request, class_name:'FHIR::Bundle::BundleEntryRequestComponent'
            embeds_one :response, class_name:'FHIR::Bundle::BundleEntryResponseComponent'
        end
        
        field :fhirType, type: String
        validates_presence_of :fhirType
        field :total, type: Integer
        embeds_many :link, class_name:'FHIR::Bundle::BundleLinkComponent'
        embeds_many :entry, class_name:'FHIR::Bundle::BundleEntryComponent'
        embeds_one :signature, class_name:'FHIR::Signature'
        track_history
    end
end
