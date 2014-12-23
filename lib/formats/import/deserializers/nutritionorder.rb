module FHIR
    module Deserializer
        module NutritionOrder
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_NutritionOrderItemOralDietNutrientsComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderItemOralDietNutrientsComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'modifier', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:modifier')))
                set_model_data(model, 'amountQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:amountQuantity')))
                set_model_data(model, 'amountRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:amountRange')))
                model
            end
            
            def parse_xml_entry_NutritionOrderItemOralDietTextureComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderItemOralDietTextureComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'modifier', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:modifier')))
                set_model_data(model, 'foodType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:foodType')))
                model
            end
            
            def parse_xml_entry_NutritionOrderItemOralDietComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderItemOralDietComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.xpath('./fhir:type').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'nutrients', entry.xpath('./fhir:nutrients').map {|e| parse_xml_entry_NutritionOrderItemOralDietNutrientsComponent(e)})
                set_model_data(model, 'texture', entry.xpath('./fhir:texture').map {|e| parse_xml_entry_NutritionOrderItemOralDietTextureComponent(e)})
                set_model_data(model, 'fluidConsistencyType', entry.xpath('./fhir:fluidConsistencyType').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'instruction', entry.at_xpath('./fhir:instruction/@value').try(:value))
                model
            end
            
            def parse_xml_entry_NutritionOrderItemSupplementComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderItemSupplementComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                model
            end
            
            def parse_xml_entry_NutritionOrderItemEnteralFormulaComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderItemEnteralFormulaComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'administrationInstructions', entry.at_xpath('./fhir:administrationInstructions/@value').try(:value))
                set_model_data(model, 'baseFormulaType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:baseFormulaType')))
                set_model_data(model, 'baseFormulaName', entry.at_xpath('./fhir:baseFormulaName/@value').try(:value))
                set_model_data(model, 'additiveType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:additiveType')))
                set_model_data(model, 'additiveName', entry.at_xpath('./fhir:additiveName/@value').try(:value))
                set_model_data(model, 'caloricDensity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:caloricDensity')))
                set_model_data(model, 'routeofAdministration', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:routeofAdministration')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'rate', FHIR::Ratio.parse_xml_entry(entry.at_xpath('./fhir:rate')))
                set_model_data(model, 'rateAdjustment', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:rateAdjustment')))
                set_model_data(model, 'maxVolumeToDeliver', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:maxVolumeToDeliver')))
                model
            end
            
            def parse_xml_entry_NutritionOrderItemComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderItemComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'scheduledTiming', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:scheduledTiming')))
                set_model_data(model, 'scheduledPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:scheduledPeriod')))
                set_model_data(model, 'isInEffect', entry.at_xpath('./fhir:isInEffect/@value').try(:value))
                set_model_data(model, 'oralDiet', parse_xml_entry_NutritionOrderItemOralDietComponent(entry.at_xpath('./fhir:oralDiet')))
                set_model_data(model, 'supplement', parse_xml_entry_NutritionOrderItemSupplementComponent(entry.at_xpath('./fhir:supplement')))
                set_model_data(model, 'enteralFormula', parse_xml_entry_NutritionOrderItemEnteralFormulaComponent(entry.at_xpath('./fhir:enteralFormula')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'orderer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:orderer')))
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'dateTime', entry.at_xpath('./fhir:dateTime/@value').try(:value))
                set_model_data(model, 'allergyIntolerance', entry.xpath('./fhir:allergyIntolerance').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'foodPreferenceModifier', entry.xpath('./fhir:foodPreferenceModifier').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'excludeFoodModifier', entry.xpath('./fhir:excludeFoodModifier').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'item', entry.xpath('./fhir:item').map {|e| parse_xml_entry_NutritionOrderItemComponent(e)})
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                model
            end
        end
    end
end
