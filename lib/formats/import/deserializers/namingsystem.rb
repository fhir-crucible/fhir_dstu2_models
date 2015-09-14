module FHIR
    module Deserializer
        module NamingSystem
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_NamingSystemContactComponent(entry) 
                return nil unless entry
                model = FHIR::NamingSystem::NamingSystemContactComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_NamingSystemUniqueIdComponent(entry) 
                return nil unless entry
                model = FHIR::NamingSystem::NamingSystemUniqueIdComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'type','fhirType',false)
                parse_primitive_field(model,entry,'value','value',false)
                parse_primitive_field(model,entry,'preferred','preferred',false)
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'kind','kind',false)
                parse_primitive_field(model,entry,'publisher','publisher',false)
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| parse_xml_entry_NamingSystemContactComponent(e)})
                parse_primitive_field(model,entry,'responsible','responsible',false)
                parse_primitive_field(model,entry,'date','date',false)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'useContext', entry.xpath('./fhir:useContext').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'usage','usage',false)
                set_model_data(model, 'uniqueId', entry.xpath('./fhir:uniqueId').map {|e| parse_xml_entry_NamingSystemUniqueIdComponent(e)})
                set_model_data(model, 'replacedBy', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:replacedBy')))
                model
            end
        end
    end
end
