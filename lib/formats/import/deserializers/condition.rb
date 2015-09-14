module FHIR
    module Deserializer
        module Condition
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ConditionStageComponent(entry) 
                return nil unless entry
                model = FHIR::Condition::ConditionStageComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'summary', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:summary')))
                set_model_data(model, 'assessment', entry.xpath('./fhir:assessment').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_ConditionEvidenceComponent(entry) 
                return nil unless entry
                model = FHIR::Condition::ConditionEvidenceComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'detail', entry.xpath('./fhir:detail').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'asserter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:asserter')))
                parse_primitive_field(model,entry,'dateRecorded','dateRecorded',false)
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'category', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:category')))
                parse_primitive_field(model,entry,'clinicalStatus','clinicalStatus',false)
                parse_primitive_field(model,entry,'verificationStatus','verificationStatus',false)
                set_model_data(model, 'severity', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:severity')))
                parse_primitive_field(model,entry,'onsetDateTime','onsetDateTime',false)
                set_model_data(model, 'onsetQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:onsetQuantity')))
                set_model_data(model, 'onsetPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:onsetPeriod')))
                set_model_data(model, 'onsetRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:onsetRange')))
                parse_primitive_field(model,entry,'onsetString','onsetString',false)
                parse_primitive_field(model,entry,'abatementDateTime','abatementDateTime',false)
                set_model_data(model, 'abatementQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:abatementQuantity')))
                parse_primitive_field(model,entry,'abatementBoolean','abatementBoolean',false)
                set_model_data(model, 'abatementPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:abatementPeriod')))
                set_model_data(model, 'abatementRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:abatementRange')))
                parse_primitive_field(model,entry,'abatementString','abatementString',false)
                set_model_data(model, 'stage', parse_xml_entry_ConditionStageComponent(entry.at_xpath('./fhir:stage')))
                set_model_data(model, 'evidence', entry.xpath('./fhir:evidence').map {|e| parse_xml_entry_ConditionEvidenceComponent(e)})
                set_model_data(model, 'bodySite', entry.xpath('./fhir:bodySite').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'notes','notes',false)
                model
            end
        end
    end
end
