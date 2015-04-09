module FHIR
    module Deserializer
        module Coding
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'system', entry.at_xpath('./fhir:system/@value').try(:value))
                set_model_data(model, 'versionNum', entry.at_xpath('./fhir:version/@value').try(:value))
                set_model_data(model, 'code', entry.at_xpath('./fhir:code/@value').try(:value))
                set_model_data(model, 'display', entry.at_xpath('./fhir:display/@value').try(:value))
                set_model_data(model, 'primary', entry.at_xpath('./fhir:primary/@value').try(:value))
                model
            end
        end
    end
end
