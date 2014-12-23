module FHIR
    module Deserializer
        module NamingSystem
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_NamingSystemUniqueIdComponent(entry) 
                return nil unless entry
                model = FHIR::NamingSystem::NamingSystemUniqueIdComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'value', entry.at_xpath('./fhir:value/@value').try(:value))
                set_model_data(model, 'preferred', entry.at_xpath('./fhir:preferred/@value').try(:value))
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                model
            end
            
            def parse_xml_entry_NamingSystemContactComponent(entry) 
                return nil unless entry
                model = FHIR::NamingSystem::NamingSystemContactComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'name', FHIR::HumanName.parse_xml_entry(entry.at_xpath('./fhir:name')))
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'country', entry.at_xpath('./fhir:country/@value').try(:value))
                set_model_data(model, 'category', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:category')))
                set_model_data(model, 'responsible', entry.at_xpath('./fhir:responsible/@value').try(:value))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'usage', entry.at_xpath('./fhir:usage/@value').try(:value))
                set_model_data(model, 'uniqueId', entry.xpath('./fhir:uniqueId').map {|e| parse_xml_entry_NamingSystemUniqueIdComponent(e)})
                set_model_data(model, 'contact', parse_xml_entry_NamingSystemContactComponent(entry.at_xpath('./fhir:contact')))
                set_model_data(model, 'replacedBy', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:replacedBy')))
                model
            end
        end
    end
end
