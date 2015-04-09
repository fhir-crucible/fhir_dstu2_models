module FHIR
    module Deserializer
        module MedicationPrescription
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_MedicationPrescriptionDosageInstructionComponent(entry) 
                return nil unless entry
                model = FHIR::MedicationPrescription::MedicationPrescriptionDosageInstructionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'text', entry.at_xpath('./fhir:text/@value').try(:value))
                set_model_data(model, 'additionalInstructions', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:additionalInstructions')))
                set_model_data(model, 'scheduledDateTime', entry.at_xpath('./fhir:scheduledDateTime/@value').try(:value))
                set_model_data(model, 'scheduledPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:scheduledPeriod')))
                set_model_data(model, 'scheduledTiming', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:scheduledTiming')))
                set_model_data(model, 'asNeededBoolean', entry.at_xpath('./fhir:asNeededBoolean/@value').try(:value))
                set_model_data(model, 'asNeededCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:asNeededCodeableConcept')))
                set_model_data(model, 'site', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:site')))
                set_model_data(model, 'route', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:route')))
                set_model_data(model, 'method', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:method')))
                set_model_data(model, 'doseRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:doseRange')))
                set_model_data(model, 'doseQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:doseQuantity')))
                set_model_data(model, 'rate', FHIR::Ratio.parse_xml_entry(entry.at_xpath('./fhir:rate')))
                set_model_data(model, 'maxDosePerPeriod', FHIR::Ratio.parse_xml_entry(entry.at_xpath('./fhir:maxDosePerPeriod')))
                model
            end
            
            def parse_xml_entry_MedicationPrescriptionDispenseComponent(entry) 
                return nil unless entry
                model = FHIR::MedicationPrescription::MedicationPrescriptionDispenseComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'medication', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:medication')))
                set_model_data(model, 'validityPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:validityPeriod')))
                set_model_data(model, 'numberOfRepeatsAllowed', FHIR::positiveInt.parse_xml_entry(entry.at_xpath('./fhir:numberOfRepeatsAllowed')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'expectedSupplyDuration', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:expectedSupplyDuration')))
                model
            end
            
            def parse_xml_entry_MedicationPrescriptionSubstitutionComponent(entry) 
                return nil unless entry
                model = FHIR::MedicationPrescription::MedicationPrescriptionSubstitutionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'reason', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:reason')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'dateWritten', entry.at_xpath('./fhir:dateWritten/@value').try(:value))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'prescriber', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:prescriber')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'reasonCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:reasonCodeableConcept')))
                set_model_data(model, 'reasonReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:reasonReference')))
                set_model_data(model, 'note', entry.at_xpath('./fhir:note/@value').try(:value))
                set_model_data(model, 'medication', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:medication')))
                set_model_data(model, 'dosageInstruction', entry.xpath('./fhir:dosageInstruction').map {|e| parse_xml_entry_MedicationPrescriptionDosageInstructionComponent(e)})
                set_model_data(model, 'dispense', parse_xml_entry_MedicationPrescriptionDispenseComponent(entry.at_xpath('./fhir:dispense')))
                set_model_data(model, 'substitution', parse_xml_entry_MedicationPrescriptionSubstitutionComponent(entry.at_xpath('./fhir:substitution')))
                model
            end
        end
    end
end
