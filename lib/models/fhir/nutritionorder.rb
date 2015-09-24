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
            foodPreferenceModifier: [ 'vegetarian', 'dairy-free', 'nut-free', 'gluten-free', 'vegan', 'halal', 'kosher' ],
            status: [ 'proposed', 'draft', 'planned', 'requested', 'active', 'on-hold', 'completed', 'cancelled' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec nutrient
        class NutritionOrderOralDietNutrientComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirModifier: [ '33463005', '39972003', '88480006' ]
            }
            
            embeds_one :fhirModifier, class_name:'FHIR::CodeableConcept'
            embeds_one :amount, class_name:'FHIR::Quantity'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec texture
        class NutritionOrderOralDietTextureComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirModifier: [ '228053002', '439091000124107', '228049004', '441881000124103', '441761000124103', '441751000124100', '228059003', '441791000124106', '228055009', '228056005', '441771000124105', '228057001', '228058006', '228060008' ],
                foodType: [ '255620007', '28647000', '22836000', '72511004', '226760005', '226887002', '102263004', '74242007', '227415002', '264331002', '227518002', '44027008', '226529007', '227210005' ]
            }
            
            embeds_one :fhirModifier, class_name:'FHIR::CodeableConcept'
            embeds_one :foodType, class_name:'FHIR::CodeableConcept'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec oralDiet
        class NutritionOrderOralDietComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fluidConsistencyType: [ '439031000124108', '439021000124105', '439041000124103', '439081000124109' ]
            }
            
            embeds_many :fhirType, class_name:'FHIR::CodeableConcept'
            embeds_many :schedule, class_name:'FHIR::Timing'
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
            
            VALID_CODES = {
                fhirType: [ '442901000124106', '443031000124106', '443051000124104', '442911000124109', '443021000124108', '442971000124100', '442981000124102', '442991000124104', '443011000124100', '442961000124107', '442951000124105', '442941000124108', '442921000124101', '442931000124103', '444331000124106', '443361000124100', '443391000124108', '443401000124105', '443491000124103', '443501000124106', '443421000124100', '443471000124104', '444431000124104', '443451000124109', '444321000124108', '441561000124106', '443461000124106', '441531000124102', '443561000124107', '443481000124101', '441571000124104', '441591000124103', '441601000124106', '443351000124102', '443771000124106', '441671000124100', '443111000124101', '443431000124102', '443411000124108', '444361000124102', '444401000124107', '444381000124107', '444371000124109', '443441000124107', '442651000124102' ]
            }
            
            embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
            field :productName, type: String
            embeds_many :schedule, class_name:'FHIR::Timing'
            embeds_one :quantity, class_name:'FHIR::Quantity'
            field :instruction, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec administration
        class NutritionOrderEnteralFormulaAdministrationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            MULTIPLE_TYPES = {
                rate: [ 'rateQuantity', 'rateRatio' ]
            }
            
            embeds_one :schedule, class_name:'FHIR::Timing'
            embeds_one :quantity, class_name:'FHIR::Quantity'
            embeds_one :rateQuantity, class_name:'FHIR::Quantity'
            embeds_one :rateRatio, class_name:'FHIR::Ratio'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec enteralFormula
        class NutritionOrderEnteralFormulaComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                additiveType: [ 'lipid', 'protein', 'carbohydrate', 'fiber', 'water' ],
                baseFormulaType: [ '443031000124106', '443051000124104', '442911000124109', '443021000124108', '442971000124100', '442981000124102', '442991000124104', '443011000124100', '442961000124107', '442951000124105', '442941000124108', '442921000124101', '442931000124103', '443361000124100', '443401000124105', '443491000124103', '443501000124106', '443421000124100', '443471000124104', '444431000124104', '443451000124109', '441561000124106', '443461000124106', '441531000124102', '443561000124107', '443481000124101', '441571000124104', '441591000124103', '441601000124106', '443351000124102', '443771000124106', '441671000124100', '443111000124101', '443431000124102', '443411000124108', '442651000124102' ],
                routeofAdministration: [ 'PO', 'EFT', 'ENTINSTL', 'GT', 'NGT', 'OGT', 'GJT', 'JJTINSTL', 'OJJ' ]
            }
            
            embeds_one :baseFormulaType, class_name:'FHIR::CodeableConcept'
            field :baseFormulaProductName, type: String
            embeds_one :additiveType, class_name:'FHIR::CodeableConcept'
            field :additiveProductName, type: String
            embeds_one :caloricDensity, class_name:'FHIR::Quantity'
            embeds_one :routeofAdministration, class_name:'FHIR::CodeableConcept'
            embeds_many :administration, class_name:'FHIR::NutritionOrder::NutritionOrderEnteralFormulaAdministrationComponent'
            embeds_one :maxVolumeToDeliver, class_name:'FHIR::Quantity'
            field :administrationInstruction, type: String
        end
        
        embeds_one :patient, class_name:'FHIR::Reference'
        validates_presence_of :patient
        embeds_one :orderer, class_name:'FHIR::Reference'
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :encounter, class_name:'FHIR::Reference'
        field :dateTime, type: String
        validates :dateTime, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
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
