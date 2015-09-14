module FHIR
    module Deserializer
        module ElementDefinition
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ElementDefinitionSlicingComponent(entry) 
                return nil unless entry
                model = FHIR::ElementDefinition::ElementDefinitionSlicingComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'discriminator','discriminator',true)
                parse_primitive_field(model,entry,'description','description',false)
                parse_primitive_field(model,entry,'ordered','ordered',false)
                parse_primitive_field(model,entry,'rules','rules',false)
                model
            end
            
            def parse_xml_entry_ElementDefinitionBaseComponent(entry) 
                return nil unless entry
                model = FHIR::ElementDefinition::ElementDefinitionBaseComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'path','path',false)
                parse_primitive_field(model,entry,'min','min',false)
                parse_primitive_field(model,entry,'max','max',false)
                model
            end
            
            def parse_xml_entry_TypeRefComponent(entry) 
                return nil unless entry
                model = FHIR::ElementDefinition::TypeRefComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'code','code',false)
                parse_primitive_field(model,entry,'profile','profile',true)
                parse_primitive_field(model,entry,'aggregation','aggregation',true)
                model
            end
            
            def parse_xml_entry_ElementDefinitionConstraintComponent(entry) 
                return nil unless entry
                model = FHIR::ElementDefinition::ElementDefinitionConstraintComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'key','key',false)
                parse_primitive_field(model,entry,'requirements','requirements',false)
                parse_primitive_field(model,entry,'severity','severity',false)
                parse_primitive_field(model,entry,'human','human',false)
                parse_primitive_field(model,entry,'xpath','xpath',false)
                model
            end
            
            def parse_xml_entry_ElementDefinitionBindingComponent(entry) 
                return nil unless entry
                model = FHIR::ElementDefinition::ElementDefinitionBindingComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'strength','strength',false)
                parse_primitive_field(model,entry,'description','description',false)
                parse_primitive_field(model,entry,'valueSetUri','valueSetUri',false)
                set_model_data(model, 'valueSetReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:valueSetReference')))
                model
            end
            
            def parse_xml_entry_ElementDefinitionMappingComponent(entry) 
                return nil unless entry
                model = FHIR::ElementDefinition::ElementDefinitionMappingComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'identity','fhirIdentity',false)
                parse_primitive_field(model,entry,'language','language',false)
                parse_primitive_field(model,entry,'map','map',false)
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'path','path',false)
                parse_primitive_field(model,entry,'representation','representation',true)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'label','label',false)
                set_model_data(model, 'code', entry.xpath('./fhir:code').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'slicing', parse_xml_entry_ElementDefinitionSlicingComponent(entry.at_xpath('./fhir:slicing')))
                parse_primitive_field(model,entry,'short','short',false)
                parse_primitive_field(model,entry,'definition','definition',false)
                parse_primitive_field(model,entry,'comments','comments',false)
                parse_primitive_field(model,entry,'requirements','requirements',false)
                parse_primitive_field(model,entry,'alias','alias',true)
                parse_primitive_field(model,entry,'min','min',false)
                parse_primitive_field(model,entry,'max','max',false)
                set_model_data(model, 'base', parse_xml_entry_ElementDefinitionBaseComponent(entry.at_xpath('./fhir:base')))
                set_model_data(model, 'fhirType', entry.xpath('./fhir:type').map {|e| parse_xml_entry_TypeRefComponent(e)})
                parse_primitive_field(model,entry,'nameReference','nameReference',false)
                entry.xpath("./*[contains(local-name(),'defaultValue')]").each do |e| 
                  datatype = e.name.gsub('defaultValue','')
                  v = e.at_xpath('@value').try(:value)
                  if v.nil? && is_fhir_class?("FHIR::#{datatype}")
                    v = "FHIR::#{datatype}".constantize.parse_xml_entry(e)
                  end
                  model.defaultValue = FHIR::AnyType.new(datatype,v)
                end
                parse_primitive_field(model,entry,'meaningWhenMissing','meaningWhenMissing',false)
                entry.xpath("./*[contains(local-name(),'fixed')]").each do |e| 
                  datatype = e.name.gsub('fixed','')
                  v = e.at_xpath('@value').try(:value)
                  if v.nil? && is_fhir_class?("FHIR::#{datatype}")
                    v = "FHIR::#{datatype}".constantize.parse_xml_entry(e)
                  end
                  model.fixed = FHIR::AnyType.new(datatype,v)
                end
                entry.xpath("./*[contains(local-name(),'pattern')]").each do |e| 
                  datatype = e.name.gsub('pattern','')
                  v = e.at_xpath('@value').try(:value)
                  if v.nil? && is_fhir_class?("FHIR::#{datatype}")
                    v = "FHIR::#{datatype}".constantize.parse_xml_entry(e)
                  end
                  model.pattern = FHIR::AnyType.new(datatype,v)
                end
                entry.xpath("./*[contains(local-name(),'example')]").each do |e| 
                  datatype = e.name.gsub('example','')
                  v = e.at_xpath('@value').try(:value)
                  if v.nil? && is_fhir_class?("FHIR::#{datatype}")
                    v = "FHIR::#{datatype}".constantize.parse_xml_entry(e)
                  end
                  model.example = FHIR::AnyType.new(datatype,v)
                end
                entry.xpath("./*[contains(local-name(),'minValue')]").each do |e| 
                  datatype = e.name.gsub('minValue','')
                  v = e.at_xpath('@value').try(:value)
                  if v.nil? && is_fhir_class?("FHIR::#{datatype}")
                    v = "FHIR::#{datatype}".constantize.parse_xml_entry(e)
                  end
                  model.minValue = FHIR::AnyType.new(datatype,v)
                end
                entry.xpath("./*[contains(local-name(),'maxValue')]").each do |e| 
                  datatype = e.name.gsub('maxValue','')
                  v = e.at_xpath('@value').try(:value)
                  if v.nil? && is_fhir_class?("FHIR::#{datatype}")
                    v = "FHIR::#{datatype}".constantize.parse_xml_entry(e)
                  end
                  model.maxValue = FHIR::AnyType.new(datatype,v)
                end
                parse_primitive_field(model,entry,'maxLength','maxLength',false)
                parse_primitive_field(model,entry,'condition','condition',true)
                set_model_data(model, 'constraint', entry.xpath('./fhir:constraint').map {|e| parse_xml_entry_ElementDefinitionConstraintComponent(e)})
                parse_primitive_field(model,entry,'mustSupport','mustSupport',false)
                parse_primitive_field(model,entry,'isModifier','isModifier',false)
                parse_primitive_field(model,entry,'isSummary','isSummary',false)
                set_model_data(model, 'binding', parse_xml_entry_ElementDefinitionBindingComponent(entry.at_xpath('./fhir:binding')))
                set_model_data(model, 'mapping', entry.xpath('./fhir:mapping').map {|e| parse_xml_entry_ElementDefinitionMappingComponent(e)})
                model
            end
        end
    end
end
