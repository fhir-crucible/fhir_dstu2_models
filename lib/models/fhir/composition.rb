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
            'section',
            'encounter',
            'type',
            'title',
            'attester',
            'entry',
            'patient',
            'context',
            'class',
            'status'
        ]
        
        VALID_CODES = {
            fhirClass: [ 'LP173387-4', 'LP173388-2', 'LP173389-0', 'LP173390-8', 'LP173394-0', 'LP173403-9', 'LP193873-9', 'LP173404-7', 'LP173405-4', 'LP173406-2', 'LP173407-0', 'LP181089-6', 'LP173409-6', 'LP173410-4', 'LP173412-0', 'LP173413-8', 'LP173414-6', 'LP173415-3', 'LP181112-6', 'LP181116-7', 'LP181119-1', 'LP173118-3', 'LP173416-1', 'LP173417-9', 'LP173418-7', 'LP173419-5', 'LP173420-3', 'LP181207-4', 'LP181204-1', 'LP156982-3', 'LP173421-1', 'LP183503-4', 'LP183502-6' ],
            status: [ 'preliminary', 'final', 'amended', 'entered-in-error' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec attester
        class CompositionAttesterComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                mode: [ 'personal', 'professional', 'legal', 'official' ]
            }
            
            field :mode, type: Array # Array of Strings
            validates_presence_of :mode
            field :time, type: String
            validates :time, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
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
            
            VALID_CODES = {
                code: [ '10154-3', '10157-6', '10160-0', '10164-2', '10183-2', '10184-0', '10187-3', '10210-3', '10216-0', '10218-6', '10218-6', '10223-6', '10830-8', '11329-0', '11348-0', '11369-6', '11450-4', '11493-4', '11535-2', '11537-8', '18776-5', '18841-7', '29299-5', '29545-1', '29549-3', '29554-3', '29762-2', '30954-2', '42344-2', '42346-7', '42348-3', '42349-1', '46240-8', '46241-6', '46264-8', '47420-5', '47519-4', '48765-2', '48768-6', '51848-0', '55109-3', '55122-6', '59768-2', '59769-0', '59770-8', '59771-6', '59772-4', '59773-2', '59775-7', '59776-5', '61149-1', '61150-9', '61150-9', '69730-0', '8648-8', '8653-8', '8716-3' ]
            }
            
            field :title, type: String
            embeds_one :code, class_name:'FHIR::CodeableConcept'
            embeds_one :text, class_name:'FHIR::Narrative'
            field :mode, type: String
            embeds_one :orderedBy, class_name:'FHIR::CodeableConcept'
            embeds_many :entry, class_name:'FHIR::Reference'
            embeds_one :emptyReason, class_name:'FHIR::CodeableConcept'
            embeds_many :section, class_name:'FHIR::Composition::SectionComponent'
        end
        
        embeds_one :identifier, class_name:'FHIR::Identifier'
        field :date, type: String
        validates :date, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        validates_presence_of :date
        embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
        validates_presence_of :fhirType
        embeds_one :fhirClass, class_name:'FHIR::CodeableConcept'
        field :title, type: String
        validates_presence_of :title
        field :status, type: String
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
