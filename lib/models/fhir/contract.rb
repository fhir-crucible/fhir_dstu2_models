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
    class Contract 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Contract
        
        SEARCH_PARAMS = [
            'actor',
            'identifier',
            'subject',
            'patient',
            'signer'
            ]
        # This is an ugly hack to deal with embedded structures in the spec actor
        class ActorComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :entity, class_name:'FHIR::Reference'
            validates_presence_of :entity
            embeds_many :role, class_name:'FHIR::CodeableConcept'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec valuedItem
        class ValuedItemComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :entityCodeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :entityReference, class_name:'FHIR::Reference'
            embeds_one :identifier, class_name:'FHIR::Identifier'
            field :effectiveTime, type: FHIR::PartialDateTime
            embeds_one :quantity, class_name:'FHIR::Quantity'
            embeds_one :unitPrice, class_name:'FHIR::Quantity'
            field :factor, type: Float
            field :points, type: Float
            embeds_one :net, class_name:'FHIR::Quantity'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec signer
        class SignatoryComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :fhirType, class_name:'FHIR::Coding'
            validates_presence_of :fhirType
            embeds_one :party, class_name:'FHIR::Reference'
            validates_presence_of :party
            field :signature, type: String
            validates_presence_of :signature
        end
        
        # This is an ugly hack to deal with embedded structures in the spec actor
        class TermActorComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :entity, class_name:'FHIR::Reference'
            validates_presence_of :entity
            embeds_many :role, class_name:'FHIR::CodeableConcept'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec valuedItem
        class TermValuedItemComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :entityCodeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :entityReference, class_name:'FHIR::Reference'
            embeds_one :identifier, class_name:'FHIR::Identifier'
            field :effectiveTime, type: FHIR::PartialDateTime
            embeds_one :quantity, class_name:'FHIR::Quantity'
            embeds_one :unitPrice, class_name:'FHIR::Quantity'
            field :factor, type: Float
            field :points, type: Float
            embeds_one :net, class_name:'FHIR::Quantity'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec term
        class TermComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :identifier, class_name:'FHIR::Identifier'
            field :issued, type: FHIR::PartialDateTime
            embeds_one :applies, class_name:'FHIR::Period'
            embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
            embeds_one :subType, class_name:'FHIR::CodeableConcept'
            embeds_one :subject, class_name:'FHIR::Reference'
            embeds_many :action, class_name:'FHIR::CodeableConcept'
            embeds_many :actionReason, class_name:'FHIR::CodeableConcept'
            embeds_many :actor, class_name:'FHIR::Contract::TermActorComponent'
            field :text, type: String
            embeds_many :valuedItem, class_name:'FHIR::Contract::TermValuedItemComponent'
            embeds_many :group, class_name:'FHIR::Contract::TermComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec friendly
        class FriendlyLanguageComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :contentAttachment, class_name:'FHIR::Attachment'
            validates_presence_of :contentAttachment
            embeds_one :contentReference, class_name:'FHIR::Reference'
            validates_presence_of :contentReference
        end
        
        # This is an ugly hack to deal with embedded structures in the spec legal
        class LegalLanguageComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :contentAttachment, class_name:'FHIR::Attachment'
            validates_presence_of :contentAttachment
            embeds_one :contentReference, class_name:'FHIR::Reference'
            validates_presence_of :contentReference
        end
        
        # This is an ugly hack to deal with embedded structures in the spec rule
        class ComputableLanguageComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :contentAttachment, class_name:'FHIR::Attachment'
            validates_presence_of :contentAttachment
            embeds_one :contentReference, class_name:'FHIR::Reference'
            validates_presence_of :contentReference
        end
        
        embeds_one :identifier, class_name:'FHIR::Identifier'
        field :issued, type: FHIR::PartialDateTime
        embeds_one :applies, class_name:'FHIR::Period'
        embeds_many :subject, class_name:'FHIR::Reference'
        embeds_many :authority, class_name:'FHIR::Reference'
        embeds_many :domain, class_name:'FHIR::Reference'
        embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
        embeds_many :subType, class_name:'FHIR::CodeableConcept'
        embeds_many :action, class_name:'FHIR::CodeableConcept'
        embeds_many :actionReason, class_name:'FHIR::CodeableConcept'
        embeds_many :actor, class_name:'FHIR::Contract::ActorComponent'
        embeds_many :valuedItem, class_name:'FHIR::Contract::ValuedItemComponent'
        embeds_many :signer, class_name:'FHIR::Contract::SignatoryComponent'
        embeds_many :term, class_name:'FHIR::Contract::TermComponent'
        embeds_one :bindingAttachment, class_name:'FHIR::Attachment'
        embeds_one :bindingReference, class_name:'FHIR::Reference'
        embeds_many :friendly, class_name:'FHIR::Contract::FriendlyLanguageComponent'
        embeds_many :legal, class_name:'FHIR::Contract::LegalLanguageComponent'
        embeds_many :rule, class_name:'FHIR::Contract::ComputableLanguageComponent'
        track_history
    end
end
