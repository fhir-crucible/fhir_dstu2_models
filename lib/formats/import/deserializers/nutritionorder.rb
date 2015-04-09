module FHIR
    module Deserializer
        module NutritionOrder
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_NutritionOrderOralDietNutrientComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderOralDietNutrientComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'modifier', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:modifier')))
                set_model_data(model, 'amount', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:amount')))
                model
            end
            
            def parse_xml_entry_NutritionOrderOralDietTextureComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderOralDietTextureComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'modifier', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:modifier')))
                set_model_data(model, 'foodType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:foodType')))
                model
            end
            
            def parse_xml_entry_NutritionOrderOralDietComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderOralDietComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.xpath('./fhir:type').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'scheduled', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:scheduled')))
                set_model_data(model, 'nutrient', entry.xpath('./fhir:nutrient').map {|e| parse_xml_entry_NutritionOrderOralDietNutrientComponent(e)})
                set_model_data(model, 'texture', entry.xpath('./fhir:texture').map {|e| parse_xml_entry_NutritionOrderOralDietTextureComponent(e)})
                set_model_data(model, 'fluidConsistencyType', entry.xpath('./fhir:fluidConsistencyType').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'instruction', entry.at_xpath('./fhir:instruction/@value').try(:value))
                model
            end
            
            def parse_xml_entry_NutritionOrderSupplementComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderSupplementComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'productName', entry.at_xpath('./fhir:productName/@value').try(:value))
                set_model_data(model, 'scheduled', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:scheduled')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'instruction', entry.at_xpath('./fhir:instruction/@value').try(:value))
                model
            end
            
            def parse_xml_entry_NutritionOrderEnteralFormulaComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderEnteralFormulaComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'administrationInstructions', entry.at_xpath('./fhir:administrationInstructions/@value').try(:value))
                set_model_data(model, 'baseFormulaType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:baseFormulaType')))
                set_model_data(model, 'baseFormulaProductName', entry.at_xpath('./fhir:baseFormulaProductName/@value').try(:value))
                set_model_data(model, 'scheduled', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:scheduled')))
                set_model_data(model, 'additiveType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:additiveType')))
                set_model_data(model, 'additiveProductName', entry.at_xpath('./fhir:additiveProductName/@value').try(:value))
                set_model_data(model, 'caloricDensity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:caloricDensity')))
                set_model_data(model, 'routeofAdministration', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:routeofAdministration')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'rate', FHIR::Ratio.parse_xml_entry(entry.at_xpath('./fhir:rate')))
                set_model_data(model, 'rateAdjustment', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:rateAdjustment')))
                set_model_data(model, 'maxVolumeToDeliver', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:maxVolumeToDeliver')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'orderer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:orderer')))
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'dateTime', entry.at_xpath('./fhir:dateTime/@value').try(:value))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'allergyIntolerance', entry.xpath('./fhir:allergyIntolerance').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'foodPreferenceModifier', entry.xpath('./fhir:foodPreferenceModifier').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'excludeFoodModifier', entry.xpath('./fhir:excludeFoodModifier').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'oralDiet', parse_xml_entry_NutritionOrderOralDietComponent(entry.at_xpath('./fhir:oralDiet')))
                set_model_data(model, 'supplement', entry.xpath('./fhir:supplement').map {|e| parse_xml_entry_NutritionOrderSupplementComponent(e)})
                set_model_data(model, 'enteralFormula', parse_xml_entry_NutritionOrderEnteralFormulaComponent(entry.at_xpath('./fhir:enteralFormula')))
                model
            end
        end
    end
end
