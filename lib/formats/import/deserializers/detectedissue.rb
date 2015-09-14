module FHIR
    module Deserializer
        module DetectedIssue
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_DetectedIssueMitigationComponent(entry) 
                return nil unless entry
                model = FHIR::DetectedIssue::DetectedIssueMitigationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'action', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:action')))
                parse_primitive_field(model,entry,'date','date',false)
                set_model_data(model, 'author', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:author')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'category', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:category')))
                parse_primitive_field(model,entry,'severity','severity',false)
                set_model_data(model, 'implicated', entry.xpath('./fhir:implicated').map {|e| FHIR::Reference.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'detail','detail',false)
                parse_primitive_field(model,entry,'date','date',false)
                set_model_data(model, 'author', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:author')))
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                parse_primitive_field(model,entry,'reference','reference',false)
                set_model_data(model, 'mitigation', entry.xpath('./fhir:mitigation').map {|e| parse_xml_entry_DetectedIssueMitigationComponent(e)})
                model
            end
        end
    end
end
