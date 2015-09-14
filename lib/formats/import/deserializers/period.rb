module FHIR
    module Deserializer
        module Period
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'start','start',false)
                parse_primitive_field(model,entry,'end','end',false)
                model
            end
        end
    end
end
