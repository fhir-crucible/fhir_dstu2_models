module FHIR
    module Deserializer
        module Contract
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ContractSignerComponent(entry) 
                return nil unless entry
                model = FHIR::Contract::ContractSignerComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.xpath('./fhir:type').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'signature', entry.at_xpath('./fhir:signature/@value').try(:value))
                model
            end
            
            def parse_xml_entry_ContractTermComponent(entry) 
                return nil unless entry
                model = FHIR::Contract::ContractTermComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'subtype', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:subtype')))
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'text', entry.at_xpath('./fhir:text/@value').try(:value))
                set_model_data(model, 'issued', entry.at_xpath('./fhir:issued/@value').try(:value))
                set_model_data(model, 'applies', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:applies')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'unitPrice', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:unitPrice')))
                set_model_data(model, 'factor', entry.at_xpath('./fhir:factor/@value').try(:value))
                set_model_data(model, 'points', entry.at_xpath('./fhir:points/@value').try(:value))
                set_model_data(model, 'net', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:net')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'subject', entry.xpath('./fhir:subject').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'authority', entry.xpath('./fhir:authority').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'domain', entry.xpath('./fhir:domain').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'subtype', entry.xpath('./fhir:subtype').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'issued', entry.at_xpath('./fhir:issued/@value').try(:value))
                set_model_data(model, 'applies', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:applies')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'unitPrice', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:unitPrice')))
                set_model_data(model, 'factor', entry.at_xpath('./fhir:factor/@value').try(:value))
                set_model_data(model, 'points', entry.at_xpath('./fhir:points/@value').try(:value))
                set_model_data(model, 'net', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:net')))
                set_model_data(model, 'author', entry.xpath('./fhir:author').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'grantor', entry.xpath('./fhir:grantor').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'grantee', entry.xpath('./fhir:grantee').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'witness', entry.xpath('./fhir:witness').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'executor', entry.xpath('./fhir:executor').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'notary', entry.xpath('./fhir:notary').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'signer', entry.xpath('./fhir:signer').map {|e| parse_xml_entry_ContractSignerComponent(e)})
                set_model_data(model, 'term', entry.xpath('./fhir:term').map {|e| parse_xml_entry_ContractTermComponent(e)})
                set_model_data(model, 'binding', FHIR::Attachment.parse_xml_entry(entry.at_xpath('./fhir:binding')))
                set_model_data(model, 'bindingDateTime', entry.at_xpath('./fhir:bindingDateTime/@value').try(:value))
                set_model_data(model, 'friendly', entry.xpath('./fhir:friendly').map {|e| FHIR::Attachment.parse_xml_entry(e)})
                set_model_data(model, 'friendlyDateTime', entry.at_xpath('./fhir:friendlyDateTime/@value').try(:value))
                set_model_data(model, 'legal', entry.xpath('./fhir:legal').map {|e| FHIR::Attachment.parse_xml_entry(e)})
                set_model_data(model, 'legalDateTime', entry.at_xpath('./fhir:legalDateTime/@value').try(:value))
                set_model_data(model, 'rule', entry.xpath('./fhir:rule').map {|e| FHIR::Attachment.parse_xml_entry(e)})
                set_model_data(model, 'ruleDateTime', entry.at_xpath('./fhir:ruleDateTime/@value').try(:value))
                model
            end
        end
    end
end
