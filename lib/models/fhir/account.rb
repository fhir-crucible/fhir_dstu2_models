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
    class Account 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Account
        
        SEARCH_PARAMS = [
            'owner',
            'identifier',
            'period',
            'balance',
            'subject',
            'patient',
            'name',
            'type',
            'status'
        ]
        
        VALID_CODES = {
            status: [ 'active', 'inactive' ]
        }
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        field :name, type: String
        embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status], :allow_nil => true }
        embeds_one :activePeriod, class_name:'FHIR::Period'
        embeds_one :currency, class_name:'FHIR::Coding'
        embeds_one :balance, class_name:'FHIR::Quantity'
        embeds_one :coveragePeriod, class_name:'FHIR::Period'
        embeds_one :subject, class_name:'FHIR::Reference'
        embeds_one :owner, class_name:'FHIR::Reference'
        field :description, type: String
        track_history
    end
end
