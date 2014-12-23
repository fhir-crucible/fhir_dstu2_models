module FHIR
    module Deserializer
        module CodeableConcept
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'coding', entry.xpath('./fhir:coding').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'text', entry.at_xpath('./fhir:text/@value').try(:value))
                model
            end
        end
    end
end
