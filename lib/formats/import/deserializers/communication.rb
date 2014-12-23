module FHIR
    module Deserializer
        module Communication
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_CommunicationPayloadComponent(entry) 
                return nil unless entry
                model = FHIR::Communication::CommunicationPayloadComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'contentString', entry.at_xpath('./fhir:contentString/@value').try(:value))
                set_model_data(model, 'contentAttachment', FHIR::Attachment.parse_xml_entry(entry.at_xpath('./fhir:contentAttachment')))
                set_model_data(model, 'contentReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:contentReference')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'category', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:category')))
                set_model_data(model, 'sender', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:sender')))
                set_model_data(model, 'recipient', entry.xpath('./fhir:recipient').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'payload', entry.xpath('./fhir:payload').map {|e| parse_xml_entry_CommunicationPayloadComponent(e)})
                set_model_data(model, 'medium', entry.xpath('./fhir:medium').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'sent', entry.at_xpath('./fhir:sent/@value').try(:value))
                set_model_data(model, 'received', entry.at_xpath('./fhir:received/@value').try(:value))
                set_model_data(model, 'reason', entry.xpath('./fhir:reason').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                model
            end
        end
    end
end
