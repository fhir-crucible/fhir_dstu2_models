module FHIR
    module Deserializer
        module ContactPoint
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'system','system',false)
                parse_primitive_field(model,entry,'value','value',false)
                parse_primitive_field(model,entry,'use','use',false)
                parse_primitive_field(model,entry,'rank','rank',false)
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                model
            end
        end
    end
end
