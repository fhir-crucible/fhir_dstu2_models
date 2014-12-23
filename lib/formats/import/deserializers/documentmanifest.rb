module FHIR
    module Deserializer
        module DocumentManifest
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'masterIdentifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:masterIdentifier')))
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'subject', entry.xpath('./fhir:subject').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'recipient', entry.xpath('./fhir:recipient').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'author', entry.xpath('./fhir:author').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'created', entry.at_xpath('./fhir:created/@value').try(:value))
                set_model_data(model, 'source', entry.at_xpath('./fhir:source/@value').try(:value))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'supercedes', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:supercedes')))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'confidentiality', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:confidentiality')))
                set_model_data(model, 'content', entry.xpath('./fhir:content').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
        end
    end
end
