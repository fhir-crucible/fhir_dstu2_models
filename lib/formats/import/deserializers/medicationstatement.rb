module FHIR
    module Deserializer
        module MedicationStatement
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_MedicationStatementDosageComponent(entry) 
                return nil unless entry
                model = FHIR::MedicationStatement::MedicationStatementDosageComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'text', entry.at_xpath('./fhir:text/@value').try(:value))
                set_model_data(model, 'schedule', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:schedule')))
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
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'informationSource', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:informationSource')))
                set_model_data(model, 'dateAsserted', entry.at_xpath('./fhir:dateAsserted/@value').try(:value))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'wasNotGiven', entry.at_xpath('./fhir:wasNotGiven/@value').try(:value))
                set_model_data(model, 'reasonNotGiven', entry.xpath('./fhir:reasonNotGiven').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'reasonForUseCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:reasonForUseCodeableConcept')))
                set_model_data(model, 'reasonForUseReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:reasonForUseReference')))
                set_model_data(model, 'effectiveDateTime', entry.at_xpath('./fhir:effectiveDateTime/@value').try(:value))
                set_model_data(model, 'effectivePeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:effectivePeriod')))
                set_model_data(model, 'note', entry.at_xpath('./fhir:note/@value').try(:value))
                set_model_data(model, 'medication', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:medication')))
                set_model_data(model, 'dosage', entry.xpath('./fhir:dosage').map {|e| parse_xml_entry_MedicationStatementDosageComponent(e)})
                model
            end
        end
    end
end
