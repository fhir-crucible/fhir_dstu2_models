module FHIR
    module Deserializer
        module Reference
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'reference', entry.at_xpath('./fhir:reference/@value').try(:value))
                set_model_data(model, 'display', entry.at_xpath('./fhir:display/@value').try(:value))
                model
            end
        end
    end
end
