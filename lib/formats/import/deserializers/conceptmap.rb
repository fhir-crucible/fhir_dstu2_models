module FHIR
    module Deserializer
        module ConceptMap
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ConceptMapContactComponent(entry) 
                return nil unless entry
                model = FHIR::ConceptMap::ConceptMapContactComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_OtherElementComponent(entry) 
                return nil unless entry
                model = FHIR::ConceptMap::OtherElementComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'element','element',false)
                parse_primitive_field(model,entry,'codeSystem','codeSystem',false)
                parse_primitive_field(model,entry,'code','code',false)
                model
            end
            
            def parse_xml_entry_TargetElementComponent(entry) 
                return nil unless entry
                model = FHIR::ConceptMap::TargetElementComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'codeSystem','codeSystem',false)
                parse_primitive_field(model,entry,'code','code',false)
                parse_primitive_field(model,entry,'equivalence','equivalence',false)
                parse_primitive_field(model,entry,'comments','comments',false)
                set_model_data(model, 'dependsOn', entry.xpath('./fhir:dependsOn').map {|e| parse_xml_entry_OtherElementComponent(e)})
                set_model_data(model, 'product', entry.xpath('./fhir:product').map {|e| parse_xml_entry_OtherElementComponent(e)})
                model
            end
            
            def parse_xml_entry_SourceElementComponent(entry) 
                return nil unless entry
                model = FHIR::ConceptMap::SourceElementComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'codeSystem','codeSystem',false)
                parse_primitive_field(model,entry,'code','code',false)
                set_model_data(model, 'target', entry.xpath('./fhir:target').map {|e| parse_xml_entry_TargetElementComponent(e)})
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
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| parse_xml_entry_ConceptMapContactComponent(e)})
                parse_primitive_field(model,entry,'date','date',false)
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'useContext', entry.xpath('./fhir:useContext').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'requirements','requirements',false)
                parse_primitive_field(model,entry,'copyright','copyright',false)
                parse_primitive_field(model,entry,'sourceUri','sourceUri',false)
                set_model_data(model, 'sourceReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:sourceReference')))
                parse_primitive_field(model,entry,'targetUri','targetUri',false)
                set_model_data(model, 'targetReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:targetReference')))
                set_model_data(model, 'element', entry.xpath('./fhir:element').map {|e| parse_xml_entry_SourceElementComponent(e)})
                model
            end
        end
    end
end
