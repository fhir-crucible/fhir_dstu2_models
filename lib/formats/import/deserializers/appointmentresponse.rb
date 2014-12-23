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
                set_model_data(model, 'participantType', entry.xpath('./fhir:participantType').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'individual', entry.xpath('./fhir:individual').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'participantStatus', entry.at_xpath('./fhir:participantStatus/@value').try(:value))
                set_model_data(model, 'comment', entry.at_xpath('./fhir:comment/@value').try(:value))
                set_model_data(model, 'start', parse_date_time(entry.at_xpath('./fhir:start/@value').try(:value)))
                set_model_data(model, 'end', parse_date_time(entry.at_xpath('./fhir:end/@value').try(:value)))
                set_model_data(model, 'lastModifiedBy', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:lastModifiedBy')))
                set_model_data(model, 'lastModified', entry.at_xpath('./fhir:lastModified/@value').try(:value))
                model
            end
        end
    end
end
