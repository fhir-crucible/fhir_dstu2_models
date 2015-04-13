module FHIR
    module Deserializer
        module Group
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_GroupCharacteristicComponent(entry) 
                return nil unless entry
                model = FHIR::Group::GroupCharacteristicComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'valueCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:valueCodeableConcept')))
                set_model_data(model, 'valueBoolean', entry.at_xpath('./fhir:valueBoolean/@value').try(:value))
                set_model_data(model, 'valueQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:valueQuantity')))
                set_model_data(model, 'valueRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:valueRange')))
                set_model_data(model, 'exclude', entry.at_xpath('./fhir:exclude/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'actual', entry.at_xpath('./fhir:actual/@value').try(:value))
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'quantity', entry.at_xpath('./fhir:quantity/@value').try(:value))
                set_model_data(model, 'characteristic', entry.xpath('./fhir:characteristic').map {|e| parse_xml_entry_GroupCharacteristicComponent(e)})
                set_model_data(model, 'member', entry.xpath('./fhir:member').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
        end
    end
end
