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
    class DeviceComponent 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::DeviceComponent
        
        SEARCH_PARAMS = [
            'parent',
            'source',
            'type'
            ]
        
        VALID_CODES = {
            measurementPrinciple: [ "other", "chemical", "electrical", "impedance", "nuclear", "optical", "thermal", "biological", "mechanical", "acoustical", "manual" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec productionSpecification
        class DeviceComponentProductionSpecificationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :specType, class_name:'FHIR::CodeableConcept'
            embeds_one :componentId, class_name:'FHIR::Identifier'
            field :productionSpec, type: String
        end
        
        embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
        validates_presence_of :fhirType
        embeds_one :identifier, class_name:'FHIR::Identifier'
        validates_presence_of :identifier
        field :lastSystemChange, type: DateTime
        validates_presence_of :lastSystemChange
        embeds_one :source, class_name:'FHIR::Reference'
        embeds_one :parent, class_name:'FHIR::Reference'
        embeds_many :operationalStatus, class_name:'FHIR::CodeableConcept'
        embeds_one :parameterGroup, class_name:'FHIR::CodeableConcept'
        field :measurementPrinciple, type: String
        validates :measurementPrinciple, :inclusion => { in: VALID_CODES[:measurementPrinciple], :allow_nil => true }
        embeds_many :productionSpecification, class_name:'FHIR::DeviceComponent::DeviceComponentProductionSpecificationComponent'
        embeds_one :languageCode, class_name:'FHIR::CodeableConcept'
        track_history
    end
end
