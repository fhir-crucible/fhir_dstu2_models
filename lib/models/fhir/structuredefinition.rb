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
    class StructureDefinition 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::StructureDefinition
        
        SEARCH_PARAMS = [
            'date',
            'identifier',
            'code',
            'valueset',
            'display',
            'description',
            'experimental',
            'context-type',
            'abstract',
            'type',
            'version',
            'url',
            'path',
            'ext-context',
            'name',
            'context',
            'publisher',
            'status',
            'base'
            ]
        
        VALID_CODES = {
            contextType: [ "resource", "datatype", "mapping", "extension" ],
            fhirType: [ "type", "resource", "constraint", "extension" ],
            status: [ "draft", "active", "retired" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec contact
        class StructureDefinitionContactComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :name, type: String
            embeds_many :telecom, class_name:'FHIR::ContactPoint'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec mapping
        class StructureDefinitionMappingComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :identity, type: String
            validates_presence_of :identity
            field :uri, type: String
            field :name, type: String
            field :comments, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec snapshot
        class StructureDefinitionSnapshotComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_many :element, class_name:'FHIR::ElementDefinition'
            validates_presence_of :element
        end
        
        # This is an ugly hack to deal with embedded structures in the spec differential
        class StructureDefinitionDifferentialComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_many :element, class_name:'FHIR::ElementDefinition'
            validates_presence_of :element
        end
        
        field :url, type: String
        validates_presence_of :url
        embeds_many :identifier, class_name:'FHIR::Identifier'
        field :versionNum, type: String
        field :name, type: String
        validates_presence_of :name
        embeds_many :useContext, class_name:'FHIR::CodeableConcept'
        field :display, type: String
        field :publisher, type: String
        embeds_many :contact, class_name:'FHIR::StructureDefinition::StructureDefinitionContactComponent'
        field :description, type: String
        field :requirements, type: String
        field :copyright, type: String
        embeds_many :code, class_name:'FHIR::Coding'
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        field :experimental, type: Boolean
        field :date, type: FHIR::PartialDateTime
        field :fhirVersion, type: String
        embeds_many :mapping, class_name:'FHIR::StructureDefinition::StructureDefinitionMappingComponent'
        field :fhirType, type: String
        validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType] }
        validates_presence_of :fhirType
        field :abstract, type: Boolean
        validates_presence_of :abstract
        field :contextType, type: String
        validates :contextType, :inclusion => { in: VALID_CODES[:contextType], :allow_nil => true }
        field :context, type: Array # Array of Strings
        field :base, type: String
        embeds_one :snapshot, class_name:'FHIR::StructureDefinition::StructureDefinitionSnapshotComponent'
        embeds_one :differential, class_name:'FHIR::StructureDefinition::StructureDefinitionDifferentialComponent'
        track_history
    end
end
