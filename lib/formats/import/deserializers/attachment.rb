module FHIR
    module Deserializer
        module Attachment
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'contentType','contentType',false)
                parse_primitive_field(model,entry,'language','language',false)
                parse_primitive_field(model,entry,'data','data',false)
                parse_primitive_field(model,entry,'url','url',false)
                parse_primitive_field(model,entry,'size','size',false)
                parse_primitive_field(model,entry,'hash','fhirHash',false)
                parse_primitive_field(model,entry,'title','title',false)
                parse_primitive_field(model,entry,'creation','creation',false)
                model
            end
        end
    end
end
