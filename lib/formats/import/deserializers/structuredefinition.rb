module FHIR
    module Deserializer
        module StructureDefinition
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_StructureDefinitionContactComponent(entry) 
                return nil unless entry
                model = FHIR::StructureDefinition::StructureDefinitionContactComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_StructureDefinitionMappingComponent(entry) 
                return nil unless entry
                model = FHIR::StructureDefinition::StructureDefinitionMappingComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirIdentity', entry.at_xpath('./fhir:identity/@value').try(:value))
                set_model_data(model, 'uri', entry.at_xpath('./fhir:uri/@value').try(:value))
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'comments', entry.at_xpath('./fhir:comments/@value').try(:value))
                model
            end
            
            def parse_xml_entry_StructureDefinitionSnapshotComponent(entry) 
                return nil unless entry
                model = FHIR::StructureDefinition::StructureDefinitionSnapshotComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'element', entry.xpath('./fhir:element').map {|e| FHIR::ElementDefinition.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_StructureDefinitionDifferentialComponent(entry) 
                return nil unless entry
                model = FHIR::StructureDefinition::StructureDefinitionDifferentialComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'element', entry.xpath('./fhir:element').map {|e| FHIR::ElementDefinition.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'url', entry.at_xpath('./fhir:url/@value').try(:value))
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'versionNum', entry.at_xpath('./fhir:version/@value').try(:value))
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'useContext', entry.xpath('./fhir:useContext').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'display', entry.at_xpath('./fhir:display/@value').try(:value))
                set_model_data(model, 'publisher', entry.at_xpath('./fhir:publisher/@value').try(:value))
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| parse_xml_entry_StructureDefinitionContactComponent(e)})
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'requirements', entry.at_xpath('./fhir:requirements/@value').try(:value))
                set_model_data(model, 'copyright', entry.at_xpath('./fhir:copyright/@value').try(:value))
                set_model_data(model, 'code', entry.xpath('./fhir:code').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'experimental', entry.at_xpath('./fhir:experimental/@value').try(:value))
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'fhirVersion', entry.at_xpath('./fhir:fhirVersion/@value').try(:value))
                set_model_data(model, 'mapping', entry.xpath('./fhir:mapping').map {|e| parse_xml_entry_StructureDefinitionMappingComponent(e)})
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'abstract', entry.at_xpath('./fhir:abstract/@value').try(:value))
                set_model_data(model, 'contextType', entry.at_xpath('./fhir:contextType/@value').try(:value))
                set_model_data(model, 'context', entry.xpath('./fhir:context/@value').map {|e| e.value })
                set_model_data(model, 'base', entry.at_xpath('./fhir:base/@value').try(:value))
                set_model_data(model, 'snapshot', parse_xml_entry_StructureDefinitionSnapshotComponent(entry.at_xpath('./fhir:snapshot')))
                set_model_data(model, 'differential', parse_xml_entry_StructureDefinitionDifferentialComponent(entry.at_xpath('./fhir:differential')))
                model
            end
        end
    end
end
