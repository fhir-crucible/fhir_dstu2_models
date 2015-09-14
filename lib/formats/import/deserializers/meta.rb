module FHIR
    module Deserializer
        module Meta
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'versionId','versionId',false)
                parse_primitive_field(model,entry,'lastUpdated','lastUpdated',false)
                parse_primitive_field(model,entry,'profile','profile',true)
                set_model_data(model, 'security', entry.xpath('./fhir:security').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'tag', entry.xpath('./fhir:tag').map {|e| FHIR::Coding.parse_xml_entry(e)})
                model
            end
        end
    end
end
