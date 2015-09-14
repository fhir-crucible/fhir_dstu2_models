module FHIR
    module Deserializer
        module QuestionnaireResponse
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_QuestionAnswerComponent(entry) 
                return nil unless entry
                model = FHIR::QuestionnaireResponse::QuestionAnswerComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'valueBoolean','valueBoolean',false)
                parse_primitive_field(model,entry,'valueDecimal','valueDecimal',false)
                parse_primitive_field(model,entry,'valueInteger','valueInteger',false)
                parse_primitive_field(model,entry,'valueDate','valueDate',false)
                parse_primitive_field(model,entry,'valueDateTime','valueDateTime',false)
                parse_primitive_field(model,entry,'valueInstant','valueInstant',false)
                parse_primitive_field(model,entry,'valueTime','valueTime',false)
                parse_primitive_field(model,entry,'valueString','valueString',false)
                parse_primitive_field(model,entry,'valueUri','valueUri',false)
                set_model_data(model, 'valueAttachment', FHIR::Attachment.parse_xml_entry(entry.at_xpath('./fhir:valueAttachment')))
                set_model_data(model, 'valueCoding', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:valueCoding')))
                set_model_data(model, 'valueQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:valueQuantity')))
                set_model_data(model, 'valueReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:valueReference')))
                set_model_data(model, 'group', entry.xpath('./fhir:group').map {|e| parse_xml_entry_GroupComponent(e)})
                model
            end
            
            def parse_xml_entry_QuestionComponent(entry) 
                return nil unless entry
                model = FHIR::QuestionnaireResponse::QuestionComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'linkId','linkId',false)
                parse_primitive_field(model,entry,'text','text',false)
                set_model_data(model, 'answer', entry.xpath('./fhir:answer').map {|e| parse_xml_entry_QuestionAnswerComponent(e)})
                model
            end
            
            def parse_xml_entry_GroupComponent(entry) 
                return nil unless entry
                model = FHIR::QuestionnaireResponse::GroupComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'linkId','linkId',false)
                parse_primitive_field(model,entry,'title','title',false)
                parse_primitive_field(model,entry,'text','text',false)
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
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'author', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:author')))
                parse_primitive_field(model,entry,'authored','authored',false)
                set_model_data(model, 'source', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:source')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'group', parse_xml_entry_GroupComponent(entry.at_xpath('./fhir:group')))
                model
            end
        end
    end
end
