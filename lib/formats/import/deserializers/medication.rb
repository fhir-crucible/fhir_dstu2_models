module FHIR
    module Deserializer
        module Medication
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_MedicationProductIngredientComponent(entry) 
                return nil unless entry
                model = FHIR::Medication::MedicationProductIngredientComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'item', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:item')))
                set_model_data(model, 'amount', FHIR::Ratio.parse_xml_entry(entry.at_xpath('./fhir:amount')))
                model
            end
            
            def parse_xml_entry_MedicationProductComponent(entry) 
                return nil unless entry
                model = FHIR::Medication::MedicationProductComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'form', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:form')))
                set_model_data(model, 'ingredient', entry.xpath('./fhir:ingredient').map {|e| parse_xml_entry_MedicationProductIngredientComponent(e)})
                model
            end
            
            def parse_xml_entry_MedicationPackageContentComponent(entry) 
                return nil unless entry
                model = FHIR::Medication::MedicationPackageContentComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'item', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:item')))
                set_model_data(model, 'amount', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:amount')))
                model
            end
            
            def parse_xml_entry_MedicationPackageComponent(entry) 
                return nil unless entry
                model = FHIR::Medication::MedicationPackageComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'container', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:container')))
                set_model_data(model, 'content', entry.xpath('./fhir:content').map {|e| parse_xml_entry_MedicationPackageContentComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'isBrand', entry.at_xpath('./fhir:isBrand/@value').try(:value))
                set_model_data(model, 'manufacturer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:manufacturer')))
                set_model_data(model, 'kind', entry.at_xpath('./fhir:kind/@value').try(:value))
                set_model_data(model, 'product', parse_xml_entry_MedicationProductComponent(entry.at_xpath('./fhir:product')))
                set_model_data(model, 'package', parse_xml_entry_MedicationPackageComponent(entry.at_xpath('./fhir:package')))
                model
            end
        end
    end
end
