module FHIR
    module Deserializer
        module Immunization
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ImmunizationExplanationComponent(entry) 
                return nil unless entry
                model = FHIR::Immunization::ImmunizationExplanationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'reason', entry.xpath('./fhir:reason').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'refusalReason', entry.xpath('./fhir:refusalReason').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_ImmunizationReactionComponent(entry) 
                return nil unless entry
                model = FHIR::Immunization::ImmunizationReactionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'detail', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:detail')))
                set_model_data(model, 'reported', entry.at_xpath('./fhir:reported/@value').try(:value))
                model
            end
            
            def parse_xml_entry_ImmunizationVaccinationProtocolComponent(entry) 
                return nil unless entry
                model = FHIR::Immunization::ImmunizationVaccinationProtocolComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'doseSequence', entry.at_xpath('./fhir:doseSequence/@value').try(:value))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'authority', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:authority')))
                set_model_data(model, 'series', entry.at_xpath('./fhir:series/@value').try(:value))
                set_model_data(model, 'seriesDoses', entry.at_xpath('./fhir:seriesDoses/@value').try(:value))
                set_model_data(model, 'doseTarget', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:doseTarget')))
                set_model_data(model, 'doseStatus', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:doseStatus')))
                set_model_data(model, 'doseStatusReason', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:doseStatusReason')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'vaccineType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:vaccineType')))
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'refusedIndicator', entry.at_xpath('./fhir:refusedIndicator/@value').try(:value))
                set_model_data(model, 'reported', entry.at_xpath('./fhir:reported/@value').try(:value))
                set_model_data(model, 'performer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:performer')))
                set_model_data(model, 'requester', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:requester')))
                set_model_data(model, 'manufacturer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:manufacturer')))
                set_model_data(model, 'location', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:location')))
                set_model_data(model, 'lotNumber', entry.at_xpath('./fhir:lotNumber/@value').try(:value))
                set_model_data(model, 'expirationDate', entry.at_xpath('./fhir:expirationDate/@value').try(:value))
                set_model_data(model, 'site', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:site')))
                set_model_data(model, 'route', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:route')))
                set_model_data(model, 'doseQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:doseQuantity')))
                set_model_data(model, 'explanation', parse_xml_entry_ImmunizationExplanationComponent(entry.at_xpath('./fhir:explanation')))
                set_model_data(model, 'reaction', entry.xpath('./fhir:reaction').map {|e| parse_xml_entry_ImmunizationReactionComponent(e)})
                set_model_data(model, 'vaccinationProtocol', entry.xpath('./fhir:vaccinationProtocol').map {|e| parse_xml_entry_ImmunizationVaccinationProtocolComponent(e)})
                model
            end
        end
    end
end
