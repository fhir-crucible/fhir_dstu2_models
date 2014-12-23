module FHIR
    module Deserializer
        module Range
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'low', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:low')))
                set_model_data(model, 'high', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:high')))
                model
            end
        end
    end
end
