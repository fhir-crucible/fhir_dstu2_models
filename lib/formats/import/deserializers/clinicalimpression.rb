module FHIR
    module Deserializer
        module ClinicalImpression
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ClinicalImpressionInvestigationsComponent(entry) 
                return nil unless entry
                model = FHIR::ClinicalImpression::ClinicalImpressionInvestigationsComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'item', entry.xpath('./fhir:item').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_ClinicalImpressionFindingComponent(entry) 
                return nil unless entry
                model = FHIR::ClinicalImpression::ClinicalImpressionFindingComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'item', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:item')))
                parse_primitive_field(model,entry,'cause','cause',false)
                model
            end
            
            def parse_xml_entry_ClinicalImpressionRuledOutComponent(entry) 
                return nil unless entry
                model = FHIR::ClinicalImpression::ClinicalImpressionRuledOutComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'item', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:item')))
                parse_primitive_field(model,entry,'reason','reason',false)
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'assessor', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:assessor')))
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'date','date',false)
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'previous', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:previous')))
                set_model_data(model, 'problem', entry.xpath('./fhir:problem').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'triggerCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:triggerCodeableConcept')))
                set_model_data(model, 'triggerReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:triggerReference')))
                set_model_data(model, 'investigations', entry.xpath('./fhir:investigations').map {|e| parse_xml_entry_ClinicalImpressionInvestigationsComponent(e)})
                parse_primitive_field(model,entry,'protocol','protocol',false)
                parse_primitive_field(model,entry,'summary','summary',false)
                set_model_data(model, 'finding', entry.xpath('./fhir:finding').map {|e| parse_xml_entry_ClinicalImpressionFindingComponent(e)})
                set_model_data(model, 'resolved', entry.xpath('./fhir:resolved').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'ruledOut', entry.xpath('./fhir:ruledOut').map {|e| parse_xml_entry_ClinicalImpressionRuledOutComponent(e)})
                parse_primitive_field(model,entry,'prognosis','prognosis',false)
                set_model_data(model, 'plan', entry.xpath('./fhir:plan').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'action', entry.xpath('./fhir:action').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
        end
    end
end
