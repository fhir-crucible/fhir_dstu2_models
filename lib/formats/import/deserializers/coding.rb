module FHIR
    module Deserializer
        module Coding
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'system','system',false)
                parse_primitive_field(model,entry,'version','versionNum',false)
                parse_primitive_field(model,entry,'code','code',false)
                parse_primitive_field(model,entry,'display','display',false)
                parse_primitive_field(model,entry,'userSelected','userSelected',false)
                model
            end
        end
    end
end
