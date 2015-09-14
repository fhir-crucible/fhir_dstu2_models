module FHIR
    module Deserializer
        module OperationDefinition
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_OperationDefinitionContactComponent(entry) 
                return nil unless entry
                model = FHIR::OperationDefinition::OperationDefinitionContactComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_OperationDefinitionParameterBindingComponent(entry) 
                return nil unless entry
                model = FHIR::OperationDefinition::OperationDefinitionParameterBindingComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'strength','strength',false)
                parse_primitive_field(model,entry,'valueSetUri','valueSetUri',false)
                set_model_data(model, 'valueSetReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:valueSetReference')))
                model
            end
            
            def parse_xml_entry_OperationDefinitionParameterComponent(entry) 
                return nil unless entry
                model = FHIR::OperationDefinition::OperationDefinitionParameterComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'use','use',false)
                parse_primitive_field(model,entry,'min','min',false)
                parse_primitive_field(model,entry,'max','max',false)
                parse_primitive_field(model,entry,'documentation','documentation',false)
                parse_primitive_field(model,entry,'type','fhirType',false)
                set_model_data(model, 'profile', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:profile')))
                set_model_data(model, 'binding', parse_xml_entry_OperationDefinitionParameterBindingComponent(entry.at_xpath('./fhir:binding')))
                set_model_data(model, 'part', entry.xpath('./fhir:part').map {|e| parse_xml_entry_OperationDefinitionParameterComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                parse_primitive_field(model,entry,'url','url',false)
                parse_primitive_field(model,entry,'version','versionNum',false)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'kind','kind',false)
                parse_primitive_field(model,entry,'experimental','experimental',false)
                parse_primitive_field(model,entry,'publisher','publisher',false)
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| parse_xml_entry_OperationDefinitionContactComponent(e)})
                parse_primitive_field(model,entry,'date','date',false)
                parse_primitive_field(model,entry,'description','description',false)
                parse_primitive_field(model,entry,'requirements','requirements',false)
                parse_primitive_field(model,entry,'idempotent','idempotent',false)
                parse_primitive_field(model,entry,'code','code',false)
                parse_primitive_field(model,entry,'notes','notes',false)
                set_model_data(model, 'base', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:base')))
                parse_primitive_field(model,entry,'system','system',false)
                parse_primitive_field(model,entry,'type','fhirType',true)
                parse_primitive_field(model,entry,'instance','instance',false)
                set_model_data(model, 'parameter', entry.xpath('./fhir:parameter').map {|e| parse_xml_entry_OperationDefinitionParameterComponent(e)})
                model
            end
        end
    end
end
