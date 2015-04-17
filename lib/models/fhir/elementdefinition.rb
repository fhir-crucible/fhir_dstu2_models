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
    class ElementDefinition 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::ElementDefinition
        
        
        VALID_CODES = {
            representation: [ "xmlAttr" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec slicing
        class ElementDefinitionSlicingComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                rules: [ "closed", "open", "openAtEnd" ]
            }
            
            field :discriminator, type: Array # Array of Strings
            field :description, type: String
            field :ordered, type: Boolean
            field :rules, type: String
            validates :rules, :inclusion => { in: VALID_CODES[:rules] }
            validates_presence_of :rules
        end
        
        # This is an ugly hack to deal with embedded structures in the spec fhirType
        class TypeRefComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                code: [ "Address", "Age", "Attachment", "BackboneElement", "CodeableConcept", "Coding", "ContactPoint", "Count", "Distance", "Duration", "Element", "ElementDefinition", "Extension", "HumanName", "Identifier", "Meta", "Money", "Narrative", "Period", "Quantity", "Range", "Ratio", "Reference", "SampledData", "Signature", "Timing", "base64Binary", "boolean", "code", "date", "dateTime", "decimal", "id", "instant", "integer", "oid", "positiveInt", "string", "time", "unsignedInt", "uri", "uuid" ],
                aggregation: [ "contained", "referenced", "bundled" ]
            }
            
            field :code, type: String
            validates :code, :inclusion => { in: VALID_CODES[:code] }
            validates_presence_of :code
            field :profile, type: String
            field :aggregation, type: Array # Array of Strings
            validates :aggregation, :inclusion => { in: VALID_CODES[:aggregation], :allow_nil => true }
        end
        
        # This is an ugly hack to deal with embedded structures in the spec constraint
        class ElementDefinitionConstraintComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                severity: [ "error", "warning" ]
            }
            
            field :key, type: String
            validates_presence_of :key
            field :name, type: String
            field :severity, type: String
            validates :severity, :inclusion => { in: VALID_CODES[:severity] }
            validates_presence_of :severity
            field :human, type: String
            validates_presence_of :human
            field :xpath, type: String
            validates_presence_of :xpath
        end
        
        # This is an ugly hack to deal with embedded structures in the spec binding
        class ElementDefinitionBindingComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                strength: [ "required", "extensible", "preferred", "example" ]
            }
            
            field :name, type: String
            validates_presence_of :name
            field :strength, type: String
            validates :strength, :inclusion => { in: VALID_CODES[:strength] }
            validates_presence_of :strength
            field :description, type: String
            field :valueSetUri, type: String
            embeds_one :valueSetReference, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec mapping
        class ElementDefinitionMappingComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :fhirIdentity, type: String
            validates_presence_of :fhirIdentity
            field :language, type: String
            field :map, type: String
            validates_presence_of :map
        end
        
        field :path, type: String
        validates_presence_of :path
        field :representation, type: Array # Array of Strings
        validates :representation, :inclusion => { in: VALID_CODES[:representation], :allow_nil => true }
        field :name, type: String
        field :label, type: String
        embeds_many :code, class_name:'FHIR::Coding'
        embeds_one :slicing, class_name:'FHIR::ElementDefinition::ElementDefinitionSlicingComponent'
        field :short, type: String
        field :definition, type: String
        field :comments, type: String
        field :requirements, type: String
        field :alias, type: Array # Array of Strings
        field :min, type: Integer
        field :max, type: String
        embeds_many :fhirType, class_name:'FHIR::ElementDefinition::TypeRefComponent'
        field :nameReference, type: String
        field :defaultValueType, type: String
        attr_accessor :defaultValue
        # field :defaultValue, type: FHIR::AnyType
        field :meaningWhenMissing, type: String
        field :fixedType, type: String
        attr_accessor :fixed
        # field :fixed, type: FHIR::AnyType
        field :patternType, type: String
        attr_accessor :pattern
        # field :pattern, type: FHIR::AnyType
        field :exampleType, type: String
        attr_accessor :example
        # field :example, type: FHIR::AnyType
        field :maxLength, type: Integer
        field :condition, type: Array # Array of Strings
        embeds_many :constraint, class_name:'FHIR::ElementDefinition::ElementDefinitionConstraintComponent'
        field :mustSupport, type: Boolean
        field :isModifier, type: Boolean
        field :isSummary, type: Boolean
        embeds_one :binding, class_name:'FHIR::ElementDefinition::ElementDefinitionBindingComponent'
        embeds_many :mapping, class_name:'FHIR::ElementDefinition::ElementDefinitionMappingComponent'
        track_history
    end
end
