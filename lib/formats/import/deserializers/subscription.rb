module FHIR
    module Deserializer
        module Subscription
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_SubscriptionChannelComponent(entry) 
                return nil unless entry
                model = FHIR::Subscription::SubscriptionChannelComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'type','fhirType',false)
                parse_primitive_field(model,entry,'endpoint','endpoint',false)
                parse_primitive_field(model,entry,'payload','payload',false)
                parse_primitive_field(model,entry,'header','header',false)
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                parse_primitive_field(model,entry,'criteria','criteria',false)
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'reason','reason',false)
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'error','error',false)
                set_model_data(model, 'channel', parse_xml_entry_SubscriptionChannelComponent(entry.at_xpath('./fhir:channel')))
                parse_primitive_field(model,entry,'end','end',false)
                set_model_data(model, 'tag', entry.xpath('./fhir:tag').map {|e| FHIR::Coding.parse_xml_entry(e)})
                model
            end
        end
    end
end
