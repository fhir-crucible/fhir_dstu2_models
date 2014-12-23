module FHIR
    module Deserializer
        module Procedure
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ProcedurePerformerComponent(entry) 
                return nil unless entry
                model = FHIR::Procedure::ProcedurePerformerComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'person', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:person')))
                set_model_data(model, 'role', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:role')))
                model
            end
            
            def parse_xml_entry_ProcedureRelatedItemComponent(entry) 
                return nil unless entry
                model = FHIR::Procedure::ProcedureRelatedItemComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'target', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:target')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'bodySite', entry.xpath('./fhir:bodySite').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'indication', entry.xpath('./fhir:indication').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'performer', entry.xpath('./fhir:performer').map {|e| parse_xml_entry_ProcedurePerformerComponent(e)})
                set_model_data(model, 'date', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:date')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'outcome', entry.at_xpath('./fhir:outcome/@value').try(:value))
                set_model_data(model, 'report', entry.xpath('./fhir:report').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'complication', entry.xpath('./fhir:complication').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'followUp', entry.at_xpath('./fhir:followUp/@value').try(:value))
                set_model_data(model, 'relatedItem', entry.xpath('./fhir:relatedItem').map {|e| parse_xml_entry_ProcedureRelatedItemComponent(e)})
                set_model_data(model, 'notes', entry.at_xpath('./fhir:notes/@value').try(:value))
                model
            end
        end
    end
end
