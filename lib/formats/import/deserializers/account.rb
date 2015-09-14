module FHIR
    module Deserializer
        module Account
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'name','name',false)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'activePeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:activePeriod')))
                set_model_data(model, 'currency', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:currency')))
                set_model_data(model, 'balance', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:balance')))
                set_model_data(model, 'coveragePeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:coveragePeriod')))
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'owner', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:owner')))
                parse_primitive_field(model,entry,'description','description',false)
                model
            end
        end
    end
end
