module FHIR
    module Deserializer
        module CodeableConcept
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'coding', entry.xpath('./fhir:coding').map {|e| FHIR::Coding.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'text','text',false)
                model
            end
        end
    end
end
