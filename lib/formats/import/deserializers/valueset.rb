module FHIR
    module Deserializer
        module ValueSet
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ValueSetContactComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ValueSetContactComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_ConceptDefinitionDesignationComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ConceptDefinitionDesignationComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'language','language',false)
                set_model_data(model, 'use', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:use')))
                parse_primitive_field(model,entry,'value','value',false)
                model
            end
            
            def parse_xml_entry_ConceptDefinitionComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ConceptDefinitionComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'code','code',false)
                parse_primitive_field(model,entry,'abstract','abstract',false)
                parse_primitive_field(model,entry,'display','display',false)
                parse_primitive_field(model,entry,'definition','definition',false)
                set_model_data(model, 'designation', entry.xpath('./fhir:designation').map {|e| parse_xml_entry_ConceptDefinitionDesignationComponent(e)})
                set_model_data(model, 'concept', entry.xpath('./fhir:concept').map {|e| parse_xml_entry_ConceptDefinitionComponent(e)})
                model
            end
            
            def parse_xml_entry_ValueSetCodeSystemComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ValueSetCodeSystemComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'system','system',false)
                parse_primitive_field(model,entry,'version','versionNum',false)
                parse_primitive_field(model,entry,'caseSensitive','caseSensitive',false)
                set_model_data(model, 'concept', entry.xpath('./fhir:concept').map {|e| parse_xml_entry_ConceptDefinitionComponent(e)})
                model
            end
            
            def parse_xml_entry_ConceptReferenceComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ConceptReferenceComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'code','code',false)
                parse_primitive_field(model,entry,'display','display',false)
                set_model_data(model, 'designation', entry.xpath('./fhir:designation').map {|e| parse_xml_entry_ConceptDefinitionDesignationComponent(e)})
                model
            end
            
            def parse_xml_entry_ConceptSetFilterComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ConceptSetFilterComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'property','property',false)
                parse_primitive_field(model,entry,'op','op',false)
                parse_primitive_field(model,entry,'value','value',false)
                model
            end
            
            def parse_xml_entry_ConceptSetComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ConceptSetComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'system','system',false)
                parse_primitive_field(model,entry,'version','versionNum',false)
                set_model_data(model, 'concept', entry.xpath('./fhir:concept').map {|e| parse_xml_entry_ConceptReferenceComponent(e)})
                set_model_data(model, 'filter', entry.xpath('./fhir:filter').map {|e| parse_xml_entry_ConceptSetFilterComponent(e)})
                model
            end
            
            def parse_xml_entry_ValueSetComposeComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ValueSetComposeComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'import','import',true)
                set_model_data(model, 'include', entry.xpath('./fhir:include').map {|e| parse_xml_entry_ConceptSetComponent(e)})
                set_model_data(model, 'exclude', entry.xpath('./fhir:exclude').map {|e| parse_xml_entry_ConceptSetComponent(e)})
                model
            end
            
            def parse_xml_entry_ValueSetExpansionParameterComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ValueSetExpansionParameterComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'valueString','valueString',false)
                parse_primitive_field(model,entry,'valueBoolean','valueBoolean',false)
                parse_primitive_field(model,entry,'valueInteger','valueInteger',false)
                parse_primitive_field(model,entry,'valueDecimal','valueDecimal',false)
                parse_primitive_field(model,entry,'valueUri','valueUri',false)
                parse_primitive_field(model,entry,'valueCode','valueCode',false)
                model
            end
            
            def parse_xml_entry_ValueSetExpansionContainsComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ValueSetExpansionContainsComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'system','system',false)
                parse_primitive_field(model,entry,'abstract','abstract',false)
                parse_primitive_field(model,entry,'version','versionNum',false)
                parse_primitive_field(model,entry,'code','code',false)
                parse_primitive_field(model,entry,'display','display',false)
                set_model_data(model, 'contains', entry.xpath('./fhir:contains').map {|e| parse_xml_entry_ValueSetExpansionContainsComponent(e)})
                model
            end
            
            def parse_xml_entry_ValueSetExpansionComponent(entry) 
                return nil unless entry
                model = FHIR::ValueSet::ValueSetExpansionComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'identifier','identifier',false)
                parse_primitive_field(model,entry,'timestamp','timestamp',false)
                parse_primitive_field(model,entry,'total','total',false)
                parse_primitive_field(model,entry,'offset','offset',false)
                set_model_data(model, 'parameter', entry.xpath('./fhir:parameter').map {|e| parse_xml_entry_ValueSetExpansionParameterComponent(e)})
                set_model_data(model, 'contains', entry.xpath('./fhir:contains').map {|e| parse_xml_entry_ValueSetExpansionContainsComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                parse_primitive_field(model,entry,'url','url',false)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                parse_primitive_field(model,entry,'version','versionNum',false)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'experimental','experimental',false)
                parse_primitive_field(model,entry,'publisher','publisher',false)
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| parse_xml_entry_ValueSetContactComponent(e)})
                parse_primitive_field(model,entry,'date','date',false)
                parse_primitive_field(model,entry,'lockedDate','lockedDate',false)
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'useContext', entry.xpath('./fhir:useContext').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'immutable','immutable',false)
                parse_primitive_field(model,entry,'requirements','requirements',false)
                parse_primitive_field(model,entry,'copyright','copyright',false)
                parse_primitive_field(model,entry,'extensible','extensible',false)
                set_model_data(model, 'codeSystem', parse_xml_entry_ValueSetCodeSystemComponent(entry.at_xpath('./fhir:codeSystem')))
                set_model_data(model, 'compose', parse_xml_entry_ValueSetComposeComponent(entry.at_xpath('./fhir:compose')))
                set_model_data(model, 'expansion', parse_xml_entry_ValueSetExpansionComponent(entry.at_xpath('./fhir:expansion')))
                model
            end
        end
    end
end
