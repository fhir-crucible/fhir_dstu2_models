module FHIR
    module Deserializer
        module DiagnosticOrder
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_DiagnosticOrderEventComponent(entry) 
                return nil unless entry
                model = FHIR::DiagnosticOrder::DiagnosticOrderEventComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'description', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:description')))
                parse_primitive_field(model,entry,'dateTime','dateTime',false)
                set_model_data(model, 'actor', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:actor')))
                model
            end
            
            def parse_xml_entry_DiagnosticOrderItemComponent(entry) 
                return nil unless entry
                model = FHIR::DiagnosticOrder::DiagnosticOrderItemComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'specimen', entry.xpath('./fhir:specimen').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'bodySite', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:bodySite')))
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'event', entry.xpath('./fhir:event').map {|e| parse_xml_entry_DiagnosticOrderEventComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'orderer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:orderer')))
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'reason', entry.xpath('./fhir:reason').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'supportingInformation', entry.xpath('./fhir:supportingInformation').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'specimen', entry.xpath('./fhir:specimen').map {|e| FHIR::Reference.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'priority','priority',false)
                set_model_data(model, 'event', entry.xpath('./fhir:event').map {|e| parse_xml_entry_DiagnosticOrderEventComponent(e)})
                set_model_data(model, 'item', entry.xpath('./fhir:item').map {|e| parse_xml_entry_DiagnosticOrderItemComponent(e)})
                set_model_data(model, 'note', entry.xpath('./fhir:note').map {|e| FHIR::Annotation.parse_xml_entry(e)})
                model
            end
        end
    end
end
