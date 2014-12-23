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
                set_model_data(model, 'eye', entry.at_xpath('./fhir:eye/@value').try(:value))
                set_model_data(model, 'sphere', entry.at_xpath('./fhir:sphere/@value').try(:value))
                set_model_data(model, 'cylinder', entry.at_xpath('./fhir:cylinder/@value').try(:value))
                set_model_data(model, 'axis', entry.at_xpath('./fhir:axis/@value').try(:value))
                set_model_data(model, 'prism', entry.at_xpath('./fhir:prism/@value').try(:value))
                set_model_data(model, 'base', entry.at_xpath('./fhir:base/@value').try(:value))
                set_model_data(model, 'add', entry.at_xpath('./fhir:add/@value').try(:value))
                set_model_data(model, 'power', entry.at_xpath('./fhir:power/@value').try(:value))
                set_model_data(model, 'backCurve', entry.at_xpath('./fhir:backCurve/@value').try(:value))
                set_model_data(model, 'diameter', entry.at_xpath('./fhir:diameter/@value').try(:value))
                set_model_data(model, 'duration', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:duration')))
                set_model_data(model, 'color', entry.at_xpath('./fhir:color/@value').try(:value))
                set_model_data(model, 'brand', entry.at_xpath('./fhir:brand/@value').try(:value))
                set_model_data(model, 'notes', entry.at_xpath('./fhir:notes/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'dateWritten', entry.at_xpath('./fhir:dateWritten/@value').try(:value))
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
