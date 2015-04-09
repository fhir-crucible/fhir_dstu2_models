module FHIR
    module Deserializer
        module Procedure
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ProcedureBodySiteComponent(entry) 
                return nil unless entry
                model = FHIR::Procedure::ProcedureBodySiteComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'siteCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:siteCodeableConcept')))
                set_model_data(model, 'siteReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:siteReference')))
                model
            end
            
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
            
            def parse_xml_entry_ProcedureDeviceComponent(entry) 
                return nil unless entry
                model = FHIR::Procedure::ProcedureDeviceComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'action', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:action')))
                set_model_data(model, 'manipulated', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:manipulated')))
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
                set_model_data(model, 'category', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:category')))
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'bodySite', entry.xpath('./fhir:bodySite').map {|e| parse_xml_entry_ProcedureBodySiteComponent(e)})
                set_model_data(model, 'indication', entry.xpath('./fhir:indication').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'performer', entry.xpath('./fhir:performer').map {|e| parse_xml_entry_ProcedurePerformerComponent(e)})
                set_model_data(model, 'performedDateTime', entry.at_xpath('./fhir:performedDateTime/@value').try(:value))
                set_model_data(model, 'performedPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:performedPeriod')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'location', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:location')))
                set_model_data(model, 'outcome', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:outcome')))
                set_model_data(model, 'report', entry.xpath('./fhir:report').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'complication', entry.xpath('./fhir:complication').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'followUp', entry.xpath('./fhir:followUp').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'relatedItem', entry.xpath('./fhir:relatedItem').map {|e| parse_xml_entry_ProcedureRelatedItemComponent(e)})
                set_model_data(model, 'notes', entry.at_xpath('./fhir:notes/@value').try(:value))
                set_model_data(model, 'device', entry.xpath('./fhir:device').map {|e| parse_xml_entry_ProcedureDeviceComponent(e)})
                set_model_data(model, 'used', entry.xpath('./fhir:used').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
        end
    end
end
