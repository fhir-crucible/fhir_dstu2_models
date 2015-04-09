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
    class QuestionnaireAnswers 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::QuestionnaireAnswers
        
        SEARCH_PARAMS = [
            'authored',
            'questionnaire',
            'subject',
            'author',
            'patient',
            'encounter',
            'source',
            'status'
            ]
        
        VALID_CODES = {
            status: [ "in-progress", "completed", "amended" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec answer
        class QuestionAnswerComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :valueBoolean, type: Boolean
            field :valueDecimal, type: Float
            field :valueInteger, type: Integer
            field :valueDate, type: FHIR::PartialDateTime
            field :valueDateTime, type: FHIR::PartialDateTime
            field :valueInstant, type: DateTime
            field :valueTime, type: FHIR::PartialDateTime
            field :valueString, type: String
            field :valueUri, type: String
            embeds_one :valueAttachment, class_name:'FHIR::Attachment'
            embeds_one :valueCoding, class_name:'FHIR::Coding'
            embeds_one :valueQuantity, class_name:'FHIR::Quantity'
            embeds_one :valueReference, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec question
        class QuestionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :linkId, type: String
            field :text, type: String
            embeds_many :answer, class_name:'FHIR::QuestionnaireAnswers::QuestionAnswerComponent'
            embeds_many :group, class_name:'FHIR::QuestionnaireAnswers::GroupComponent', cyclic: true
        end
        
        # This is an ugly hack to deal with embedded structures in the spec group
        class GroupComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :linkId, type: String
            field :title, type: String
            field :text, type: String
            embeds_one :subject, class_name:'FHIR::Reference'
            embeds_many :group, class_name:'FHIR::QuestionnaireAnswers::GroupComponent', cyclic: true
            embeds_many :question, class_name:'FHIR::QuestionnaireAnswers::QuestionComponent', cyclic: true
        end
        
        embeds_one :identifier, class_name:'FHIR::Identifier'
        embeds_one :questionnaire, class_name:'FHIR::Reference'
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        embeds_one :subject, class_name:'FHIR::Reference'
        embeds_one :author, class_name:'FHIR::Reference'
        field :authored, type: FHIR::PartialDateTime
        embeds_one :source, class_name:'FHIR::Reference'
        embeds_one :encounter, class_name:'FHIR::Reference'
        embeds_one :group, class_name:'FHIR::QuestionnaireAnswers::GroupComponent'
        track_history
    end
end
