module FHIR
    module Deserializer
        module OperationDefinition
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_OperationDefinitionParameterPartComponent(entry) 
                return nil unless entry
                model = FHIR::OperationDefinition::OperationDefinitionParameterPartComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'min', entry.at_xpath('./fhir:min/@value').try(:value))
                set_model_data(model, 'max', entry.at_xpath('./fhir:max/@value').try(:value))
                set_model_data(model, 'documentation', entry.at_xpath('./fhir:documentation/@value').try(:value))
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'profile', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:profile')))
                model
            end
            
            def parse_xml_entry_OperationDefinitionParameterComponent(entry) 
                return nil unless entry
                model = FHIR::OperationDefinition::OperationDefinitionParameterComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'use', entry.at_xpath('./fhir:use/@value').try(:value))
                set_model_data(model, 'min', entry.at_xpath('./fhir:min/@value').try(:value))
                set_model_data(model, 'max', entry.at_xpath('./fhir:max/@value').try(:value))
                set_model_data(model, 'documentation', entry.at_xpath('./fhir:documentation/@value').try(:value))
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'profile', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:profile')))
                set_model_data(model, 'part', entry.xpath('./fhir:part').map {|e| parse_xml_entry_OperationDefinitionParameterPartComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.at_xpath('./fhir:identifier/@value').try(:value))
                set_model_data(model, 'versionNum', entry.at_xpath('./fhir:version/@value').try(:value))
                set_model_data(model, 'title', entry.at_xpath('./fhir:title/@value').try(:value))
                set_model_data(model, 'publisher', entry.at_xpath('./fhir:publisher/@value').try(:value))
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'code', entry.xpath('./fhir:code').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'experimental', entry.at_xpath('./fhir:experimental/@value').try(:value))
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'kind', entry.at_xpath('./fhir:kind/@value').try(:value))
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'notes', entry.at_xpath('./fhir:notes/@value').try(:value))
                set_model_data(model, 'base', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:base')))
                set_model_data(model, 'system', entry.at_xpath('./fhir:system/@value').try(:value))
                set_model_data(model, 'fhirType', entry.xpath('./fhir:type/@value').map {|e| e.value })
                set_model_data(model, 'instance', entry.at_xpath('./fhir:instance/@value').try(:value))
                set_model_data(model, 'parameter', entry.xpath('./fhir:parameter').map {|e| parse_xml_entry_OperationDefinitionParameterComponent(e)})
                model
            end
        end
    end
end
