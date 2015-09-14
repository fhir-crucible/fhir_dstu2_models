module FHIR
    module Deserializer
        module Narrative
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'status','status',false)
                ignored = ""
                array = entry.xpath("./*[local-name()='div']")
                array.each { |e| ignored += e.to_s }
                set_model_data(model, 'div', ignored )
                model
            end
        end
    end
end
