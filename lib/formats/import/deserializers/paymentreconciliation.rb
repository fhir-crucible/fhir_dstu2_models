module FHIR
    module Deserializer
        module PaymentReconciliation
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_DetailsComponent(entry) 
                return nil unless entry
                model = FHIR::PaymentReconciliation::DetailsComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'request', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:request')))
                set_model_data(model, 'responce', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:responce')))
                set_model_data(model, 'submitter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:submitter')))
                set_model_data(model, 'payee', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:payee')))
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'amount', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:amount')))
                model
            end
            
            def parse_xml_entry_NotesComponent(entry) 
                return nil unless entry
                model = FHIR::PaymentReconciliation::NotesComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'text', entry.at_xpath('./fhir:text/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'request', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:request')))
                set_model_data(model, 'outcome', entry.at_xpath('./fhir:outcome/@value').try(:value))
                set_model_data(model, 'disposition', entry.at_xpath('./fhir:disposition/@value').try(:value))
                set_model_data(model, 'ruleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:ruleset')))
                set_model_data(model, 'originalRuleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:originalRuleset')))
                set_model_data(model, 'created', entry.at_xpath('./fhir:created/@value').try(:value))
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                set_model_data(model, 'organization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:organization')))
                set_model_data(model, 'requestProvider', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:requestProvider')))
                set_model_data(model, 'requestOrganization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:requestOrganization')))
                set_model_data(model, 'detail', entry.xpath('./fhir:detail').map {|e| parse_xml_entry_DetailsComponent(e)})
                set_model_data(model, 'form', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:form')))
                set_model_data(model, 'total', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:total')))
                set_model_data(model, 'note', entry.xpath('./fhir:note').map {|e| parse_xml_entry_NotesComponent(e)})
                model
            end
        end
    end
end
