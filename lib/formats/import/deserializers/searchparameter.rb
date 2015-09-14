module FHIR
    module Deserializer
        module SearchParameter
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_SearchParameterContactComponent(entry) 
                return nil unless entry
                model = FHIR::SearchParameter::SearchParameterContactComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                parse_primitive_field(model,entry,'url','url',false)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'experimental','experimental',false)
                parse_primitive_field(model,entry,'publisher','publisher',false)
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| parse_xml_entry_SearchParameterContactComponent(e)})
                parse_primitive_field(model,entry,'date','date',false)
                parse_primitive_field(model,entry,'requirements','requirements',false)
                parse_primitive_field(model,entry,'code','code',false)
                parse_primitive_field(model,entry,'base','base',false)
                parse_primitive_field(model,entry,'type','fhirType',false)
                parse_primitive_field(model,entry,'description','description',false)
                parse_primitive_field(model,entry,'xpath','xpath',false)
                parse_primitive_field(model,entry,'xpathUsage','xpathUsage',false)
                parse_primitive_field(model,entry,'target','target',true)
                model
            end
        end
    end
end
