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
                set_model_data(model, 'height', FHIR::positiveInt.parse_xml_entry(entry.at_xpath('./fhir:height')))
                set_model_data(model, 'width', FHIR::positiveInt.parse_xml_entry(entry.at_xpath('./fhir:width')))
                set_model_data(model, 'frames', FHIR::positiveInt.parse_xml_entry(entry.at_xpath('./fhir:frames')))
                set_model_data(model, 'duration', FHIR::unsignedInt.parse_xml_entry(entry.at_xpath('./fhir:duration')))
                set_model_data(model, 'content', FHIR::Attachment.parse_xml_entry(entry.at_xpath('./fhir:content')))
                model
            end
        end
    end
end
