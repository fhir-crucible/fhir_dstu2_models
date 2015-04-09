module FHIR
    module Deserializer
        module Supply
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_SupplyDispenseComponent(entry) 
                return nil unless entry
                model = FHIR::Supply::SupplyDispenseComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'suppliedItem', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:suppliedItem')))
                set_model_data(model, 'supplier', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:supplier')))
                set_model_data(model, 'whenPrepared', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:whenPrepared')))
                set_model_data(model, 'whenHandedOver', entry.at_xpath('./fhir:whenHandedOver/@value').try(:value))
                set_model_data(model, 'destination', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:destination')))
                set_model_data(model, 'receiver', entry.xpath('./fhir:receiver').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'kind', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:kind')))
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'orderedItem', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:orderedItem')))
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'dispense', entry.xpath('./fhir:dispense').map {|e| parse_xml_entry_SupplyDispenseComponent(e)})
                model
            end
        end
    end
end
