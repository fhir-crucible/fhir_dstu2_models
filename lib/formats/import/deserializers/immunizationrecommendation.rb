module FHIR
    module Deserializer
        module ImmunizationRecommendation
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ImmunizationRecommendationRecommendationDateCriterionComponent(entry) 
                return nil unless entry
                model = FHIR::ImmunizationRecommendation::ImmunizationRecommendationRecommendationDateCriterionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                parse_primitive_field(model,entry,'value','value',false)
                model
            end
            
            def parse_xml_entry_ImmunizationRecommendationRecommendationProtocolComponent(entry) 
                return nil unless entry
                model = FHIR::ImmunizationRecommendation::ImmunizationRecommendationRecommendationProtocolComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'doseSequence','doseSequence',false)
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'authority', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:authority')))
                parse_primitive_field(model,entry,'series','series',false)
                model
            end
            
            def parse_xml_entry_ImmunizationRecommendationRecommendationComponent(entry) 
                return nil unless entry
                model = FHIR::ImmunizationRecommendation::ImmunizationRecommendationRecommendationComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'date','date',false)
                set_model_data(model, 'vaccineCode', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:vaccineCode')))
                parse_primitive_field(model,entry,'doseNumber','doseNumber',false)
                set_model_data(model, 'forecastStatus', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:forecastStatus')))
                set_model_data(model, 'dateCriterion', entry.xpath('./fhir:dateCriterion').map {|e| parse_xml_entry_ImmunizationRecommendationRecommendationDateCriterionComponent(e)})
                set_model_data(model, 'protocol', parse_xml_entry_ImmunizationRecommendationRecommendationProtocolComponent(entry.at_xpath('./fhir:protocol')))
                set_model_data(model, 'supportingImmunization', entry.xpath('./fhir:supportingImmunization').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'supportingPatientInformation', entry.xpath('./fhir:supportingPatientInformation').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'recommendation', entry.xpath('./fhir:recommendation').map {|e| parse_xml_entry_ImmunizationRecommendationRecommendationComponent(e)})
                model
            end
        end
    end
end
