module FHIR
    module Deserializer
        module Appointment
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_AppointmentParticipantComponent(entry) 
                return nil unless entry
                model = FHIR::Appointment::AppointmentParticipantComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.xpath('./fhir:type').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'actor', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:actor')))
                set_model_data(model, 'required', entry.at_xpath('./fhir:required/@value').try(:value))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'reason', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:reason')))
                set_model_data(model, 'priority', FHIR::unsignedInt.parse_xml_entry(entry.at_xpath('./fhir:priority')))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'start', parse_date_time(entry.at_xpath('./fhir:start/@value').try(:value)))
                set_model_data(model, 'end', parse_date_time(entry.at_xpath('./fhir:end/@value').try(:value)))
                set_model_data(model, 'slot', entry.xpath('./fhir:slot').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'comment', entry.at_xpath('./fhir:comment/@value').try(:value))
                set_model_data(model, 'order', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:order')))
                set_model_data(model, 'participant', entry.xpath('./fhir:participant').map {|e| parse_xml_entry_AppointmentParticipantComponent(e)})
                model
            end
        end
    end
end
