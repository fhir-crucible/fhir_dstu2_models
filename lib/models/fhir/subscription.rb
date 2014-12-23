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
    class Subscription 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Subscription
        
        SEARCH_PARAMS = [
            'criteria',
            'status',
            'tag',
            'payload',
            'type',
            'contact',
            'url'
            ]
        
        VALID_CODES = {
            status: [ "requested", "active", "error", "off" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec channel
        class SubscriptionChannelComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ "rest-hook", "websocket", "email", "sms", "message" ]
            }
            
            field :fhirType, type: String
            validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType] }
            validates_presence_of :fhirType
            field :url, type: String
            field :payload, type: String
            validates_presence_of :payload
            field :header, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec tag
        class SubscriptionTagComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :term, type: String
            validates_presence_of :term
            field :scheme, type: String
            validates_presence_of :scheme
            field :description, type: String
        end
        
        field :criteria, type: String
        validates_presence_of :criteria
        embeds_many :contact, class_name:'FHIR::ContactPoint'
        field :reason, type: String
        validates_presence_of :reason
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        field :error, type: String
        embeds_one :channel, class_name:'FHIR::Subscription::SubscriptionChannelComponent'
        validates_presence_of :channel
        field :end, type: DateTime
        embeds_many :tag, class_name:'FHIR::Subscription::SubscriptionTagComponent'
        track_history
    end
end
