module FHIR
    module Deserializer
        module Organization
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_OrganizationContactComponent(entry) 
                return nil unless entry
                model = FHIR::Organization::OrganizationContactComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'purpose', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:purpose')))
                set_model_data(model, 'name', FHIR::HumanName.parse_xml_entry(entry.at_xpath('./fhir:name')))
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                set_model_data(model, 'address', FHIR::Address.parse_xml_entry(entry.at_xpath('./fhir:address')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                set_model_data(model, 'address', entry.xpath('./fhir:address').map {|e| FHIR::Address.parse_xml_entry(e)})
                set_model_data(model, 'partOf', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:partOf')))
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| parse_xml_entry_OrganizationContactComponent(e)})
                set_model_data(model, 'active', entry.at_xpath('./fhir:active/@value').try(:value))
                model
            end
        end
    end
end
