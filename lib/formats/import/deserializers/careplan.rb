module FHIR
    module Deserializer
        module CarePlan
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
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
                set_model_data(model, 'category', entry.at_xpath('./fhir:category/@value').try(:value))
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'reasonCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:reasonCodeableConcept')))
                set_model_data(model, 'reasonReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:reasonReference')))
                set_model_data(model, 'goal', entry.xpath('./fhir:goal').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'statusReason', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:statusReason')))
                set_model_data(model, 'prohibited', entry.at_xpath('./fhir:prohibited/@value').try(:value))
                set_model_data(model, 'scheduledTiming', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:scheduledTiming')))
                set_model_data(model, 'scheduledPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:scheduledPeriod')))
                set_model_data(model, 'scheduledString', entry.at_xpath('./fhir:scheduledString/@value').try(:value))
                set_model_data(model, 'location', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:location')))
                set_model_data(model, 'performer', entry.xpath('./fhir:performer').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'product', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:product')))
                set_model_data(model, 'dailyAmount', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:dailyAmount')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'note', entry.at_xpath('./fhir:note/@value').try(:value))
                model
            end
            
            def parse_xml_entry_CarePlanActivityComponent(entry) 
                return nil unless entry
                model = FHIR::CarePlan::CarePlanActivityComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'actionResulting', entry.xpath('./fhir:actionResulting').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'notes', entry.at_xpath('./fhir:notes/@value').try(:value))
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
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                set_model_data(model, 'author', entry.xpath('./fhir:author').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'modified', entry.at_xpath('./fhir:modified/@value').try(:value))
                set_model_data(model, 'category', entry.xpath('./fhir:category').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'concern', entry.xpath('./fhir:concern').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'support', entry.xpath('./fhir:support').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'participant', entry.xpath('./fhir:participant').map {|e| parse_xml_entry_CarePlanParticipantComponent(e)})
                set_model_data(model, 'goal', entry.xpath('./fhir:goal').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'activity', entry.xpath('./fhir:activity').map {|e| parse_xml_entry_CarePlanActivityComponent(e)})
                set_model_data(model, 'notes', entry.at_xpath('./fhir:notes/@value').try(:value))
                model
            end
        end
    end
end
