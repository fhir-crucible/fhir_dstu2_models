module FHIR
    module Deserializer
        module Annotation
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'authorReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:authorReference')))
                parse_primitive_field(model,entry,'authorString','authorString',false)
                parse_primitive_field(model,entry,'time','time',false)
                parse_primitive_field(model,entry,'text','text',false)
                model
            end
        end
    end
end
