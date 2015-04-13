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
    class NutritionOrder 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::NutritionOrder
        
        SEARCH_PARAMS = [
            'identifier',
            'datetime',
            'provider',
            'patient',
            'supplement',
            'formula',
            'encounter',
            'oraldiet',
            'status',
            'additive'
            ]
        
        VALID_CODES = {
            status: [ "proposed", "draft", "planned", "requested", "active", "on-hold", "completed", "cancelled" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec nutrient
        class NutritionOrderOralDietNutrientComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :modifier, class_name:'FHIR::CodeableConcept'
            embeds_one :amount, class_name:'FHIR::Quantity'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec texture
        class NutritionOrderOralDietTextureComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :modifier, class_name:'FHIR::CodeableConcept'
            embeds_one :foodType, class_name:'FHIR::CodeableConcept'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec oralDiet
        class NutritionOrderOralDietComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_many :fhirType, class_name:'FHIR::CodeableConcept'
            embeds_one :scheduled, class_name:'FHIR::Timing'
            embeds_many :nutrient, class_name:'FHIR::NutritionOrder::NutritionOrderOralDietNutrientComponent'
            embeds_many :texture, class_name:'FHIR::NutritionOrder::NutritionOrderOralDietTextureComponent'
            embeds_many :fluidConsistencyType, class_name:'FHIR::CodeableConcept'
            field :instruction, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec supplement
        class NutritionOrderSupplementComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
            field :productName, type: String
            embeds_one :scheduled, class_name:'FHIR::Timing'
            embeds_one :quantity, class_name:'FHIR::Quantity'
            field :instruction, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec enteralFormula
        class NutritionOrderEnteralFormulaComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :administrationInstructions, type: String
            embeds_one :baseFormulaType, class_name:'FHIR::CodeableConcept'
            field :baseFormulaProductName, type: String
            embeds_one :scheduled, class_name:'FHIR::Timing'
            embeds_one :additiveType, class_name:'FHIR::CodeableConcept'
            field :additiveProductName, type: String
            embeds_one :caloricDensity, class_name:'FHIR::Quantity'
            embeds_one :routeofAdministration, class_name:'FHIR::CodeableConcept'
            embeds_one :quantity, class_name:'FHIR::Quantity'
            embeds_one :rate, class_name:'FHIR::Ratio'
            embeds_one :rateAdjustment, class_name:'FHIR::Quantity'
            embeds_one :maxVolumeToDeliver, class_name:'FHIR::Quantity'
        end
        
        embeds_one :patient, class_name:'FHIR::Reference'
        validates_presence_of :patient
        embeds_one :orderer, class_name:'FHIR::Reference'
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :encounter, class_name:'FHIR::Reference'
        field :dateTime, type: FHIR::PartialDateTime
        validates_presence_of :dateTime
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status], :allow_nil => true }
        embeds_many :allergyIntolerance, class_name:'FHIR::Reference'
        embeds_many :foodPreferenceModifier, class_name:'FHIR::CodeableConcept'
        embeds_many :excludeFoodModifier, class_name:'FHIR::CodeableConcept'
        embeds_one :oralDiet, class_name:'FHIR::NutritionOrder::NutritionOrderOralDietComponent'
        embeds_many :supplement, class_name:'FHIR::NutritionOrder::NutritionOrderSupplementComponent'
        embeds_one :enteralFormula, class_name:'FHIR::NutritionOrder::NutritionOrderEnteralFormulaComponent'
        track_history
    end
end
