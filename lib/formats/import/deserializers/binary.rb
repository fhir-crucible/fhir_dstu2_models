module FHIR
    module Deserializer
        module Binary
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'contentType', entry.at_xpath('./fhir:contentType/@value').try(:value))
                set_model_data(model, 'content', entry.at_xpath('./fhir:content/@value').try(:value))
                model
            end
        end
    end
end
