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
    class Composition 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Composition
        
        SEARCH_PARAMS = [
            'date',
            'identifier',
            'period',
            'subject',
            'author',
            'confidentiality',
            'section-code',
            'section',
            'encounter',
            'type',
            'title',
            'attester',
            'patient',
            'context',
            'class',
            'status'
            ]
        
        VALID_CODES = {
            status: [ "preliminary", "final", "appended", "amended", "entered-in-error" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec attester
        class CompositionAttesterComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                mode: [ "personal", "professional", "legal", "official" ]
            }
            
            field :mode, type: Array # Array of Strings
            validates :mode, :inclusion => { in: VALID_CODES[:mode] }
            validates_presence_of :mode
            field :time, type: FHIR::PartialDateTime
            embeds_one :party, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec event
        class CompositionEventComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_many :code, class_name:'FHIR::CodeableConcept'
            embeds_one :period, class_name:'FHIR::Period'
            embeds_many :detail, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec section
        class SectionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :title, type: String
            embeds_one :code, class_name:'FHIR::CodeableConcept'
            embeds_one :content, class_name:'FHIR::Reference'
            embeds_many :section, class_name:'FHIR::Composition::SectionComponent'
        end
        
        embeds_one :identifier, class_name:'FHIR::Identifier'
        field :date, type: FHIR::PartialDateTime
        validates_presence_of :date
        embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
        validates_presence_of :fhirType
        embeds_one :fhirClass, class_name:'FHIR::CodeableConcept'
        field :title, type: String
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        field :confidentiality, type: String
        embeds_one :subject, class_name:'FHIR::Reference'
        validates_presence_of :subject
        embeds_many :author, class_name:'FHIR::Reference'
        validates_presence_of :author
        embeds_many :attester, class_name:'FHIR::Composition::CompositionAttesterComponent'
        embeds_one :custodian, class_name:'FHIR::Reference'
        embeds_many :event, class_name:'FHIR::Composition::CompositionEventComponent'
        embeds_one :encounter, class_name:'FHIR::Reference'
        embeds_many :section, class_name:'FHIR::Composition::SectionComponent'
        track_history
    end
end
