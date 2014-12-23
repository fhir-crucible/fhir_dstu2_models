module FHIR
    module Deserializer
        module Timing
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_TimingRepeatComponent(entry) 
                return nil unless entry
                model = FHIR::Timing::TimingRepeatComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'frequency', entry.at_xpath('./fhir:frequency/@value').try(:value))
                set_model_data(model, 'when', entry.at_xpath('./fhir:when/@value').try(:value))
                set_model_data(model, 'duration', entry.at_xpath('./fhir:duration/@value').try(:value))
                set_model_data(model, 'units', entry.at_xpath('./fhir:units/@value').try(:value))
                set_model_data(model, 'count', entry.at_xpath('./fhir:count/@value').try(:value))
                set_model_data(model, 'end', entry.at_xpath('./fhir:end/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'event', entry.xpath('./fhir:event').map {|e| FHIR::Period.parse_xml_entry(e)})
                set_model_data(model, 'repeat', parse_xml_entry_TimingRepeatComponent(entry.at_xpath('./fhir:repeat')))
                model
            end
        end
    end
end
