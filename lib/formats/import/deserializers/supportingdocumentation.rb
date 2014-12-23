module FHIR
    module Deserializer
        module SupportingDocumentation
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_SupportingDocumentationDetailComponent(entry) 
                return nil unless entry
                model = FHIR::SupportingDocumentation::SupportingDocumentationDetailComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'linkId', entry.at_xpath('./fhir:linkId/@value').try(:value))
                set_model_data(model, 'contentReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:contentReference')))
                set_model_data(model, 'contentAttachment', FHIR::Attachment.parse_xml_entry(entry.at_xpath('./fhir:contentAttachment')))
                set_model_data(model, 'dateTime', entry.at_xpath('./fhir:dateTime/@value').try(:value))
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
                set_model_data(model, 'author', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:author')))
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'detail', entry.xpath('./fhir:detail').map {|e| parse_xml_entry_SupportingDocumentationDetailComponent(e)})
                model
            end
        end
    end
end
