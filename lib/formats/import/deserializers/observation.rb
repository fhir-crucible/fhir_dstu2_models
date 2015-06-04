module FHIR
    module Deserializer
        module Observation
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ObservationReferenceRangeComponent(entry) 
                return nil unless entry
                model = FHIR::Observation::ObservationReferenceRangeComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'low', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:low')))
                set_model_data(model, 'high', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:high')))
                set_model_data(model, 'meaning', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:meaning')))
                set_model_data(model, 'age', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:age')))
                set_model_data(model, 'text', entry.at_xpath('./fhir:text/@value').try(:value))
                model
            end
            
            def parse_xml_entry_ObservationRelatedComponent(entry) 
                return nil unless entry
                model = FHIR::Observation::ObservationRelatedComponent.new
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
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'valueQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:valueQuantity')))
                set_model_data(model, 'valueCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:valueCodeableConcept')))
                set_model_data(model, 'valueString', entry.at_xpath('./fhir:valueString/@value').try(:value))
                set_model_data(model, 'valueRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:valueRange')))
                set_model_data(model, 'valueRatio', FHIR::Ratio.parse_xml_entry(entry.at_xpath('./fhir:valueRatio')))
                set_model_data(model, 'valueSampledData', FHIR::SampledData.parse_xml_entry(entry.at_xpath('./fhir:valueSampledData')))
                set_model_data(model, 'valueAttachment', FHIR::Attachment.parse_xml_entry(entry.at_xpath('./fhir:valueAttachment')))
                set_model_data(model, 'valueTime', entry.at_xpath('./fhir:valueTime/@value').try(:value))
                set_model_data(model, 'valueDateTime', entry.at_xpath('./fhir:valueDateTime/@value').try(:value))
                set_model_data(model, 'valuePeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:valuePeriod')))
                set_model_data(model, 'dataAbsentReason', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:dataAbsentReason')))
                set_model_data(model, 'interpretation', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:interpretation')))
                set_model_data(model, 'comments', entry.at_xpath('./fhir:comments/@value').try(:value))
                set_model_data(model, 'appliesDateTime', entry.at_xpath('./fhir:appliesDateTime/@value').try(:value))
                set_model_data(model, 'appliesPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:appliesPeriod')))
                set_model_data(model, 'issued', entry.at_xpath('./fhir:issued/@value').try(:value))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'reliability', entry.at_xpath('./fhir:reliability/@value').try(:value))
                set_model_data(model, 'bodySiteCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:bodySiteCodeableConcept')))
                set_model_data(model, 'bodySiteReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:bodySiteReference')))
                set_model_data(model, 'method', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:method')))
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'specimen', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:specimen')))
                set_model_data(model, 'performer', entry.xpath('./fhir:performer').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'device', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:device')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'referenceRange', entry.xpath('./fhir:referenceRange').map {|e| parse_xml_entry_ObservationReferenceRangeComponent(e)})
                set_model_data(model, 'related', entry.xpath('./fhir:related').map {|e| parse_xml_entry_ObservationRelatedComponent(e)})
                model
            end
        end
    end
end
