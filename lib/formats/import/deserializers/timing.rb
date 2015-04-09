module FHIR
    module Deserializer
        module Timing
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_TimingRepeatComponent(entry) 
                return nil unless entry
                model = FHIR::Timing::TimingRepeatComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'bounds', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:bounds')))
                set_model_data(model, 'count', entry.at_xpath('./fhir:count/@value').try(:value))
                set_model_data(model, 'duration', entry.at_xpath('./fhir:duration/@value').try(:value))
                set_model_data(model, 'durationUnits', entry.at_xpath('./fhir:durationUnits/@value').try(:value))
                set_model_data(model, 'frequency', entry.at_xpath('./fhir:frequency/@value').try(:value))
                set_model_data(model, 'frequencyMax', entry.at_xpath('./fhir:frequencyMax/@value').try(:value))
                set_model_data(model, 'period', entry.at_xpath('./fhir:period/@value').try(:value))
                set_model_data(model, 'periodMax', entry.at_xpath('./fhir:periodMax/@value').try(:value))
                set_model_data(model, 'periodUnits', entry.at_xpath('./fhir:periodUnits/@value').try(:value))
                set_model_data(model, 'when', entry.at_xpath('./fhir:when/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'event', entry.xpath('./fhir:event/@value').map {|e| e.value })
                set_model_data(model, 'repeat', parse_xml_entry_TimingRepeatComponent(entry.at_xpath('./fhir:repeat')))
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                model
            end
        end
    end
end
