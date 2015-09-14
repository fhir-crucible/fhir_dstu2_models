module FHIR
    module Deserializer
        module Quantity
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'value','value',false)
                parse_primitive_field(model,entry,'comparator','comparator',false)
                parse_primitive_field(model,entry,'unit','unit',false)
                parse_primitive_field(model,entry,'system','system',false)
                parse_primitive_field(model,entry,'code','code',false)
                model
            end
        end
    end
end
