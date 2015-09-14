module FHIR
    module Deserializer
        module HumanName
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'use','use',false)
                parse_primitive_field(model,entry,'text','text',false)
                parse_primitive_field(model,entry,'family','family',true)
                parse_primitive_field(model,entry,'given','given',true)
                parse_primitive_field(model,entry,'prefix','prefix',true)
                parse_primitive_field(model,entry,'suffix','suffix',true)
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                model
            end
        end
    end
end
