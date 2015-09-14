module FHIR
    module Deserializer
        module Media
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                parse_primitive_field(model,entry,'type','fhirType',false)
                set_model_data(model, 'subtype', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:subtype')))
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'operator', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:operator')))
                set_model_data(model, 'view', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:view')))
                parse_primitive_field(model,entry,'deviceName','deviceName',false)
                parse_primitive_field(model,entry,'height','height',false)
                parse_primitive_field(model,entry,'width','width',false)
                parse_primitive_field(model,entry,'frames','frames',false)
                parse_primitive_field(model,entry,'duration','duration',false)
                set_model_data(model, 'content', FHIR::Attachment.parse_xml_entry(entry.at_xpath('./fhir:content')))
                model
            end
        end
    end
end
