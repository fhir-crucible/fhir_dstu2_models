module FHIR
    module Deserializer
        module EnrollmentResponse
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'request', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:request')))
                parse_primitive_field(model,entry,'outcome','outcome',false)
                parse_primitive_field(model,entry,'disposition','disposition',false)
                set_model_data(model, 'ruleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:ruleset')))
                set_model_data(model, 'originalRuleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:originalRuleset')))
                parse_primitive_field(model,entry,'created','created',false)
                set_model_data(model, 'organization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:organization')))
                set_model_data(model, 'requestProvider', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:requestProvider')))
                set_model_data(model, 'requestOrganization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:requestOrganization')))
                model
            end
        end
    end
end
