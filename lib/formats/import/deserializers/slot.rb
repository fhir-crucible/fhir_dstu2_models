module FHIR
    module Deserializer
        module Slot
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'schedule', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:schedule')))
                parse_primitive_field(model,entry,'freeBusyType','freeBusyType',false)
                parse_primitive_field(model,entry,'start','start',false)
                parse_primitive_field(model,entry,'end','end',false)
                parse_primitive_field(model,entry,'overbooked','overbooked',false)
                parse_primitive_field(model,entry,'comment','comment',false)
                model
            end
        end
    end
end
