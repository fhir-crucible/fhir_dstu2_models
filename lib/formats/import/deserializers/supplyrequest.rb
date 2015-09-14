module FHIR
    module Deserializer
        module SupplyRequest
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_SupplyRequestWhenComponent(entry) 
                return nil unless entry
                model = FHIR::SupplyRequest::SupplyRequestWhenComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'schedule', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:schedule')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'source', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:source')))
                parse_primitive_field(model,entry,'date','date',false)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'kind', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:kind')))
                set_model_data(model, 'orderedItem', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:orderedItem')))
                set_model_data(model, 'supplier', entry.xpath('./fhir:supplier').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'reasonCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:reasonCodeableConcept')))
                set_model_data(model, 'reasonReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:reasonReference')))
                set_model_data(model, 'when', parse_xml_entry_SupplyRequestWhenComponent(entry.at_xpath('./fhir:when')))
                model
            end
        end
    end
end
