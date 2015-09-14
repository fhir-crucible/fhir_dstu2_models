module FHIR
    module Deserializer
        module DeviceUseStatement
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'bodySiteCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:bodySiteCodeableConcept')))
                set_model_data(model, 'bodySiteReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:bodySiteReference')))
                set_model_data(model, 'whenUsed', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:whenUsed')))
                set_model_data(model, 'device', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:device')))
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'indication', entry.xpath('./fhir:indication').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'notes','notes',true)
                parse_primitive_field(model,entry,'recordedOn','recordedOn',false)
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'timingTiming', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:timingTiming')))
                set_model_data(model, 'timingPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:timingPeriod')))
                parse_primitive_field(model,entry,'timingDateTime','timingDateTime',false)
                model
            end
        end
    end
end
