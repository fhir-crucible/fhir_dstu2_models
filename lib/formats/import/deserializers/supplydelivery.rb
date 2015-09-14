module FHIR
    module Deserializer
        module SupplyDelivery
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'suppliedItem', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:suppliedItem')))
                set_model_data(model, 'supplier', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:supplier')))
                set_model_data(model, 'whenPrepared', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:whenPrepared')))
                parse_primitive_field(model,entry,'time','time',false)
                set_model_data(model, 'destination', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:destination')))
                set_model_data(model, 'receiver', entry.xpath('./fhir:receiver').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
        end
    end
end
