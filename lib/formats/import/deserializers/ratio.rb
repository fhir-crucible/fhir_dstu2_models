module FHIR
    module Deserializer
        module Ratio
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'numerator', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:numerator')))
                set_model_data(model, 'denominator', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:denominator')))
                model
            end
        end
    end
end
