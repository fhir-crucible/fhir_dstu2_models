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
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'targetDate', entry.at_xpath('./fhir:targetDate/@value').try(:value))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'statusDate', entry.at_xpath('./fhir:statusDate/@value').try(:value))
                set_model_data(model, 'author', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:author')))
                set_model_data(model, 'priority', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:priority')))
                set_model_data(model, 'concern', entry.xpath('./fhir:concern').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'notes', entry.at_xpath('./fhir:notes/@value').try(:value))
                set_model_data(model, 'outcome', entry.xpath('./fhir:outcome').map {|e| parse_xml_entry_GoalOutcomeComponent(e)})
                model
            end
        end
    end
end
