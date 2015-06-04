module FHIR
    module Deserializer
        module DeviceComponent
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_DeviceComponentProductionSpecificationComponent(entry) 
                return nil unless entry
                model = FHIR::DeviceComponent::DeviceComponentProductionSpecificationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'specType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:specType')))
                set_model_data(model, 'componentId', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:componentId')))
                set_model_data(model, 'productionSpec', entry.at_xpath('./fhir:productionSpec/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'lastSystemChange', entry.at_xpath('./fhir:lastSystemChange/@value').try(:value))
                set_model_data(model, 'source', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:source')))
                set_model_data(model, 'parent', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:parent')))
                set_model_data(model, 'operationalStatus', entry.xpath('./fhir:operationalStatus').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'parameterGroup', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:parameterGroup')))
                set_model_data(model, 'measurementPrinciple', entry.at_xpath('./fhir:measurementPrinciple/@value').try(:value))
                set_model_data(model, 'productionSpecification', entry.xpath('./fhir:productionSpecification').map {|e| parse_xml_entry_DeviceComponentProductionSpecificationComponent(e)})
                set_model_data(model, 'languageCode', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:languageCode')))
                model
            end
        end
    end
end
