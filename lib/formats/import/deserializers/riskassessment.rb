module FHIR
    module Deserializer
        module RiskAssessment
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_RiskAssessmentPredictionComponent(entry) 
                return nil unless entry
                model = FHIR::RiskAssessment::RiskAssessmentPredictionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'outcome', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:outcome')))
                set_model_data(model, 'probabilityDecimal', entry.at_xpath('./fhir:probabilityDecimal/@value').try(:value))
                set_model_data(model, 'probabilityRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:probabilityRange')))
                set_model_data(model, 'probabilityCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:probabilityCodeableConcept')))
                set_model_data(model, 'relativeRisk', entry.at_xpath('./fhir:relativeRisk/@value').try(:value))
                set_model_data(model, 'whenPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:whenPeriod')))
                set_model_data(model, 'whenRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:whenRange')))
                set_model_data(model, 'rationale', entry.at_xpath('./fhir:rationale/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'condition', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:condition')))
                set_model_data(model, 'performer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:performer')))
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'method', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:method')))
                set_model_data(model, 'basis', entry.xpath('./fhir:basis').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'prediction', entry.xpath('./fhir:prediction').map {|e| parse_xml_entry_RiskAssessmentPredictionComponent(e)})
                set_model_data(model, 'mitigation', entry.at_xpath('./fhir:mitigation/@value').try(:value))
                model
            end
        end
    end
end
