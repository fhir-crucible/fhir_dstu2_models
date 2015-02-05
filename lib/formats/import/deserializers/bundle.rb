module FHIR
    module Deserializer
        module Bundle
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_BundleLinkComponent(entry) 
                return nil unless entry
                model = FHIR::Bundle::BundleLinkComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'relation', entry.at_xpath('./fhir:relation/@value').try(:value))
                set_model_data(model, 'url', entry.at_xpath('./fhir:url/@value').try(:value))
                model
            end
            
            def parse_xml_entry_BundleEntryDeletedComponent(entry) 
                return nil unless entry
                model = FHIR::Bundle::BundleEntryDeletedComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'resourceId', entry.at_xpath('./fhir:resourceId/@value').try(:value))
                set_model_data(model, 'versionId', entry.at_xpath('./fhir:versionId/@value').try(:value))
                set_model_data(model, 'instant', parse_date_time(entry.at_xpath('./fhir:instant/@value').try(:value)))
                model
            end
            
            def parse_xml_entry_BundleEntryComponent(entry) 
                return nil unless entry
                model = FHIR::Bundle::BundleEntryComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'base', entry.at_xpath('./fhir:base/@value').try(:value))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'search', entry.at_xpath('./fhir:search/@value').try(:value))
                set_model_data(model, 'score', entry.at_xpath('./fhir:score/@value').try(:value))
                set_model_data(model, 'fhirDeleted', parse_xml_entry_BundleEntryDeletedComponent(entry.at_xpath('./fhir:deleted')))
                entry.xpath("./fhir:resource/*").each do |e|
                  model.resourceType = e.name
                  v = "FHIR::#{model.resourceType}".constantize.parse_xml_entry(e) unless v
                  model.resource = v
                  #model.resource = {type: model.resourceType, value: v}
                end
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'base', entry.at_xpath('./fhir:base/@value').try(:value))
                set_model_data(model, 'total', entry.at_xpath('./fhir:total/@value').try(:value))
                set_model_data(model, 'link', entry.xpath('./fhir:link').map {|e| parse_xml_entry_BundleLinkComponent(e)})
                set_model_data(model, 'entry', entry.xpath('./fhir:entry').map {|e| parse_xml_entry_BundleEntryComponent(e)})
                set_model_data(model, 'signature', entry.at_xpath('./fhir:signature/@value').try(:value))
                model
            end
        end
    end
end
