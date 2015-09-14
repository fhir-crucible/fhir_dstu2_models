module FHIR
    module Deserializer
        module DataElement
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_DataElementContactComponent(entry) 
                return nil unless entry
                model = FHIR::DataElement::DataElementContactComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_DataElementMappingComponent(entry) 
                return nil unless entry
                model = FHIR::DataElement::DataElementMappingComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'identity','fhirIdentity',false)
                parse_primitive_field(model,entry,'uri','uri',false)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'comments','comments',false)
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
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'experimental','experimental',false)
                parse_primitive_field(model,entry,'publisher','publisher',false)
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| parse_xml_entry_DataElementContactComponent(e)})
                parse_primitive_field(model,entry,'date','date',false)
                set_model_data(model, 'useContext', entry.xpath('./fhir:useContext').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'copyright','copyright',false)
                parse_primitive_field(model,entry,'stringency','stringency',false)
                set_model_data(model, 'mapping', entry.xpath('./fhir:mapping').map {|e| parse_xml_entry_DataElementMappingComponent(e)})
                set_model_data(model, 'element', entry.xpath('./fhir:element').map {|e| FHIR::ElementDefinition.parse_xml_entry(e)})
                model
            end
        end
    end
end
