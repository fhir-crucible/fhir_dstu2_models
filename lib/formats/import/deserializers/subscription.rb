module FHIR
    module Deserializer
        module Subscription
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_SubscriptionChannelComponent(entry) 
                return nil unless entry
                model = FHIR::Subscription::SubscriptionChannelComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'endpoint', entry.at_xpath('./fhir:endpoint/@value').try(:value))
                set_model_data(model, 'payload', entry.at_xpath('./fhir:payload/@value').try(:value))
                set_model_data(model, 'header', entry.at_xpath('./fhir:header/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'criteria', entry.at_xpath('./fhir:criteria/@value').try(:value))
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                set_model_data(model, 'reason', entry.at_xpath('./fhir:reason/@value').try(:value))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'error', entry.at_xpath('./fhir:error/@value').try(:value))
                set_model_data(model, 'channel', parse_xml_entry_SubscriptionChannelComponent(entry.at_xpath('./fhir:channel')))
                set_model_data(model, 'end', parse_date_time(entry.at_xpath('./fhir:end/@value').try(:value)))
                set_model_data(model, 'tag', entry.xpath('./fhir:tag').map {|e| FHIR::Coding.parse_xml_entry(e)})
                model
            end
        end
    end
end
