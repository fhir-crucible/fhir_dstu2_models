module FHIR
    module Deserializer
        module ProcessResponse
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ProcessResponseNotesComponent(entry) 
                return nil unless entry
                model = FHIR::ProcessResponse::ProcessResponseNotesComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                parse_primitive_field(model,entry,'text','text',false)
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'request', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:request')))
                set_model_data(model, 'outcome', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:outcome')))
                parse_primitive_field(model,entry,'disposition','disposition',false)
                set_model_data(model, 'ruleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:ruleset')))
                set_model_data(model, 'originalRuleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:originalRuleset')))
                parse_primitive_field(model,entry,'created','created',false)
                set_model_data(model, 'organization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:organization')))
                set_model_data(model, 'requestProvider', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:requestProvider')))
                set_model_data(model, 'requestOrganization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:requestOrganization')))
                set_model_data(model, 'form', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:form')))
                set_model_data(model, 'notes', entry.xpath('./fhir:notes').map {|e| parse_xml_entry_ProcessResponseNotesComponent(e)})
                set_model_data(model, 'error', entry.xpath('./fhir:error').map {|e| FHIR::Coding.parse_xml_entry(e)})
                model
            end
        end
    end
end
