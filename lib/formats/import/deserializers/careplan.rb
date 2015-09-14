module FHIR
    module Deserializer
        module CarePlan
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_CarePlanRelatedPlanComponent(entry) 
                return nil unless entry
                model = FHIR::CarePlan::CarePlanRelatedPlanComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'code','code',false)
                set_model_data(model, 'plan', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:plan')))
                model
            end
            
            def parse_xml_entry_CarePlanParticipantComponent(entry) 
                return nil unless entry
                model = FHIR::CarePlan::CarePlanParticipantComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'role', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:role')))
                set_model_data(model, 'member', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:member')))
                model
            end
            
            def parse_xml_entry_CarePlanActivityDetailComponent(entry) 
                return nil unless entry
                model = FHIR::CarePlan::CarePlanActivityDetailComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'category', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:category')))
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'reasonCode', entry.xpath('./fhir:reasonCode').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'reasonReference', entry.xpath('./fhir:reasonReference').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'goal', entry.xpath('./fhir:goal').map {|e| FHIR::Reference.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'statusReason', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:statusReason')))
                parse_primitive_field(model,entry,'prohibited','prohibited',false)
                set_model_data(model, 'scheduledTiming', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:scheduledTiming')))
                set_model_data(model, 'scheduledPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:scheduledPeriod')))
                parse_primitive_field(model,entry,'scheduledString','scheduledString',false)
                set_model_data(model, 'location', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:location')))
                set_model_data(model, 'performer', entry.xpath('./fhir:performer').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'productCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:productCodeableConcept')))
                set_model_data(model, 'productReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:productReference')))
                set_model_data(model, 'dailyAmount', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:dailyAmount')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                parse_primitive_field(model,entry,'description','description',false)
                model
            end
            
            def parse_xml_entry_CarePlanActivityComponent(entry) 
                return nil unless entry
                model = FHIR::CarePlan::CarePlanActivityComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'actionResulting', entry.xpath('./fhir:actionResulting').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'progress', entry.xpath('./fhir:progress').map {|e| FHIR::Annotation.parse_xml_entry(e)})
                set_model_data(model, 'reference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:reference')))
                set_model_data(model, 'detail', parse_xml_entry_CarePlanActivityDetailComponent(entry.at_xpath('./fhir:detail')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'context', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:context')))
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                set_model_data(model, 'author', entry.xpath('./fhir:author').map {|e| FHIR::Reference.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'modified','modified',false)
                set_model_data(model, 'category', entry.xpath('./fhir:category').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'addresses', entry.xpath('./fhir:addresses').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'support', entry.xpath('./fhir:support').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'relatedPlan', entry.xpath('./fhir:relatedPlan').map {|e| parse_xml_entry_CarePlanRelatedPlanComponent(e)})
                set_model_data(model, 'participant', entry.xpath('./fhir:participant').map {|e| parse_xml_entry_CarePlanParticipantComponent(e)})
                set_model_data(model, 'goal', entry.xpath('./fhir:goal').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'activity', entry.xpath('./fhir:activity').map {|e| parse_xml_entry_CarePlanActivityComponent(e)})
                set_model_data(model, 'note', FHIR::Annotation.parse_xml_entry(entry.at_xpath('./fhir:note')))
                model
            end
        end
    end
end
