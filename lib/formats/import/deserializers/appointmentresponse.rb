module FHIR
    module Deserializer
        module AppointmentResponse
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'appointment', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:appointment')))
                parse_primitive_field(model,entry,'start','start',false)
                parse_primitive_field(model,entry,'end','end',false)
                set_model_data(model, 'participantType', entry.xpath('./fhir:participantType').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'actor', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:actor')))
                parse_primitive_field(model,entry,'participantStatus','participantStatus',false)
                parse_primitive_field(model,entry,'comment','comment',false)
                model
            end
        end
    end
end
