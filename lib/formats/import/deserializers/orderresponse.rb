module FHIR
    module Deserializer
        module OrderResponse
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'request', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:request')))
                parse_primitive_field(model,entry,'date','date',false)
                set_model_data(model, 'who', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:who')))
                parse_primitive_field(model,entry,'orderStatus','orderStatus',false)
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'fulfillment', entry.xpath('./fhir:fulfillment').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
        end
    end
end
