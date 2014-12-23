module FHIR
    module Deserializer
        module OperationOutcome
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_OperationOutcomeIssueComponent(entry) 
                return nil unless entry
                model = FHIR::OperationOutcome::OperationOutcomeIssueComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'severity', entry.at_xpath('./fhir:severity/@value').try(:value))
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'details', entry.at_xpath('./fhir:details/@value').try(:value))
                set_model_data(model, 'location', entry.xpath('./fhir:location/@value').map {|e| e.value })
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'issue', entry.xpath('./fhir:issue').map {|e| parse_xml_entry_OperationOutcomeIssueComponent(e)})
                model
            end
        end
    end
end
