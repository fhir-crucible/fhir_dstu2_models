module FHIR
    module Deserializer
        module Contract
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ActorComponent(entry) 
                return nil unless entry
                model = FHIR::Contract::ActorComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'entity', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:entity')))
                set_model_data(model, 'role', entry.xpath('./fhir:role').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_ValuedItemComponent(entry) 
                return nil unless entry
                model = FHIR::Contract::ValuedItemComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'entityCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:entityCodeableConcept')))
                set_model_data(model, 'entityReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:entityReference')))
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'effectiveTime', entry.at_xpath('./fhir:effectiveTime/@value').try(:value))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'unitPrice', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:unitPrice')))
                set_model_data(model, 'factor', entry.at_xpath('./fhir:factor/@value').try(:value))
                set_model_data(model, 'points', entry.at_xpath('./fhir:points/@value').try(:value))
                set_model_data(model, 'net', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:net')))
                model
            end
            
            def parse_xml_entry_SignatoryComponent(entry) 
                return nil unless entry
                model = FHIR::Contract::SignatoryComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'party', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:party')))
                set_model_data(model, 'signature', entry.at_xpath('./fhir:signature/@value').try(:value))
                model
            end
            
            def parse_xml_entry_TermActorComponent(entry) 
                return nil unless entry
                model = FHIR::Contract::TermActorComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'entity', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:entity')))
                set_model_data(model, 'role', entry.xpath('./fhir:role').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_TermValuedItemComponent(entry) 
                return nil unless entry
                model = FHIR::Contract::TermValuedItemComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'entityCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:entityCodeableConcept')))
                set_model_data(model, 'entityReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:entityReference')))
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'effectiveTime', entry.at_xpath('./fhir:effectiveTime/@value').try(:value))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'unitPrice', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:unitPrice')))
                set_model_data(model, 'factor', entry.at_xpath('./fhir:factor/@value').try(:value))
                set_model_data(model, 'points', entry.at_xpath('./fhir:points/@value').try(:value))
                set_model_data(model, 'net', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:net')))
                model
            end
            
            def parse_xml_entry_TermComponent(entry) 
                return nil unless entry
                model = FHIR::Contract::TermComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'issued', entry.at_xpath('./fhir:issued/@value').try(:value))
                set_model_data(model, 'applies', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:applies')))
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'subType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:subType')))
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'action', entry.xpath('./fhir:action').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'actionReason', entry.xpath('./fhir:actionReason').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'actor', entry.xpath('./fhir:actor').map {|e| parse_xml_entry_TermActorComponent(e)})
                set_model_data(model, 'text', entry.at_xpath('./fhir:text/@value').try(:value))
                set_model_data(model, 'valuedItem', entry.xpath('./fhir:valuedItem').map {|e| parse_xml_entry_TermValuedItemComponent(e)})
                set_model_data(model, 'group', entry.xpath('./fhir:group').map {|e| parse_xml_entry_TermComponent(e)})
                model
            end
            
            def parse_xml_entry_FriendlyLanguageComponent(entry) 
                return nil unless entry
                model = FHIR::Contract::FriendlyLanguageComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'contentAttachment', FHIR::Attachment.parse_xml_entry(entry.at_xpath('./fhir:contentAttachment')))
                set_model_data(model, 'contentReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:contentReference')))
                model
            end
            
            def parse_xml_entry_LegalLanguageComponent(entry) 
                return nil unless entry
                model = FHIR::Contract::LegalLanguageComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'contentAttachment', FHIR::Attachment.parse_xml_entry(entry.at_xpath('./fhir:contentAttachment')))
                set_model_data(model, 'contentReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:contentReference')))
                model
            end
            
            def parse_xml_entry_ComputableLanguageComponent(entry) 
                return nil unless entry
                model = FHIR::Contract::ComputableLanguageComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'contentAttachment', FHIR::Attachment.parse_xml_entry(entry.at_xpath('./fhir:contentAttachment')))
                set_model_data(model, 'contentReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:contentReference')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'issued', entry.at_xpath('./fhir:issued/@value').try(:value))
                set_model_data(model, 'applies', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:applies')))
                set_model_data(model, 'subject', entry.xpath('./fhir:subject').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'authority', entry.xpath('./fhir:authority').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'domain', entry.xpath('./fhir:domain').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'subType', entry.xpath('./fhir:subType').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'action', entry.xpath('./fhir:action').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'actionReason', entry.xpath('./fhir:actionReason').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'actor', entry.xpath('./fhir:actor').map {|e| parse_xml_entry_ActorComponent(e)})
                set_model_data(model, 'valuedItem', entry.xpath('./fhir:valuedItem').map {|e| parse_xml_entry_ValuedItemComponent(e)})
                set_model_data(model, 'signer', entry.xpath('./fhir:signer').map {|e| parse_xml_entry_SignatoryComponent(e)})
                set_model_data(model, 'term', entry.xpath('./fhir:term').map {|e| parse_xml_entry_TermComponent(e)})
                set_model_data(model, 'bindingAttachment', FHIR::Attachment.parse_xml_entry(entry.at_xpath('./fhir:bindingAttachment')))
                set_model_data(model, 'bindingReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:bindingReference')))
                set_model_data(model, 'friendly', entry.xpath('./fhir:friendly').map {|e| parse_xml_entry_FriendlyLanguageComponent(e)})
                set_model_data(model, 'legal', entry.xpath('./fhir:legal').map {|e| parse_xml_entry_LegalLanguageComponent(e)})
                set_model_data(model, 'rule', entry.xpath('./fhir:rule').map {|e| parse_xml_entry_ComputableLanguageComponent(e)})
                model
            end
        end
    end
end
