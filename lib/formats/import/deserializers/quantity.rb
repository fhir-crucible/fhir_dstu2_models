module FHIR
    module Deserializer
        module Quantity
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'value', entry.at_xpath('./fhir:value/@value').try(:value))
                set_model_data(model, 'comparator', entry.at_xpath('./fhir:comparator/@value').try(:value))
                set_model_data(model, 'units', entry.at_xpath('./fhir:units/@value').try(:value))
                set_model_data(model, 'system', entry.at_xpath('./fhir:system/@value').try(:value))
                set_model_data(model, 'code', entry.at_xpath('./fhir:code/@value').try(:value))
                model
            end
        end
    end
end
