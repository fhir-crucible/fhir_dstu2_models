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
    class ValueSet 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::ValueSet
        
        SEARCH_PARAMS = [
            'date',
            'identifier',
            'code',
            'description',
            'version',
            'url',
            'expansion',
            'reference',
            'system',
            'name',
            'context',
            'publisher',
            'status'
        ]
        
        VALID_CODES = {
            status: [ 'draft', 'active', 'retired' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec contact
        class ValueSetContactComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :name, type: String
            embeds_many :telecom, class_name:'FHIR::ContactPoint'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec designation
        class ConceptDefinitionDesignationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :language, type: String
            embeds_one :use, class_name:'FHIR::Coding'
            field :value, type: String
            validates_presence_of :value
        end
        
        # This is an ugly hack to deal with embedded structures in the spec concept
        class ConceptDefinitionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :code, type: String
            validates_presence_of :code
            field :abstract, type: Boolean
            field :display, type: String
            field :definition, type: String
            embeds_many :designation, class_name:'FHIR::ValueSet::ConceptDefinitionDesignationComponent'
            embeds_many :concept, class_name:'FHIR::ValueSet::ConceptDefinitionComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec codeSystem
        class ValueSetCodeSystemComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :system, type: String
            validates_presence_of :system
            field :versionNum, type: String
            field :caseSensitive, type: Boolean
            embeds_many :concept, class_name:'FHIR::ValueSet::ConceptDefinitionComponent'
            validates_presence_of :concept
        end
        
        # This is an ugly hack to deal with embedded structures in the spec concept
        class ConceptReferenceComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :code, type: String
            validates_presence_of :code
            field :display, type: String
            embeds_many :designation, class_name:'FHIR::ValueSet::ConceptDefinitionDesignationComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec filter
        class ConceptSetFilterComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                op: [ '=', 'is-a', 'is-not-a', 'regex', 'in', 'not-in' ]
            }
            
            field :property, type: String
            validates_presence_of :property
            field :op, type: String
            validates_presence_of :op
            field :value, type: String
            validates_presence_of :value
        end
        
        # This is an ugly hack to deal with embedded structures in the spec include
        class ConceptSetComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :system, type: String
            validates_presence_of :system
            field :versionNum, type: String
            embeds_many :concept, class_name:'FHIR::ValueSet::ConceptReferenceComponent'
            embeds_many :filter, class_name:'FHIR::ValueSet::ConceptSetFilterComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec compose
        class ValueSetComposeComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :import, type: Array # Array of Strings
            embeds_many :include, class_name:'FHIR::ValueSet::ConceptSetComponent'
            embeds_many :exclude, class_name:'FHIR::ValueSet::ConceptSetComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec parameter
        class ValueSetExpansionParameterComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            MULTIPLE_TYPES = {
                value: [ 'valueString', 'valueBoolean', 'valueInteger', 'valueDecimal', 'valueUri', 'valueCode' ]
            }
            
            field :name, type: String
            validates_presence_of :name
            field :valueString, type: String
            field :valueBoolean, type: Boolean
            field :valueInteger, type: Integer
            field :valueDecimal, type: Float
            field :valueUri, type: String
            field :valueCode, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec contains
        class ValueSetExpansionContainsComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :system, type: String
            field :abstract, type: Boolean
            field :versionNum, type: String
            field :code, type: String
            field :display, type: String
            embeds_many :contains, class_name:'FHIR::ValueSet::ValueSetExpansionContainsComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec expansion
        class ValueSetExpansionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :identifier, type: String
            validates_presence_of :identifier
            field :timestamp, type: String
            validates :timestamp, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
            validates_presence_of :timestamp
            field :total, type: Integer
            field :offset, type: Integer
            embeds_many :parameter, class_name:'FHIR::ValueSet::ValueSetExpansionParameterComponent'
            embeds_many :contains, class_name:'FHIR::ValueSet::ValueSetExpansionContainsComponent'
        end
        
        field :url, type: String
        embeds_one :identifier, class_name:'FHIR::Identifier'
        field :versionNum, type: String
        field :name, type: String
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        field :experimental, type: Boolean
        field :publisher, type: String
        embeds_many :contact, class_name:'FHIR::ValueSet::ValueSetContactComponent'
        field :date, type: String
        validates :date, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        field :lockedDate, type: String
        validates :lockedDate, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1]))?)?\Z/ }
        field :description, type: String
        embeds_many :useContext, class_name:'FHIR::CodeableConcept'
        field :immutable, type: Boolean
        field :requirements, type: String
        field :copyright, type: String
        field :extensible, type: Boolean
        embeds_one :codeSystem, class_name:'FHIR::ValueSet::ValueSetCodeSystemComponent'
        embeds_one :compose, class_name:'FHIR::ValueSet::ValueSetComposeComponent'
        embeds_one :expansion, class_name:'FHIR::ValueSet::ValueSetExpansionComponent'
        track_history
    end
end
