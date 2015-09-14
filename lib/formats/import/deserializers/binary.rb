module FHIR
    module Deserializer
        module Binary
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                parse_primitive_field(model,entry,'contentType','contentType',false)
                parse_primitive_field(model,entry,'content','content',false)
                model
            end
        end
    end
end
