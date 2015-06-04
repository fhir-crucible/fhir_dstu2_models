module FHIR
    module Deserializer
        module DeviceMetric
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_DeviceMetricCalibrationComponent(entry) 
                return nil unless entry
                model = FHIR::DeviceMetric::DeviceMetricCalibrationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'state', entry.at_xpath('./fhir:state/@value').try(:value))
                set_model_data(model, 'time', entry.at_xpath('./fhir:time/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'unit', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:unit')))
                set_model_data(model, 'source', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:source')))
                set_model_data(model, 'parent', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:parent')))
                set_model_data(model, 'operationalStatus', entry.at_xpath('./fhir:operationalStatus/@value').try(:value))
                set_model_data(model, 'color', entry.at_xpath('./fhir:color/@value').try(:value))
                set_model_data(model, 'category', entry.at_xpath('./fhir:category/@value').try(:value))
                set_model_data(model, 'measurementPeriod', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:measurementPeriod')))
                set_model_data(model, 'calibration', entry.xpath('./fhir:calibration').map {|e| parse_xml_entry_DeviceMetricCalibrationComponent(e)})
                model
            end
        end
    end
end
