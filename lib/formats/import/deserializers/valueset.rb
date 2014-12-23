module FHIR
    module Deserializer
        module ValueSet
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ConceptDefinitionDesignationComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ConceptDefinitionDesignationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'language', entry.at_xpath('./fhir:language/@value').try(:value))
                set_model_data(model, 'use', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:use')))
                set_model_data(model, 'value', entry.at_xpath('./fhir:value/@value').try(:value))
                model
            end
            
            def parse_xml_entry_ConceptDefinitionComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ConceptDefinitionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', entry.at_xpath('./fhir:code/@value').try(:value))
                set_model_data(model, 'abstract', entry.at_xpath('./fhir:abstract/@value').try(:value))
                set_model_data(model, 'display', entry.at_xpath('./fhir:display/@value').try(:value))
                set_model_data(model, 'definition', entry.at_xpath('./fhir:definition/@value').try(:value))
                set_model_data(model, 'designation', entry.xpath('./fhir:designation').map {|e| parse_xml_entry_ConceptDefinitionDesignationComponent(e)})
                set_model_data(model, 'concept', entry.xpath('./fhir:concept').map {|e| parse_xml_entry_ConceptDefinitionComponent(e)})
                model
            end
            
            def parse_xml_entry_ValueSetDefineComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ValueSetDefineComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'system', entry.at_xpath('./fhir:system/@value').try(:value))
                set_model_data(model, 'versionNum', entry.at_xpath('./fhir:version/@value').try(:value))
                set_model_data(model, 'caseSensitive', entry.at_xpath('./fhir:caseSensitive/@value').try(:value))
                set_model_data(model, 'concept', entry.xpath('./fhir:concept').map {|e| parse_xml_entry_ConceptDefinitionComponent(e)})
                model
            end
            
            def parse_xml_entry_ConceptReferenceComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ConceptReferenceComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', entry.at_xpath('./fhir:code/@value').try(:value))
                set_model_data(model, 'display', entry.at_xpath('./fhir:display/@value').try(:value))
                set_model_data(model, 'designation', entry.xpath('./fhir:designation').map {|e| parse_xml_entry_ConceptDefinitionDesignationComponent(e)})
                model
            end
            
            def parse_xml_entry_ConceptSetFilterComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ConceptSetFilterComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'property', entry.at_xpath('./fhir:property/@value').try(:value))
                set_model_data(model, 'op', entry.at_xpath('./fhir:op/@value').try(:value))
                set_model_data(model, 'value', entry.at_xpath('./fhir:value/@value').try(:value))
                model
            end
            
            def parse_xml_entry_ConceptSetComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ConceptSetComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'system', entry.at_xpath('./fhir:system/@value').try(:value))
                set_model_data(model, 'versionNum', entry.at_xpath('./fhir:version/@value').try(:value))
                set_model_data(model, 'concept', entry.xpath('./fhir:concept').map {|e| parse_xml_entry_ConceptReferenceComponent(e)})
                set_model_data(model, 'filter', entry.xpath('./fhir:filter').map {|e| parse_xml_entry_ConceptSetFilterComponent(e)})
                model
            end
            
            def parse_xml_entry_ValueSetComposeComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ValueSetComposeComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'import', entry.xpath('./fhir:import/@value').map {|e| e.value })
                set_model_data(model, 'include', entry.xpath('./fhir:include').map {|e| parse_xml_entry_ConceptSetComponent(e)})
                set_model_data(model, 'exclude', entry.xpath('./fhir:exclude').map {|e| parse_xml_entry_ConceptSetComponent(e)})
                model
            end
            
            def parse_xml_entry_ValueSetExpansionContainsComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ValueSetExpansionContainsComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'system', entry.at_xpath('./fhir:system/@value').try(:value))
                set_model_data(model, 'abstract', entry.at_xpath('./fhir:abstract/@value').try(:value))
                set_model_data(model, 'versionNum', entry.at_xpath('./fhir:version/@value').try(:value))
                set_model_data(model, 'code', entry.at_xpath('./fhir:code/@value').try(:value))
                set_model_data(model, 'display', entry.at_xpath('./fhir:display/@value').try(:value))
                set_model_data(model, 'contains', entry.xpath('./fhir:contains').map {|e| parse_xml_entry_ValueSetExpansionContainsComponent(e)})
                model
            end
            
            def parse_xml_entry_ValueSetExpansionComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ValueSetExpansionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'timestamp', entry.at_xpath('./fhir:timestamp/@value').try(:value))
                set_model_data(model, 'contains', entry.xpath('./fhir:contains').map {|e| parse_xml_entry_ValueSetExpansionContainsComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.at_xpath('./fhir:identifier/@value').try(:value))
                set_model_data(model, 'versionNum', entry.at_xpath('./fhir:version/@value').try(:value))
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'purpose', entry.at_xpath('./fhir:purpose/@value').try(:value))
                set_model_data(model, 'immutable', entry.at_xpath('./fhir:immutable/@value').try(:value))
                set_model_data(model, 'publisher', entry.at_xpath('./fhir:publisher/@value').try(:value))
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'copyright', entry.at_xpath('./fhir:copyright/@value').try(:value))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'experimental', entry.at_xpath('./fhir:experimental/@value').try(:value))
                set_model_data(model, 'extensible', entry.at_xpath('./fhir:extensible/@value').try(:value))
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'stableDate', entry.at_xpath('./fhir:stableDate/@value').try(:value))
                set_model_data(model, 'define', parse_xml_entry_ValueSetDefineComponent(entry.at_xpath('./fhir:define')))
                set_model_data(model, 'compose', parse_xml_entry_ValueSetComposeComponent(entry.at_xpath('./fhir:compose')))
                set_model_data(model, 'expansion', parse_xml_entry_ValueSetExpansionComponent(entry.at_xpath('./fhir:expansion')))
                model
            end
        end
    end
end
