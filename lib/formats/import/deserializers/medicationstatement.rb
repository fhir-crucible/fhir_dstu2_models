module FHIR
    module Deserializer
        module MedicationStatement
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_MedicationStatementDosageComponent(entry) 
                return nil unless entry
                model = FHIR::MedicationStatement::MedicationStatementDosageComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'text','text',false)
                set_model_data(model, 'timing', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:timing')))
                parse_primitive_field(model,entry,'asNeededBoolean','asNeededBoolean',false)
                set_model_data(model, 'asNeededCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:asNeededCodeableConcept')))
                set_model_data(model, 'siteCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:siteCodeableConcept')))
                set_model_data(model, 'siteReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:siteReference')))
                set_model_data(model, 'route', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:route')))
                set_model_data(model, 'method', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:method')))
                set_model_data(model, 'quantityQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantityQuantity')))
                set_model_data(model, 'quantityRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:quantityRange')))
                set_model_data(model, 'rateRatio', FHIR::Ratio.parse_xml_entry(entry.at_xpath('./fhir:rateRatio')))
                set_model_data(model, 'rateRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:rateRange')))
                set_model_data(model, 'maxDosePerPeriod', FHIR::Ratio.parse_xml_entry(entry.at_xpath('./fhir:maxDosePerPeriod')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'informationSource', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:informationSource')))
                parse_primitive_field(model,entry,'dateAsserted','dateAsserted',false)
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'wasNotTaken','wasNotTaken',false)
                set_model_data(model, 'reasonNotTaken', entry.xpath('./fhir:reasonNotTaken').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'reasonForUseCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:reasonForUseCodeableConcept')))
                set_model_data(model, 'reasonForUseReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:reasonForUseReference')))
                parse_primitive_field(model,entry,'effectiveDateTime','effectiveDateTime',false)
                set_model_data(model, 'effectivePeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:effectivePeriod')))
                parse_primitive_field(model,entry,'note','note',false)
                set_model_data(model, 'supportingInformation', entry.xpath('./fhir:supportingInformation').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'medicationCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:medicationCodeableConcept')))
                set_model_data(model, 'medicationReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:medicationReference')))
                set_model_data(model, 'dosage', entry.xpath('./fhir:dosage').map {|e| parse_xml_entry_MedicationStatementDosageComponent(e)})
                model
            end
        end
    end
end
