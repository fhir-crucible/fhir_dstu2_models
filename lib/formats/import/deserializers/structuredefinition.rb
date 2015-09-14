module FHIR
    module Deserializer
        module StructureDefinition
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_StructureDefinitionContactComponent(entry) 
                return nil unless entry
                model = FHIR::StructureDefinition::StructureDefinitionContactComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_StructureDefinitionMappingComponent(entry) 
                return nil unless entry
                model = FHIR::StructureDefinition::StructureDefinitionMappingComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'identity','fhirIdentity',false)
                parse_primitive_field(model,entry,'uri','uri',false)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'comments','comments',false)
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
                parse_primitive_field(model,entry,'url','url',false)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'version','versionNum',false)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'display','display',false)
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'experimental','experimental',false)
                parse_primitive_field(model,entry,'publisher','publisher',false)
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| parse_xml_entry_StructureDefinitionContactComponent(e)})
                parse_primitive_field(model,entry,'date','date',false)
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'useContext', entry.xpath('./fhir:useContext').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'requirements','requirements',false)
                parse_primitive_field(model,entry,'copyright','copyright',false)
                set_model_data(model, 'code', entry.xpath('./fhir:code').map {|e| FHIR::Coding.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'fhirVersion','fhirVersion',false)
                set_model_data(model, 'mapping', entry.xpath('./fhir:mapping').map {|e| parse_xml_entry_StructureDefinitionMappingComponent(e)})
                parse_primitive_field(model,entry,'kind','kind',false)
                parse_primitive_field(model,entry,'constrainedType','constrainedType',false)
                parse_primitive_field(model,entry,'abstract','abstract',false)
                parse_primitive_field(model,entry,'contextType','contextType',false)
                parse_primitive_field(model,entry,'context','context',true)
                parse_primitive_field(model,entry,'base','base',false)
                set_model_data(model, 'snapshot', parse_xml_entry_StructureDefinitionSnapshotComponent(entry.at_xpath('./fhir:snapshot')))
                set_model_data(model, 'differential', parse_xml_entry_StructureDefinitionDifferentialComponent(entry.at_xpath('./fhir:differential')))
                model
            end
        end
    end
end
