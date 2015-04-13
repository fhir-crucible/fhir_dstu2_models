module FHIR
    module Deserializer
        module Media
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'subtype', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:subtype')))
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'operator', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:operator')))
                set_model_data(model, 'view', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:view')))
                set_model_data(model, 'deviceName', entry.at_xpath('./fhir:deviceName/@value').try(:value))
                set_model_data(model, 'height', entry.at_xpath('./fhir:height/@value').try(:value))
                set_model_data(model, 'width', entry.at_xpath('./fhir:width/@value').try(:value))
                set_model_data(model, 'frames', entry.at_xpath('./fhir:frames/@value').try(:value))
                set_model_data(model, 'duration', entry.at_xpath('./fhir:duration/@value').try(:value))
                set_model_data(model, 'content', FHIR::Attachment.parse_xml_entry(entry.at_xpath('./fhir:content')))
                model
            end
        end
    end
end
