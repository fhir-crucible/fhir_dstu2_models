module FHIR
    module Deserializer
        module Attachment
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'contentType', entry.at_xpath('./fhir:contentType/@value').try(:value))
                set_model_data(model, 'language', entry.at_xpath('./fhir:language/@value').try(:value))
                set_model_data(model, 'data', entry.at_xpath('./fhir:data/@value').try(:value))
                set_model_data(model, 'url', entry.at_xpath('./fhir:url/@value').try(:value))
                set_model_data(model, 'size', entry.at_xpath('./fhir:size/@value').try(:value))
                set_model_data(model, 'fhirHash', entry.at_xpath('./fhir:hash/@value').try(:value))
                set_model_data(model, 'title', entry.at_xpath('./fhir:title/@value').try(:value))
                model
            end
        end
    end
end
