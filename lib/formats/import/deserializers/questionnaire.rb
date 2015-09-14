module FHIR
    module Deserializer
        module Questionnaire
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_QuestionComponent(entry) 
                return nil unless entry
                model = FHIR::Questionnaire::QuestionComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'linkId','linkId',false)
                set_model_data(model, 'concept', entry.xpath('./fhir:concept').map {|e| FHIR::Coding.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'text','text',false)
                parse_primitive_field(model,entry,'type','fhirType',false)
                parse_primitive_field(model,entry,'required','required',false)
                parse_primitive_field(model,entry,'repeats','repeats',false)
                set_model_data(model, 'options', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:options')))
                set_model_data(model, 'option', entry.xpath('./fhir:option').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'group', entry.xpath('./fhir:group').map {|e| parse_xml_entry_GroupComponent(e)})
                model
            end
            
            def parse_xml_entry_GroupComponent(entry) 
                return nil unless entry
                model = FHIR::Questionnaire::GroupComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'linkId','linkId',false)
                parse_primitive_field(model,entry,'title','title',false)
                set_model_data(model, 'concept', entry.xpath('./fhir:concept').map {|e| FHIR::Coding.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'text','text',false)
                parse_primitive_field(model,entry,'required','required',false)
                parse_primitive_field(model,entry,'repeats','repeats',false)
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
                parse_primitive_field(model,entry,'version','versionNum',false)
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'date','date',false)
                parse_primitive_field(model,entry,'publisher','publisher',false)
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'subjectType','subjectType',true)
                set_model_data(model, 'group', parse_xml_entry_GroupComponent(entry.at_xpath('./fhir:group')))
                model
            end
        end
    end
end
