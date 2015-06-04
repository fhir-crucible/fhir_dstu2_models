module FHIR
    module Deserializer
        module QuestionnaireAnswers
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_QuestionAnswerComponent(entry) 
                return nil unless entry
                model = FHIR::QuestionnaireAnswers::QuestionAnswerComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'valueBoolean', entry.at_xpath('./fhir:valueBoolean/@value').try(:value))
                set_model_data(model, 'valueDecimal', entry.at_xpath('./fhir:valueDecimal/@value').try(:value))
                set_model_data(model, 'valueInteger', entry.at_xpath('./fhir:valueInteger/@value').try(:value))
                set_model_data(model, 'valueDate', entry.at_xpath('./fhir:valueDate/@value').try(:value))
                set_model_data(model, 'valueDateTime', entry.at_xpath('./fhir:valueDateTime/@value').try(:value))
                set_model_data(model, 'valueInstant', entry.at_xpath('./fhir:valueInstant/@value').try(:value))
                set_model_data(model, 'valueTime', entry.at_xpath('./fhir:valueTime/@value').try(:value))
                set_model_data(model, 'valueString', entry.at_xpath('./fhir:valueString/@value').try(:value))
                set_model_data(model, 'valueUri', entry.at_xpath('./fhir:valueUri/@value').try(:value))
                set_model_data(model, 'valueAttachment', FHIR::Attachment.parse_xml_entry(entry.at_xpath('./fhir:valueAttachment')))
                set_model_data(model, 'valueCoding', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:valueCoding')))
                set_model_data(model, 'valueQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:valueQuantity')))
                set_model_data(model, 'valueReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:valueReference')))
                model
            end
            
            def parse_xml_entry_QuestionComponent(entry) 
                return nil unless entry
                model = FHIR::QuestionnaireAnswers::QuestionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'linkId', entry.at_xpath('./fhir:linkId/@value').try(:value))
                set_model_data(model, 'text', entry.at_xpath('./fhir:text/@value').try(:value))
                set_model_data(model, 'answer', entry.xpath('./fhir:answer').map {|e| parse_xml_entry_QuestionAnswerComponent(e)})
                set_model_data(model, 'group', entry.xpath('./fhir:group').map {|e| parse_xml_entry_GroupComponent(e)})
                model
            end
            
            def parse_xml_entry_GroupComponent(entry) 
                return nil unless entry
                model = FHIR::QuestionnaireAnswers::GroupComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'linkId', entry.at_xpath('./fhir:linkId/@value').try(:value))
                set_model_data(model, 'title', entry.at_xpath('./fhir:title/@value').try(:value))
                set_model_data(model, 'text', entry.at_xpath('./fhir:text/@value').try(:value))
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'group', entry.xpath('./fhir:group').map {|e| parse_xml_entry_GroupComponent(e)})
                set_model_data(model, 'question', entry.xpath('./fhir:question').map {|e| parse_xml_entry_QuestionComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'questionnaire', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:questionnaire')))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'author', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:author')))
                set_model_data(model, 'authored', entry.at_xpath('./fhir:authored/@value').try(:value))
                set_model_data(model, 'source', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:source')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'group', parse_xml_entry_GroupComponent(entry.at_xpath('./fhir:group')))
                model
            end
        end
    end
end
