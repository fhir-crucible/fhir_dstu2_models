module FHIR
    module Deserializer
        module Schedule
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'fhirType', entry.xpath('./fhir:type').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'actor', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:actor')))
                set_model_data(model, 'planningHorizon', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:planningHorizon')))
                set_model_data(model, 'comment', entry.at_xpath('./fhir:comment/@value').try(:value))
                set_model_data(model, 'lastModified', entry.at_xpath('./fhir:lastModified/@value').try(:value))
                model
            end
        end
    end
end
