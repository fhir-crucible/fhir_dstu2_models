module FHIR
    module Deserializer
        module DeviceUseRequest
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'bodySite', entry.xpath('./fhir:bodySite').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'device', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:device')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'indication', entry.xpath('./fhir:indication').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'notes', entry.xpath('./fhir:notes/@value').map {|e| e.value })
                set_model_data(model, 'prnReason', entry.xpath('./fhir:prnReason').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'orderedOn', entry.at_xpath('./fhir:orderedOn/@value').try(:value))
                set_model_data(model, 'recordedOn', entry.at_xpath('./fhir:recordedOn/@value').try(:value))
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'timingTiming', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:timingTiming')))
                set_model_data(model, 'timingPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:timingPeriod')))
                set_model_data(model, 'timingDateTime', entry.at_xpath('./fhir:timingDateTime/@value').try(:value))
                set_model_data(model, 'priority', entry.at_xpath('./fhir:priority/@value').try(:value))
                model
            end
        end
    end
end
