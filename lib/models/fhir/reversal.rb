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
    class Reversal 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Reversal
        
        SEARCH_PARAMS = [
            'identifier'
            ]
        # This is an ugly hack to deal with embedded structures in the spec payee
        class PayeeComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :fhirType, class_name:'FHIR::Coding'
            embeds_one :provider, class_name:'FHIR::Reference'
            embeds_one :organization, class_name:'FHIR::Reference'
            embeds_one :person, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec coverage
        class ReversalCoverageComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :sequence, type: Integer
            validates_presence_of :sequence
            field :focal, type: Boolean
            validates_presence_of :focal
            embeds_one :coverage, class_name:'FHIR::Reference'
            validates_presence_of :coverage
            field :businessArrangement, type: String
            embeds_one :relationship, class_name:'FHIR::Coding'
            validates_presence_of :relationship
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :ruleset, class_name:'FHIR::Coding'
        embeds_one :originalRuleset, class_name:'FHIR::Coding'
        field :created, type: FHIR::PartialDateTime
        embeds_one :target, class_name:'FHIR::Reference'
        embeds_one :provider, class_name:'FHIR::Reference'
        embeds_one :organization, class_name:'FHIR::Reference'
        embeds_one :request, class_name:'FHIR::Reference'
        embeds_one :response, class_name:'FHIR::Reference'
        embeds_one :payee, class_name:'FHIR::Reversal::PayeeComponent'
        embeds_one :coverage, class_name:'FHIR::Reversal::ReversalCoverageComponent'
        validates_presence_of :coverage
        field :nullify, type: Boolean
        validates_presence_of :nullify
        track_history
    end
end
