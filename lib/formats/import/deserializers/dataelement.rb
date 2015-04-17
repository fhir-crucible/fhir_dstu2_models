module FHIR
    module Deserializer
        module DataElement
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_DataElementContactComponent(entry) 
                return nil unless entry
                model = FHIR::DataElement::DataElementContactComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_DataElementMappingComponent(entry) 
                return nil unless entry
                model = FHIR::DataElement::DataElementMappingComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirIdentity', entry.at_xpath('./fhir:identity/@value').try(:value))
                set_model_data(model, 'uri', entry.at_xpath('./fhir:uri/@value').try(:value))
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'comments', entry.at_xpath('./fhir:comments/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'url', entry.at_xpath('./fhir:url/@value').try(:value))
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'versionNum', entry.at_xpath('./fhir:version/@value').try(:value))
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'useContext', entry.xpath('./fhir:useContext').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'experimental', entry.at_xpath('./fhir:experimental/@value').try(:value))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'copyright', entry.at_xpath('./fhir:copyright/@value').try(:value))
                set_model_data(model, 'publisher', entry.at_xpath('./fhir:publisher/@value').try(:value))
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| parse_xml_entry_DataElementContactComponent(e)})
                set_model_data(model, 'specificity', entry.at_xpath('./fhir:specificity/@value').try(:value))
                set_model_data(model, 'mapping', entry.xpath('./fhir:mapping').map {|e| parse_xml_entry_DataElementMappingComponent(e)})
                set_model_data(model, 'element', entry.xpath('./fhir:element').map {|e| FHIR::ElementDefinition.parse_xml_entry(e)})
                model
            end
        end
    end
end
