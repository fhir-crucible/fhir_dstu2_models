module FHIR
    module Deserializer
        module Contraindication
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ContraindicationMitigationComponent(entry) 
                return nil unless entry
                model = FHIR::Contraindication::ContraindicationMitigationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'action', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:action')))
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
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
                set_model_data(model, 'severity', entry.at_xpath('./fhir:severity/@value').try(:value))
                set_model_data(model, 'implicated', entry.xpath('./fhir:implicated').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'detail', entry.at_xpath('./fhir:detail/@value').try(:value))
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'author', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:author')))
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'reference', entry.at_xpath('./fhir:reference/@value').try(:value))
                set_model_data(model, 'mitigation', entry.xpath('./fhir:mitigation').map {|e| parse_xml_entry_ContraindicationMitigationComponent(e)})
                model
            end
        end
    end
end
