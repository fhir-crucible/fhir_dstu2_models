module FHIR
    module Deserializer
        module Device
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'manufacturer', entry.at_xpath('./fhir:manufacturer/@value').try(:value))
                set_model_data(model, 'model', entry.at_xpath('./fhir:model/@value').try(:value))
                set_model_data(model, 'versionNum', entry.at_xpath('./fhir:version/@value').try(:value))
                set_model_data(model, 'manufactureDate', entry.at_xpath('./fhir:manufactureDate/@value').try(:value))
                set_model_data(model, 'expiry', entry.at_xpath('./fhir:expiry/@value').try(:value))
                set_model_data(model, 'udi', entry.at_xpath('./fhir:udi/@value').try(:value))
                set_model_data(model, 'lotNumber', entry.at_xpath('./fhir:lotNumber/@value').try(:value))
                set_model_data(model, 'owner', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:owner')))
                set_model_data(model, 'location', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:location')))
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                set_model_data(model, 'url', entry.at_xpath('./fhir:url/@value').try(:value))
                model
            end
        end
    end
end
