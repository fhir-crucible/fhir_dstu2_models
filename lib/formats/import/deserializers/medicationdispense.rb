module FHIR
    module Deserializer
        module MedicationDispense
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_MedicationDispenseDosageInstructionComponent(entry) 
                return nil unless entry
                model = FHIR::MedicationDispense::MedicationDispenseDosageInstructionComponent.new
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
            
            def parse_xml_entry_MedicationDispenseSubstitutionComponent(entry) 
                return nil unless entry
                model = FHIR::MedicationDispense::MedicationDispenseSubstitutionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'reason', entry.xpath('./fhir:reason').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'responsibleParty', entry.xpath('./fhir:responsibleParty').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'dispenser', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:dispenser')))
                set_model_data(model, 'authorizingPrescription', entry.xpath('./fhir:authorizingPrescription').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'daysSupply', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:daysSupply')))
                set_model_data(model, 'medicationCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:medicationCodeableConcept')))
                set_model_data(model, 'medicationReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:medicationReference')))
                parse_primitive_field(model,entry,'whenPrepared','whenPrepared',false)
                parse_primitive_field(model,entry,'whenHandedOver','whenHandedOver',false)
                set_model_data(model, 'destination', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:destination')))
                set_model_data(model, 'receiver', entry.xpath('./fhir:receiver').map {|e| FHIR::Reference.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'note','note',false)
                set_model_data(model, 'dosageInstruction', entry.xpath('./fhir:dosageInstruction').map {|e| parse_xml_entry_MedicationDispenseDosageInstructionComponent(e)})
                set_model_data(model, 'substitution', parse_xml_entry_MedicationDispenseSubstitutionComponent(entry.at_xpath('./fhir:substitution')))
                model
            end
        end
    end
end
