module FHIR
    module Deserializer
        module VisionPrescription
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_VisionPrescriptionDispenseComponent(entry) 
                return nil unless entry
                model = FHIR::VisionPrescription::VisionPrescriptionDispenseComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'product', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:product')))
                parse_primitive_field(model,entry,'eye','eye',false)
                parse_primitive_field(model,entry,'sphere','sphere',false)
                parse_primitive_field(model,entry,'cylinder','cylinder',false)
                parse_primitive_field(model,entry,'axis','axis',false)
                parse_primitive_field(model,entry,'prism','prism',false)
                parse_primitive_field(model,entry,'base','base',false)
                parse_primitive_field(model,entry,'add','add',false)
                parse_primitive_field(model,entry,'power','power',false)
                parse_primitive_field(model,entry,'backCurve','backCurve',false)
                parse_primitive_field(model,entry,'diameter','diameter',false)
                set_model_data(model, 'duration', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:duration')))
                parse_primitive_field(model,entry,'color','color',false)
                parse_primitive_field(model,entry,'brand','brand',false)
                parse_primitive_field(model,entry,'notes','notes',false)
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'dateWritten','dateWritten',false)
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'prescriber', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:prescriber')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'reasonCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:reasonCodeableConcept')))
                set_model_data(model, 'reasonReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:reasonReference')))
                set_model_data(model, 'dispense', entry.xpath('./fhir:dispense').map {|e| parse_xml_entry_VisionPrescriptionDispenseComponent(e)})
                model
            end
        end
    end
end
