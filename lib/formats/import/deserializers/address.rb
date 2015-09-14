module FHIR
    module Deserializer
        module Address
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'use','use',false)
                parse_primitive_field(model,entry,'type','fhirType',false)
                parse_primitive_field(model,entry,'text','text',false)
                parse_primitive_field(model,entry,'line','line',true)
                parse_primitive_field(model,entry,'city','city',false)
                parse_primitive_field(model,entry,'district','district',false)
                parse_primitive_field(model,entry,'state','state',false)
                parse_primitive_field(model,entry,'postalCode','postalCode',false)
                parse_primitive_field(model,entry,'country','country',false)
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                model
            end
        end
    end
end
