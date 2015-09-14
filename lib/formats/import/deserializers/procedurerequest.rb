module FHIR
    module Deserializer
        module ProcedureRequest
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'bodySite', entry.xpath('./fhir:bodySite').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'reasonCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:reasonCodeableConcept')))
                set_model_data(model, 'reasonReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:reasonReference')))
                parse_primitive_field(model,entry,'scheduledDateTime','scheduledDateTime',false)
                set_model_data(model, 'scheduledPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:scheduledPeriod')))
                set_model_data(model, 'scheduledTiming', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:scheduledTiming')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'performer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:performer')))
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'notes', entry.xpath('./fhir:notes').map {|e| FHIR::Annotation.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'asNeededBoolean','asNeededBoolean',false)
                set_model_data(model, 'asNeededCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:asNeededCodeableConcept')))
                parse_primitive_field(model,entry,'orderedOn','orderedOn',false)
                set_model_data(model, 'orderer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:orderer')))
                parse_primitive_field(model,entry,'priority','priority',false)
                model
            end
        end
    end
end
