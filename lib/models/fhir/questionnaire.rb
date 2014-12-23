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
    class Questionnaire 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Questionnaire
        
        SEARCH_PARAMS = [
            'title',
            'status',
            'code',
            'date',
            'identifier',
            'version',
            'publisher'
            ]
        
        VALID_CODES = {
            status: [ "draft", "published", "retired" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec question
        class QuestionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ "boolean", "decimal", "integer", "date", "dateTime", "instant", "time", "string", "text", "choice", "open-choice", "attachment", "reference", "quantity" ]
            }
            
            field :linkId, type: String
            embeds_many :concept, class_name:'FHIR::Coding'
            field :text, type: String
            field :fhirType, type: String
            validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType], :allow_nil => true }
            field :required, type: Boolean
            field :repeats, type: Boolean
            embeds_one :options, class_name:'FHIR::Reference'
            embeds_many :group, class_name:'FHIR::Questionnaire::GroupComponent', cyclic: true
        end
        
        # This is an ugly hack to deal with embedded structures in the spec group
        class GroupComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :linkId, type: String
            field :title, type: String
            embeds_many :concept, class_name:'FHIR::Coding'
            field :text, type: String
            field :required, type: Boolean
            field :repeats, type: Boolean
            embeds_many :group, class_name:'FHIR::Questionnaire::GroupComponent', cyclic: true
            embeds_many :question, class_name:'FHIR::Questionnaire::QuestionComponent', cyclic: true
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        field :versionNum, type: String
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        field :date, type: FHIR::PartialDateTime
        field :publisher, type: String
        embeds_one :group, class_name:'FHIR::Questionnaire::GroupComponent'
        validates_presence_of :group
        track_history
    end
end
