module FHIR
    module Deserializer
        module CarePlan2
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_CarePlan2ParticipantComponent(entry) 
                return nil unless entry
                model = FHIR::CarePlan2::CarePlan2ParticipantComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'role', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:role')))
                set_model_data(model, 'member', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:member')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                set_model_data(model, 'modified', entry.at_xpath('./fhir:modified/@value').try(:value))
                set_model_data(model, 'concern', entry.xpath('./fhir:concern').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'participant', entry.xpath('./fhir:participant').map {|e| parse_xml_entry_CarePlan2ParticipantComponent(e)})
                set_model_data(model, 'notes', entry.at_xpath('./fhir:notes/@value').try(:value))
                set_model_data(model, 'goal', entry.xpath('./fhir:goal').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'activity', entry.xpath('./fhir:activity').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
        end
    end
end
