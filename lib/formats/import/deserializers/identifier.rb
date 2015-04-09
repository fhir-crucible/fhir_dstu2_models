module FHIR
    module Deserializer
        module Identifier
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'use', entry.at_xpath('./fhir:use/@value').try(:value))
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'system', entry.at_xpath('./fhir:system/@value').try(:value))
                set_model_data(model, 'value', entry.at_xpath('./fhir:value/@value').try(:value))
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                set_model_data(model, 'assigner', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:assigner')))
                model
            end
        end
    end
end
