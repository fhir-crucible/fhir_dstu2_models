module FHIR
    module Deserializer
        module Timing
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_TimingRepeatComponent(entry) 
                return nil unless entry
                model = FHIR::Timing::TimingRepeatComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'boundsQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:boundsQuantity')))
                set_model_data(model, 'boundsRange', FHIR::Range.parse_xml_entry(entry.at_xpath('./fhir:boundsRange')))
                set_model_data(model, 'boundsPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:boundsPeriod')))
                parse_primitive_field(model,entry,'count','count',false)
                parse_primitive_field(model,entry,'duration','duration',false)
                parse_primitive_field(model,entry,'durationMax','durationMax',false)
                parse_primitive_field(model,entry,'durationUnits','durationUnits',false)
                parse_primitive_field(model,entry,'frequency','frequency',false)
                parse_primitive_field(model,entry,'frequencyMax','frequencyMax',false)
                parse_primitive_field(model,entry,'period','period',false)
                parse_primitive_field(model,entry,'periodMax','periodMax',false)
                parse_primitive_field(model,entry,'periodUnits','periodUnits',false)
                parse_primitive_field(model,entry,'when','when',false)
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'event','event',true)
                set_model_data(model, 'repeat', parse_xml_entry_TimingRepeatComponent(entry.at_xpath('./fhir:repeat')))
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                model
            end
        end
    end
end
