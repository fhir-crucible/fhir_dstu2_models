module FHIR
    module Deserializer
        module OperationOutcome
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_OperationOutcomeIssueComponent(entry) 
                return nil unless entry
                model = FHIR::OperationOutcome::OperationOutcomeIssueComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'severity','severity',false)
                parse_primitive_field(model,entry,'code','code',false)
                set_model_data(model, 'details', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:details')))
                parse_primitive_field(model,entry,'diagnostics','diagnostics',false)
                parse_primitive_field(model,entry,'location','location',true)
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
