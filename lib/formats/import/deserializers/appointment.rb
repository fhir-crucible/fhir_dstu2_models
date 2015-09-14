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
                parse_primitive_field(model,entry,'required','required',false)
                parse_primitive_field(model,entry,'status','status',false)
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'reason', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:reason')))
                parse_primitive_field(model,entry,'priority','priority',false)
                parse_primitive_field(model,entry,'description','description',false)
                parse_primitive_field(model,entry,'start','start',false)
                parse_primitive_field(model,entry,'end','end',false)
                parse_primitive_field(model,entry,'minutesDuration','minutesDuration',false)
                set_model_data(model, 'slot', entry.xpath('./fhir:slot').map {|e| FHIR::Reference.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'comment','comment',false)
                set_model_data(model, 'participant', entry.xpath('./fhir:participant').map {|e| parse_xml_entry_AppointmentParticipantComponent(e)})
                model
            end
        end
    end
end
