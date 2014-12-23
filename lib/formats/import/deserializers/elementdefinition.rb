module FHIR
    module Deserializer
        module ElementDefinition
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ElementDefinitionSlicingComponent(entry) 
                return nil unless entry
                model = FHIR::ElementDefinition::ElementDefinitionSlicingComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'discriminator', entry.xpath('./fhir:discriminator/@value').map {|e| e.value })
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'ordered', entry.at_xpath('./fhir:ordered/@value').try(:value))
                set_model_data(model, 'rules', entry.at_xpath('./fhir:rules/@value').try(:value))
                model
            end
            
            def parse_xml_entry_TypeRefComponent(entry) 
                return nil unless entry
                model = FHIR::ElementDefinition::TypeRefComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', entry.at_xpath('./fhir:code/@value').try(:value))
                set_model_data(model, 'profile', entry.at_xpath('./fhir:profile/@value').try(:value))
                set_model_data(model, 'aggregation', entry.xpath('./fhir:aggregation/@value').map {|e| e.value })
                model
            end
            
            def parse_xml_entry_ElementDefinitionConstraintComponent(entry) 
                return nil unless entry
                model = FHIR::ElementDefinition::ElementDefinitionConstraintComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'key', entry.at_xpath('./fhir:key/@value').try(:value))
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'severity', entry.at_xpath('./fhir:severity/@value').try(:value))
                set_model_data(model, 'human', entry.at_xpath('./fhir:human/@value').try(:value))
                set_model_data(model, 'xpath', entry.at_xpath('./fhir:xpath/@value').try(:value))
                model
            end
            
            def parse_xml_entry_ElementDefinitionBindingComponent(entry) 
                return nil unless entry
                model = FHIR::ElementDefinition::ElementDefinitionBindingComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'isExtensible', entry.at_xpath('./fhir:isExtensible/@value').try(:value))
                set_model_data(model, 'conformance', entry.at_xpath('./fhir:conformance/@value').try(:value))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'referenceUri', entry.at_xpath('./fhir:referenceUri/@value').try(:value))
                set_model_data(model, 'referenceReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:referenceReference')))
                model
            end
            
            def parse_xml_entry_ElementDefinitionMappingComponent(entry) 
                return nil unless entry
                model = FHIR::ElementDefinition::ElementDefinitionMappingComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'identity', entry.at_xpath('./fhir:identity/@value').try(:value))
                set_model_data(model, 'map', entry.at_xpath('./fhir:map/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'path', entry.at_xpath('./fhir:path/@value').try(:value))
                set_model_data(model, 'representation', entry.xpath('./fhir:representation/@value').map {|e| e.value })
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'slicing', parse_xml_entry_ElementDefinitionSlicingComponent(entry.at_xpath('./fhir:slicing')))
                set_model_data(model, 'short', entry.at_xpath('./fhir:short/@value').try(:value))
                set_model_data(model, 'formal', entry.at_xpath('./fhir:formal/@value').try(:value))
                set_model_data(model, 'comments', entry.at_xpath('./fhir:comments/@value').try(:value))
                set_model_data(model, 'requirements', entry.at_xpath('./fhir:requirements/@value').try(:value))
                set_model_data(model, 'synonym', entry.xpath('./fhir:synonym/@value').map {|e| e.value })
                set_model_data(model, 'min', entry.at_xpath('./fhir:min/@value').try(:value))
                set_model_data(model, 'max', entry.at_xpath('./fhir:max/@value').try(:value))
                set_model_data(model, 'fhirType', entry.xpath('./fhir:type').map {|e| parse_xml_entry_TypeRefComponent(e)})
                set_model_data(model, 'nameReference', entry.at_xpath('./fhir:nameReference/@value').try(:value))
                entry.xpath("./*[contains(local-name(),'defaultValue')]").each do |e| 
                  model.defaultValueType = e.name.gsub('defaultValue','')
                  v = e.at_xpath('@value').try(:value)
                  v = "FHIR::#{model.defaultValueType}".constantize.parse_xml_entry(e) unless v
                  model.defaultValue = {type: model.defaultValueType, value: v}
                end
                set_model_data(model, 'meaningWhenMissing', entry.at_xpath('./fhir:meaningWhenMissing/@value').try(:value))
                entry.xpath("./*[contains(local-name(),'fixed')]").each do |e| 
                  model.fixedType = e.name.gsub('fixed','')
                  v = e.at_xpath('@value').try(:value)
                  v = "FHIR::#{model.fixedType}".constantize.parse_xml_entry(e) unless v
                  model.fixed = {type: model.fixedType, value: v}
                end
                entry.xpath("./*[contains(local-name(),'pattern')]").each do |e| 
                  model.patternType = e.name.gsub('pattern','')
                  v = e.at_xpath('@value').try(:value)
                  v = "FHIR::#{model.patternType}".constantize.parse_xml_entry(e) unless v
                  model.pattern = {type: model.patternType, value: v}
                end
                entry.xpath("./*[contains(local-name(),'example')]").each do |e| 
                  model.exampleType = e.name.gsub('example','')
                  v = e.at_xpath('@value').try(:value)
                  v = "FHIR::#{model.exampleType}".constantize.parse_xml_entry(e) unless v
                  model.example = {type: model.exampleType, value: v}
                end
                set_model_data(model, 'maxLength', entry.at_xpath('./fhir:maxLength/@value').try(:value))
                set_model_data(model, 'condition', entry.xpath('./fhir:condition/@value').map {|e| e.value })
                set_model_data(model, 'constraint', entry.xpath('./fhir:constraint').map {|e| parse_xml_entry_ElementDefinitionConstraintComponent(e)})
                set_model_data(model, 'mustSupport', entry.at_xpath('./fhir:mustSupport/@value').try(:value))
                set_model_data(model, 'isModifier', entry.at_xpath('./fhir:isModifier/@value').try(:value))
                set_model_data(model, 'isSummary', entry.at_xpath('./fhir:isSummary/@value').try(:value))
                set_model_data(model, 'binding', parse_xml_entry_ElementDefinitionBindingComponent(entry.at_xpath('./fhir:binding')))
                set_model_data(model, 'mapping', entry.xpath('./fhir:mapping').map {|e| parse_xml_entry_ElementDefinitionMappingComponent(e)})
                model
            end
        end
    end
end
