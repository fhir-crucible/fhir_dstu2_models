module FHIR
    module Deserializer
        module OrderResponse
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'request', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:request')))
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'who', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:who')))
                set_model_data(model, 'authorityCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:authorityCodeableConcept')))
                set_model_data(model, 'authorityReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:authorityReference')))
                set_model_data(model, 'orderStatus', entry.at_xpath('./fhir:orderStatus/@value').try(:value))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'fulfillment', entry.xpath('./fhir:fulfillment').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
        end
    end
end
