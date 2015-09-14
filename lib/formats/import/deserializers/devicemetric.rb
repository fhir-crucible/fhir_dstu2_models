module FHIR
    module Deserializer
        module DeviceMetric
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_DeviceMetricCalibrationComponent(entry) 
                return nil unless entry
                model = FHIR::DeviceMetric::DeviceMetricCalibrationComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'type','fhirType',false)
                parse_primitive_field(model,entry,'state','state',false)
                parse_primitive_field(model,entry,'time','time',false)
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
                parse_primitive_field(model,entry,'operationalStatus','operationalStatus',false)
                parse_primitive_field(model,entry,'color','color',false)
                parse_primitive_field(model,entry,'category','category',false)
                set_model_data(model, 'measurementPeriod', FHIR::Timing.parse_xml_entry(entry.at_xpath('./fhir:measurementPeriod')))
                set_model_data(model, 'calibration', entry.xpath('./fhir:calibration').map {|e| parse_xml_entry_DeviceMetricCalibrationComponent(e)})
                model
            end
        end
    end
end
