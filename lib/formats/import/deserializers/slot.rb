module FHIR
    module Deserializer
        module Slot
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'schedule', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:schedule')))
                set_model_data(model, 'freeBusyType', entry.at_xpath('./fhir:freeBusyType/@value').try(:value))
                set_model_data(model, 'start', parse_date_time(entry.at_xpath('./fhir:start/@value').try(:value)))
                set_model_data(model, 'end', parse_date_time(entry.at_xpath('./fhir:end/@value').try(:value)))
                set_model_data(model, 'overbooked', entry.at_xpath('./fhir:overbooked/@value').try(:value))
                set_model_data(model, 'comment', entry.at_xpath('./fhir:comment/@value').try(:value))
                set_model_data(model, 'lastModified', entry.at_xpath('./fhir:lastModified/@value').try(:value))
                model
            end
        end
    end
end
