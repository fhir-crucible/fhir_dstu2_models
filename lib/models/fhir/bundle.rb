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
            fhirType: [ "document", "message", "transaction", "transaction-response", "history", "searchset", "collection" ]
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
                mode: [ "match", "include" ]
            }
            
            field :mode, type: String
            validates :mode, :inclusion => { in: VALID_CODES[:mode], :allow_nil => true }
            field :score, type: Float
        end
        
        # This is an ugly hack to deal with embedded structures in the spec transaction
        class BundleEntryTransactionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                method: [ "GET", "POST", "PUT", "DELETE" ]
            }
            
            field :method, type: String
            validates :method, :inclusion => { in: VALID_CODES[:method] }
            validates_presence_of :method
            field :url, type: String
            validates_presence_of :url
            field :ifNoneMatch, type: String
            field :ifMatch, type: String
            field :ifModifiedSince, type: DateTime
            field :ifNoneExist, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec transactionResponse
        class BundleEntryTransactionResponseComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :status, type: String
            validates_presence_of :status
            field :location, type: String
            field :etag, type: String
            field :lastModified, type: DateTime
        end
        
        # This is an ugly hack to deal with embedded structures in the spec entry
        class BundleEntryComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :base, type: String
            embeds_many :link, class_name:'FHIR::Bundle::BundleLinkComponent'
            field :resourceType, type: String
            attr_accessor :resource
            # field :resource, type: FHIR::AnyType
            embeds_one :search, class_name:'FHIR::Bundle::BundleEntrySearchComponent'
            embeds_one :transaction, class_name:'FHIR::Bundle::BundleEntryTransactionComponent'
            embeds_one :transactionResponse, class_name:'FHIR::Bundle::BundleEntryTransactionResponseComponent'
        end
        
        field :fhirType, type: String
        validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType] }
        validates_presence_of :fhirType
        field :base, type: String
        field :total, type: Integer
        embeds_many :link, class_name:'FHIR::Bundle::BundleLinkComponent'
        embeds_many :entry, class_name:'FHIR::Bundle::BundleEntryComponent'
        field :signature, type: Moped::BSON::Binary
        track_history
    end
end
