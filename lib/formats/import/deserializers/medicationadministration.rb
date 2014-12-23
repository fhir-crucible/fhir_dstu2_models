module FHIR
    module Deserializer
        module MedicationAdministration
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_MedicationAdministrationDosageComponent(entry) 
                return nil unless entry
                model = FHIR::MedicationAdministration::MedicationAdministrationDosageComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'timingDateTime', entry.at_xpath('./fhir:timingDateTime/@value').try(:value))
                set_model_data(model, 'timingPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:timingPeriod')))
                set_model_data(model, 'asNeededBoolean', entry.at_xpath('./fhir:asNeededBoolean/@value').try(:value))
                set_model_data(model, 'asNeededCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:asNeededCodeableConcept')))
                set_model_data(model, 'site', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:site')))
                set_model_data(model, 'route', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:route')))
                set_model_data(model, 'method', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:method')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'rate', FHIR::Ratio.parse_xml_entry(entry.at_xpath('./fhir:rate')))
                set_model_data(model, 'maxDosePerPeriod', FHIR::Ratio.parse_xml_entry(entry.at_xpath('./fhir:maxDosePerPeriod')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'practitioner', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:practitioner')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'prescription', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:prescription')))
                set_model_data(model, 'wasNotGiven', entry.at_xpath('./fhir:wasNotGiven/@value').try(:value))
                set_model_data(model, 'reasonNotGiven', entry.xpath('./fhir:reasonNotGiven').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'effectiveTimeDateTime', entry.at_xpath('./fhir:effectiveTimeDateTime/@value').try(:value))
                set_model_data(model, 'effectiveTimePeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:effectiveTimePeriod')))
                set_model_data(model, 'medication', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:medication')))
                set_model_data(model, 'device', entry.xpath('./fhir:device').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'dosage', entry.xpath('./fhir:dosage').map {|e| parse_xml_entry_MedicationAdministrationDosageComponent(e)})
                model
            end
        end
    end
end
