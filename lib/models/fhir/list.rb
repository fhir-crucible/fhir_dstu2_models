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
    class List 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::List
        
        SEARCH_PARAMS = [
            'patient',
            'source',
            'subject',
            'item',
            'code',
            'date',
            'empty-reason'
            ]
        
        VALID_CODES = {
            mode: [ "working", "snapshot", "changes" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec entry
        class ListEntryComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_many :flag, class_name:'FHIR::CodeableConcept'
            field :fhirDeleted, type: Boolean
            field :date, type: FHIR::PartialDateTime
            embeds_one :item, class_name:'FHIR::Reference'
            validates_presence_of :item
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :code, class_name:'FHIR::CodeableConcept'
        embeds_one :subject, class_name:'FHIR::Reference'
        embeds_one :source, class_name:'FHIR::Reference'
        field :date, type: FHIR::PartialDateTime
        field :ordered, type: Boolean
        field :mode, type: String
        validates :mode, :inclusion => { in: VALID_CODES[:mode] }
        validates_presence_of :mode
        embeds_many :entry, class_name:'FHIR::List::ListEntryComponent'
        embeds_one :emptyReason, class_name:'FHIR::CodeableConcept'
        track_history
    end
end
