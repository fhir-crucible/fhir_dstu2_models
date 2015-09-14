module FHIR
    module Deserializer
        module FamilyMemberHistory
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_FamilyMemberHistoryConditionComponent(entry) 
                return nil unless entry
                model = FHIR::FamilyMemberHistory::FamilyMemberHistoryConditionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'outcome', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:outcome')))
                set_model_data(model, 'onsetQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:onsetQuantity')))
                set_model_data(model, 'onsetRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:onsetRange')))
                set_model_data(model, 'onsetPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:onsetPeriod')))
                parse_primitive_field(model,entry,'onsetString','onsetString',false)
                set_model_data(model, 'note', FHIR::Annotation.parse_xml_entry(entry.at_xpath('./fhir:note')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                parse_primitive_field(model,entry,'date','date',false)
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'name','name',false)
                set_model_data(model, 'relationship', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:relationship')))
                parse_primitive_field(model,entry,'gender','gender',false)
                set_model_data(model, 'bornPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:bornPeriod')))
                parse_primitive_field(model,entry,'bornDate','bornDate',false)
                parse_primitive_field(model,entry,'bornString','bornString',false)
                set_model_data(model, 'ageQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:ageQuantity')))
                set_model_data(model, 'ageRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:ageRange')))
                parse_primitive_field(model,entry,'ageString','ageString',false)
                parse_primitive_field(model,entry,'deceasedBoolean','deceasedBoolean',false)
                set_model_data(model, 'deceasedQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:deceasedQuantity')))
                set_model_data(model, 'deceasedRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:deceasedRange')))
                parse_primitive_field(model,entry,'deceasedDate','deceasedDate',false)
                parse_primitive_field(model,entry,'deceasedString','deceasedString',false)
                set_model_data(model, 'note', FHIR::Annotation.parse_xml_entry(entry.at_xpath('./fhir:note')))
                set_model_data(model, 'condition', entry.xpath('./fhir:condition').map {|e| parse_xml_entry_FamilyMemberHistoryConditionComponent(e)})
                model
            end
        end
    end
end
