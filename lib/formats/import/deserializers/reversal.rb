module FHIR
    module Deserializer
        module Reversal
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_PayeeComponent(entry) 
                return nil unless entry
                model = FHIR::Reversal::PayeeComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'provider', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:provider')))
                set_model_data(model, 'organization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:organization')))
                set_model_data(model, 'person', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:person')))
                model
            end
            
            def parse_xml_entry_ReversalCoverageComponent(entry) 
                return nil unless entry
                model = FHIR::Reversal::ReversalCoverageComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'sequence', entry.at_xpath('./fhir:sequence/@value').try(:value))
                set_model_data(model, 'focal', entry.at_xpath('./fhir:focal/@value').try(:value))
                set_model_data(model, 'coverage', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:coverage')))
                set_model_data(model, 'businessArrangement', entry.at_xpath('./fhir:businessArrangement/@value').try(:value))
                set_model_data(model, 'relationship', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:relationship')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'ruleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:ruleset')))
                set_model_data(model, 'originalRuleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:originalRuleset')))
                set_model_data(model, 'created', entry.at_xpath('./fhir:created/@value').try(:value))
                set_model_data(model, 'target', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:target')))
                set_model_data(model, 'provider', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:provider')))
                set_model_data(model, 'organization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:organization')))
                set_model_data(model, 'request', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:request')))
                set_model_data(model, 'response', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:response')))
                set_model_data(model, 'payee', parse_xml_entry_PayeeComponent(entry.at_xpath('./fhir:payee')))
                set_model_data(model, 'coverage', parse_xml_entry_ReversalCoverageComponent(entry.at_xpath('./fhir:coverage')))
                set_model_data(model, 'nullify', entry.at_xpath('./fhir:nullify/@value').try(:value))
                model
            end
        end
    end
end
