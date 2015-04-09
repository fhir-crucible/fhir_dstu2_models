module FHIR
    module Deserializer
        module ProcedureRequest
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ProcedureRequestBodySiteComponent(entry) 
                return nil unless entry
                model = FHIR::ProcedureRequest::ProcedureRequestBodySiteComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'siteCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:siteCodeableConcept')))
                set_model_data(model, 'siteReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:siteReference')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'bodySite', entry.xpath('./fhir:bodySite').map {|e| parse_xml_entry_ProcedureRequestBodySiteComponent(e)})
                set_model_data(model, 'indication', entry.xpath('./fhir:indication').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'timingDateTime', entry.at_xpath('./fhir:timingDateTime/@value').try(:value))
                set_model_data(model, 'timingPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:timingPeriod')))
                set_model_data(model, 'timingTiming', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:timingTiming')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'performer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:performer')))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'notes', entry.xpath('./fhir:notes/@value').map {|e| e.value })
                set_model_data(model, 'asNeededBoolean', entry.at_xpath('./fhir:asNeededBoolean/@value').try(:value))
                set_model_data(model, 'asNeededCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:asNeededCodeableConcept')))
                set_model_data(model, 'orderedOn', entry.at_xpath('./fhir:orderedOn/@value').try(:value))
                set_model_data(model, 'orderer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:orderer')))
                set_model_data(model, 'priority', entry.at_xpath('./fhir:priority/@value').try(:value))
                model
            end
        end
    end
end
