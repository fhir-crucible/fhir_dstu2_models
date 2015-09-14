module FHIR
    module Deserializer
        module MedicationAdministration
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_MedicationAdministrationDosageComponent(entry) 
                return nil unless entry
                model = FHIR::MedicationAdministration::MedicationAdministrationDosageComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'text','text',false)
                set_model_data(model, 'siteCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:siteCodeableConcept')))
                set_model_data(model, 'siteReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:siteReference')))
                set_model_data(model, 'route', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:route')))
                set_model_data(model, 'method', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:method')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'rateRatio', FHIR::Ratio.parse_xml_entry(entry.at_xpath('./fhir:rateRatio')))
                set_model_data(model, 'rateRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:rateRange')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'practitioner', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:practitioner')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'prescription', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:prescription')))
                parse_primitive_field(model,entry,'wasNotGiven','wasNotGiven',false)
                set_model_data(model, 'reasonNotGiven', entry.xpath('./fhir:reasonNotGiven').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'reasonGiven', entry.xpath('./fhir:reasonGiven').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'effectiveTimeDateTime','effectiveTimeDateTime',false)
                set_model_data(model, 'effectiveTimePeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:effectiveTimePeriod')))
                set_model_data(model, 'medicationCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:medicationCodeableConcept')))
                set_model_data(model, 'medicationReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:medicationReference')))
                set_model_data(model, 'device', entry.xpath('./fhir:device').map {|e| FHIR::Reference.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'note','note',false)
                set_model_data(model, 'dosage', parse_xml_entry_MedicationAdministrationDosageComponent(entry.at_xpath('./fhir:dosage')))
                model
            end
        end
    end
end
