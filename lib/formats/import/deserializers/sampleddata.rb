module FHIR
    module Deserializer
        module SampledData
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'origin', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:origin')))
                parse_primitive_field(model,entry,'period','period',false)
                parse_primitive_field(model,entry,'factor','factor',false)
                parse_primitive_field(model,entry,'lowerLimit','lowerLimit',false)
                parse_primitive_field(model,entry,'upperLimit','upperLimit',false)
                parse_primitive_field(model,entry,'dimensions','dimensions',false)
                parse_primitive_field(model,entry,'data','data',false)
                model
            end
        end
    end
end
