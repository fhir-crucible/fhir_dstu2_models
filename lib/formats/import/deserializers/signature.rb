module FHIR
    module Deserializer
        module Signature
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.xpath('./fhir:type').map {|e| FHIR::Coding.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'when','when',false)
                parse_primitive_field(model,entry,'whoUri','whoUri',false)
                set_model_data(model, 'whoReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:whoReference')))
                parse_primitive_field(model,entry,'contentType','contentType',false)
                parse_primitive_field(model,entry,'blob','blob',false)
                model
            end
        end
    end
end
