module FHIR
    module Deserializer
        module ProcessRequest
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ItemsComponent(entry) 
                return nil unless entry
                model = FHIR::ProcessRequest::ItemsComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'sequenceLinkId','sequenceLinkId',false)
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                parse_primitive_field(model,entry,'action','action',false)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'ruleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:ruleset')))
                set_model_data(model, 'originalRuleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:originalRuleset')))
                parse_primitive_field(model,entry,'created','created',false)
                set_model_data(model, 'target', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:target')))
                set_model_data(model, 'provider', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:provider')))
                set_model_data(model, 'organization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:organization')))
                set_model_data(model, 'request', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:request')))
                set_model_data(model, 'response', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:response')))
                parse_primitive_field(model,entry,'nullify','nullify',false)
                parse_primitive_field(model,entry,'reference','reference',false)
                set_model_data(model, 'item', entry.xpath('./fhir:item').map {|e| parse_xml_entry_ItemsComponent(e)})
                parse_primitive_field(model,entry,'include','include',true)
                parse_primitive_field(model,entry,'exclude','exclude',true)
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                model
            end
        end
    end
end
