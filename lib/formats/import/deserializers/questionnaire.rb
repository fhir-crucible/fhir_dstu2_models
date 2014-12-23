module FHIR
    module Deserializer
        module Questionnaire
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_QuestionComponent(entry) 
                return nil unless entry
                model = FHIR::Questionnaire::QuestionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'linkId', entry.at_xpath('./fhir:linkId/@value').try(:value))
                set_model_data(model, 'concept', entry.xpath('./fhir:concept').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'text', entry.at_xpath('./fhir:text/@value').try(:value))
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'required', entry.at_xpath('./fhir:required/@value').try(:value))
                set_model_data(model, 'repeats', entry.at_xpath('./fhir:repeats/@value').try(:value))
                set_model_data(model, 'options', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:options')))
                set_model_data(model, 'group', entry.xpath('./fhir:group').map {|e| parse_xml_entry_GroupComponent(e)})
                model
            end
            
            def parse_xml_entry_GroupComponent(entry) 
                return nil unless entry
                model = FHIR::Questionnaire::GroupComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'linkId', entry.at_xpath('./fhir:linkId/@value').try(:value))
                set_model_data(model, 'title', entry.at_xpath('./fhir:title/@value').try(:value))
                set_model_data(model, 'concept', entry.xpath('./fhir:concept').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'text', entry.at_xpath('./fhir:text/@value').try(:value))
                set_model_data(model, 'required', entry.at_xpath('./fhir:required/@value').try(:value))
                set_model_data(model, 'repeats', entry.at_xpath('./fhir:repeats/@value').try(:value))
                set_model_data(model, 'group', entry.xpath('./fhir:group').map {|e| parse_xml_entry_GroupComponent(e)})
                set_model_data(model, 'question', entry.xpath('./fhir:question').map {|e| parse_xml_entry_QuestionComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'versionNum', entry.at_xpath('./fhir:version/@value').try(:value))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'publisher', entry.at_xpath('./fhir:publisher/@value').try(:value))
                set_model_data(model, 'group', parse_xml_entry_GroupComponent(entry.at_xpath('./fhir:group')))
                model
            end
        end
    end
end
