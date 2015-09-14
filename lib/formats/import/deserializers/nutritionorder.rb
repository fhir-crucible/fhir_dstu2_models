module FHIR
    module Deserializer
        module NutritionOrder
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_NutritionOrderOralDietNutrientComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderOralDietNutrientComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirModifier', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:modifier')))
                set_model_data(model, 'amount', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:amount')))
                model
            end
            
            def parse_xml_entry_NutritionOrderOralDietTextureComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderOralDietTextureComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirModifier', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:modifier')))
                set_model_data(model, 'foodType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:foodType')))
                model
            end
            
            def parse_xml_entry_NutritionOrderOralDietComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderOralDietComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.xpath('./fhir:type').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'schedule', entry.xpath('./fhir:schedule').map {|e| FHIR::Timing.parse_xml_entry(e)})
                set_model_data(model, 'nutrient', entry.xpath('./fhir:nutrient').map {|e| parse_xml_entry_NutritionOrderOralDietNutrientComponent(e)})
                set_model_data(model, 'texture', entry.xpath('./fhir:texture').map {|e| parse_xml_entry_NutritionOrderOralDietTextureComponent(e)})
                set_model_data(model, 'fluidConsistencyType', entry.xpath('./fhir:fluidConsistencyType').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'instruction','instruction',false)
                model
            end
            
            def parse_xml_entry_NutritionOrderSupplementComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderSupplementComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                parse_primitive_field(model,entry,'productName','productName',false)
                set_model_data(model, 'schedule', entry.xpath('./fhir:schedule').map {|e| FHIR::Timing.parse_xml_entry(e)})
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                parse_primitive_field(model,entry,'instruction','instruction',false)
                model
            end
            
            def parse_xml_entry_NutritionOrderEnteralFormulaAdministrationComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderEnteralFormulaAdministrationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'schedule', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:schedule')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'rateQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:rateQuantity')))
                set_model_data(model, 'rateRatio', FHIR::Ratio.parse_xml_entry(entry.at_xpath('./fhir:rateRatio')))
                model
            end
            
            def parse_xml_entry_NutritionOrderEnteralFormulaComponent(entry) 
                return nil unless entry
                model = FHIR::NutritionOrder::NutritionOrderEnteralFormulaComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'baseFormulaType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:baseFormulaType')))
                parse_primitive_field(model,entry,'baseFormulaProductName','baseFormulaProductName',false)
                set_model_data(model, 'additiveType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:additiveType')))
                parse_primitive_field(model,entry,'additiveProductName','additiveProductName',false)
                set_model_data(model, 'caloricDensity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:caloricDensity')))
                set_model_data(model, 'routeofAdministration', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:routeofAdministration')))
                set_model_data(model, 'administration', entry.xpath('./fhir:administration').map {|e| parse_xml_entry_NutritionOrderEnteralFormulaAdministrationComponent(e)})
                set_model_data(model, 'maxVolumeToDeliver', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:maxVolumeToDeliver')))
                parse_primitive_field(model,entry,'administrationInstruction','administrationInstruction',false)
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
                parse_primitive_field(model,entry,'dateTime','dateTime',false)
                parse_primitive_field(model,entry,'status','status',false)
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
