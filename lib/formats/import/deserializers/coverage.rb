module FHIR
    module Deserializer
        module Coverage
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'issuer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:issuer')))
                set_model_data(model, 'bin', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:bin')))
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'subscriberId', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:subscriberId')))
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'group', entry.at_xpath('./fhir:group/@value').try(:value))
                set_model_data(model, 'plan', entry.at_xpath('./fhir:plan/@value').try(:value))
                set_model_data(model, 'subPlan', entry.at_xpath('./fhir:subPlan/@value').try(:value))
                set_model_data(model, 'dependent', FHIR::positiveInt.parse_xml_entry(entry.at_xpath('./fhir:dependent')))
                set_model_data(model, 'sequence', FHIR::positiveInt.parse_xml_entry(entry.at_xpath('./fhir:sequence')))
                set_model_data(model, 'subscriber', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subscriber')))
                set_model_data(model, 'network', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:network')))
                set_model_data(model, 'contract', entry.xpath('./fhir:contract').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
        end
    end
end
