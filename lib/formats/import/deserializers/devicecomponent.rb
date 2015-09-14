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
                parse_primitive_field(model,entry,'productionSpec','productionSpec',false)
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                parse_primitive_field(model,entry,'lastSystemChange','lastSystemChange',false)
                set_model_data(model, 'source', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:source')))
                set_model_data(model, 'parent', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:parent')))
                set_model_data(model, 'operationalStatus', entry.xpath('./fhir:operationalStatus').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'parameterGroup', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:parameterGroup')))
                parse_primitive_field(model,entry,'measurementPrinciple','measurementPrinciple',false)
                set_model_data(model, 'productionSpecification', entry.xpath('./fhir:productionSpecification').map {|e| parse_xml_entry_DeviceComponentProductionSpecificationComponent(e)})
                set_model_data(model, 'languageCode', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:languageCode')))
                model
            end
        end
    end
end
