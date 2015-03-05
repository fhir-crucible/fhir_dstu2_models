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
    class DataElement 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::DataElement
        
        SEARCH_PARAMS = [
            'date',
            'identifier',
            'code',
            'name',
            'publisher',
            'description',
            'category',
            'version',
            'status'
            ]
        
        VALID_CODES = {
            granularity: [ "comparable", "fully specified", "equivalent", "convertable", "scaleable", "flexible" ],
            fhirType: [ "Address", "Age", "Attachment", "BackboneElement", "CodeableConcept", "Coding", "ContactPoint", "Count", "Distance", "Duration", "Element", "ElementDefinition", "Extension", "HumanName", "Identifier", "Money", "Narrative", "Period", "Quantity", "Range", "Ratio", "Reference", "SampledData", "Timing", "base64Binary", "boolean", "code", "date", "dateTime", "decimal", "id", "instant", "integer", "oid", "string", "time", "uri", "uuid" ],
            status: [ "draft", "active", "retired" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec binding
        class DataElementBindingComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                conformance: [ "required", "preferred", "example" ]
            }
            
            field :isExtensible, type: Boolean
            validates_presence_of :isExtensible
            field :conformance, type: String
            validates :conformance, :inclusion => { in: VALID_CODES[:conformance], :allow_nil => true }
            field :description, type: String
            embeds_one :valueSet, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec mapping
        class DataElementMappingComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :uri, type: String
            field :definitional, type: Boolean
            field :name, type: String
            field :comments, type: String
            field :map, type: String
            validates_presence_of :map
        end
        
        embeds_one :identifier, class_name:'FHIR::Identifier'
        field :versionNum, type: String
        field :publisher, type: String
        embeds_many :telecom, class_name:'FHIR::ContactPoint'
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        field :date, type: FHIR::PartialDateTime
        field :name, type: String
        embeds_many :category, class_name:'FHIR::CodeableConcept'
        field :granularity, type: String
        validates :granularity, :inclusion => { in: VALID_CODES[:granularity], :allow_nil => true }
        embeds_many :code, class_name:'FHIR::Coding'
        field :question, type: String
        field :label, type: String
        field :definition, type: String
        field :comments, type: String
        field :requirements, type: String
        field :synonym, type: Array # Array of Strings
        field :fhirType, type: String
        validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType], :allow_nil => true }
        field :exampleType, type: String
        attr_accessor :example
        # field :example, type: FHIR::AnyType
        field :maxLength, type: Integer
        embeds_one :unitsCodeableConcept, class_name:'FHIR::CodeableConcept'
        embeds_one :unitsReference, class_name:'FHIR::Reference'
        embeds_one :binding, class_name:'FHIR::DataElement::DataElementBindingComponent'
        embeds_many :mapping, class_name:'FHIR::DataElement::DataElementMappingComponent'
        track_history
    end
end
