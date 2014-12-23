module FHIR
    module Deserializer
        module SampledData
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'origin', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:origin')))
                set_model_data(model, 'period', entry.at_xpath('./fhir:period/@value').try(:value))
                set_model_data(model, 'factor', entry.at_xpath('./fhir:factor/@value').try(:value))
                set_model_data(model, 'lowerLimit', entry.at_xpath('./fhir:lowerLimit/@value').try(:value))
                set_model_data(model, 'upperLimit', entry.at_xpath('./fhir:upperLimit/@value').try(:value))
                set_model_data(model, 'dimensions', entry.at_xpath('./fhir:dimensions/@value').try(:value))
                set_model_data(model, 'data', entry.at_xpath('./fhir:data/@value').try(:value))
                model
            end
        end
    end
end
