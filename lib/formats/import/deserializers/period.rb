module FHIR
    module Deserializer
        module Period
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'start', entry.at_xpath('./fhir:start/@value').try(:value))
                set_model_data(model, 'end', entry.at_xpath('./fhir:end/@value').try(:value))
                model
            end
        end
    end
end
