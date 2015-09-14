module FHIR
    module Deserializer
        module Goal
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_GoalOutcomeComponent(entry) 
                return nil unless entry
                model = FHIR::Goal::GoalOutcomeComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'resultCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:resultCodeableConcept')))
                set_model_data(model, 'resultReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:resultReference')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                parse_primitive_field(model,entry,'startDate','startDate',false)
                set_model_data(model, 'startCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:startCodeableConcept')))
                parse_primitive_field(model,entry,'targetDate','targetDate',false)
                set_model_data(model, 'targetQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:targetQuantity')))
                set_model_data(model, 'category', entry.xpath('./fhir:category').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'description','description',false)
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'statusDate','statusDate',false)
                set_model_data(model, 'statusReason', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:statusReason')))
                set_model_data(model, 'author', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:author')))
                set_model_data(model, 'priority', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:priority')))
                set_model_data(model, 'addresses', entry.xpath('./fhir:addresses').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'note', entry.xpath('./fhir:note').map {|e| FHIR::Annotation.parse_xml_entry(e)})
                set_model_data(model, 'outcome', entry.xpath('./fhir:outcome').map {|e| parse_xml_entry_GoalOutcomeComponent(e)})
                model
            end
        end
    end
end
