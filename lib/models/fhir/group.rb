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
    class Group 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Group
        
        SEARCH_PARAMS = [
            'actual',
            'identifier',
            'characteristic-value',
            'code',
            'member',
            'exclude',
            'type',
            'value',
            'characteristic'
        ]
        
        VALID_CODES = {
            fhirType: [ 'person', 'animal', 'practitioner', 'device', 'medication', 'substance' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec characteristic
        class GroupCharacteristicComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            MULTIPLE_TYPES = {
                value: [ 'valueCodeableConcept', 'valueBoolean', 'valueQuantity', 'valueRange' ]
            }
            
            embeds_one :code, class_name:'FHIR::CodeableConcept'
            validates_presence_of :code
            embeds_one :valueCodeableConcept, class_name:'FHIR::CodeableConcept'
            validates_presence_of :valueCodeableConcept
            field :valueBoolean, type: Boolean
            validates_presence_of :valueBoolean
            embeds_one :valueQuantity, class_name:'FHIR::Quantity'
            validates_presence_of :valueQuantity
            embeds_one :valueRange, class_name:'FHIR::Range'
            validates_presence_of :valueRange
            field :exclude, type: Boolean
            validates_presence_of :exclude
            embeds_one :period, class_name:'FHIR::Period'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec member
        class GroupMemberComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :entity, class_name:'FHIR::Reference'
            validates_presence_of :entity
            embeds_one :period, class_name:'FHIR::Period'
            field :inactive, type: Boolean
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        field :fhirType, type: String
        validates_presence_of :fhirType
        field :actual, type: Boolean
        validates_presence_of :actual
        embeds_one :code, class_name:'FHIR::CodeableConcept'
        field :name, type: String
        field :quantity, type: Integer
        embeds_many :characteristic, class_name:'FHIR::Group::GroupCharacteristicComponent'
        embeds_many :member, class_name:'FHIR::Group::GroupMemberComponent'
        track_history
    end
end
