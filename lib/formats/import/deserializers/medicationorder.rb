module FHIR
    module Deserializer
        module MedicationOrder
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_MedicationOrderDosageInstructionComponent(entry) 
                return nil unless entry
                model = FHIR::MedicationOrder::MedicationOrderDosageInstructionComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'text','text',false)
                set_model_data(model, 'additionalInstructions', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:additionalInstructions')))
                set_model_data(model, 'timing', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:timing')))
                parse_primitive_field(model,entry,'asNeededBoolean','asNeededBoolean',false)
                set_model_data(model, 'asNeededCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:asNeededCodeableConcept')))
                set_model_data(model, 'siteCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:siteCodeableConcept')))
                set_model_data(model, 'siteReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:siteReference')))
                set_model_data(model, 'route', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:route')))
                set_model_data(model, 'method', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:method')))
                set_model_data(model, 'doseRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:doseRange')))
                set_model_data(model, 'doseQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:doseQuantity')))
                set_model_data(model, 'rateRatio', FHIR::Ratio.parse_xml_entry(entry.at_xpath('./fhir:rateRatio')))
                set_model_data(model, 'rateRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:rateRange')))
                set_model_data(model, 'maxDosePerPeriod', FHIR::Ratio.parse_xml_entry(entry.at_xpath('./fhir:maxDosePerPeriod')))
                model
            end
            
            def parse_xml_entry_MedicationOrderDispenseRequestComponent(entry) 
                return nil unless entry
                model = FHIR::MedicationOrder::MedicationOrderDispenseRequestComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'medicationCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:medicationCodeableConcept')))
                set_model_data(model, 'medicationReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:medicationReference')))
                set_model_data(model, 'validityPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:validityPeriod')))
                parse_primitive_field(model,entry,'numberOfRepeatsAllowed','numberOfRepeatsAllowed',false)
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'expectedSupplyDuration', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:expectedSupplyDuration')))
                model
            end
            
            def parse_xml_entry_MedicationOrderSubstitutionComponent(entry) 
                return nil unless entry
                model = FHIR::MedicationOrder::MedicationOrderSubstitutionComponent.new
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
                parse_primitive_field(model,entry,'dateWritten','dateWritten',false)
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'dateEnded','dateEnded',false)
                set_model_data(model, 'reasonEnded', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:reasonEnded')))
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'prescriber', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:prescriber')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'reasonCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:reasonCodeableConcept')))
                set_model_data(model, 'reasonReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:reasonReference')))
                parse_primitive_field(model,entry,'note','note',false)
                set_model_data(model, 'medicationCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:medicationCodeableConcept')))
                set_model_data(model, 'medicationReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:medicationReference')))
                set_model_data(model, 'dosageInstruction', entry.xpath('./fhir:dosageInstruction').map {|e| parse_xml_entry_MedicationOrderDosageInstructionComponent(e)})
                set_model_data(model, 'dispenseRequest', parse_xml_entry_MedicationOrderDispenseRequestComponent(entry.at_xpath('./fhir:dispenseRequest')))
                set_model_data(model, 'substitution', parse_xml_entry_MedicationOrderSubstitutionComponent(entry.at_xpath('./fhir:substitution')))
                set_model_data(model, 'priorPrescription', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:priorPrescription')))
                model
            end
        end
    end
end
