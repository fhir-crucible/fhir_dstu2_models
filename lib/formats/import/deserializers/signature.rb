module FHIR
    module Deserializer
        module Signature
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.xpath('./fhir:type').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'when', entry.at_xpath('./fhir:when/@value').try(:value))
                set_model_data(model, 'whoUri', entry.at_xpath('./fhir:whoUri/@value').try(:value))
                set_model_data(model, 'whoReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:whoReference')))
                set_model_data(model, 'blob', entry.at_xpath('./fhir:blob/@value').try(:value))
                model
            end
        end
    end
end
