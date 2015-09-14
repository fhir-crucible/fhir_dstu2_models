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
                parse_primitive_field(model,entry,'valueBoolean','valueBoolean',false)
                set_model_data(model, 'valueQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:valueQuantity')))
                set_model_data(model, 'valueRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:valueRange')))
                parse_primitive_field(model,entry,'exclude','exclude',false)
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                model
            end
            
            def parse_xml_entry_GroupMemberComponent(entry) 
                return nil unless entry
                model = FHIR::Group::GroupMemberComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'entity', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:entity')))
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                parse_primitive_field(model,entry,'inactive','inactive',false)
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'type','fhirType',false)
                parse_primitive_field(model,entry,'actual','actual',false)
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'quantity','quantity',false)
                set_model_data(model, 'characteristic', entry.xpath('./fhir:characteristic').map {|e| parse_xml_entry_GroupCharacteristicComponent(e)})
                set_model_data(model, 'member', entry.xpath('./fhir:member').map {|e| parse_xml_entry_GroupMemberComponent(e)})
                model
            end
        end
    end
end
