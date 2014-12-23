module FHIR
    module Deserializer
        module Substance
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_SubstanceInstanceComponent(entry) 
                return nil unless entry
                model = FHIR::Substance::SubstanceInstanceComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'expiry', entry.at_xpath('./fhir:expiry/@value').try(:value))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                model
            end
            
            def parse_xml_entry_SubstanceIngredientComponent(entry) 
                return nil unless entry
                model = FHIR::Substance::SubstanceIngredientComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'quantity', FHIR::Ratio.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'substance', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:substance')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'instance', parse_xml_entry_SubstanceInstanceComponent(entry.at_xpath('./fhir:instance')))
                set_model_data(model, 'ingredient', entry.xpath('./fhir:ingredient').map {|e| parse_xml_entry_SubstanceIngredientComponent(e)})
                model
            end
        end
    end
end
