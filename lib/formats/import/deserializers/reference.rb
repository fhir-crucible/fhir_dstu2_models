module FHIR
    module Deserializer
        module Reference
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'reference','reference',false)
                parse_primitive_field(model,entry,'display','display',false)
                model
            end
        end
    end
end
