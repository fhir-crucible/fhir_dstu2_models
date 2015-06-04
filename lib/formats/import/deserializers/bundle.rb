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
            
            def parse_xml_entry_BundleEntrySearchComponent(entry) 
                return nil unless entry
                model = FHIR::Bundle::BundleEntrySearchComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'mode', entry.at_xpath('./fhir:mode/@value').try(:value))
                set_model_data(model, 'score', entry.at_xpath('./fhir:score/@value').try(:value))
                model
            end
            
            def parse_xml_entry_BundleEntryTransactionComponent(entry) 
                return nil unless entry
                model = FHIR::Bundle::BundleEntryTransactionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'method', entry.at_xpath('./fhir:method/@value').try(:value))
                set_model_data(model, 'url', entry.at_xpath('./fhir:url/@value').try(:value))
                set_model_data(model, 'ifNoneMatch', entry.at_xpath('./fhir:ifNoneMatch/@value').try(:value))
                set_model_data(model, 'ifMatch', entry.at_xpath('./fhir:ifMatch/@value').try(:value))
                set_model_data(model, 'ifModifiedSince', entry.at_xpath('./fhir:ifModifiedSince/@value').try(:value))
                set_model_data(model, 'ifNoneExist', entry.at_xpath('./fhir:ifNoneExist/@value').try(:value))
                model
            end
            
            def parse_xml_entry_BundleEntryTransactionResponseComponent(entry) 
                return nil unless entry
                model = FHIR::Bundle::BundleEntryTransactionResponseComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'location', entry.at_xpath('./fhir:location/@value').try(:value))
                set_model_data(model, 'etag', entry.at_xpath('./fhir:etag/@value').try(:value))
                set_model_data(model, 'lastModified', entry.at_xpath('./fhir:lastModified/@value').try(:value))
                model
            end
            
            def parse_xml_entry_BundleEntryComponent(entry) 
                return nil unless entry
                model = FHIR::Bundle::BundleEntryComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'base', entry.at_xpath('./fhir:base/@value').try(:value))
                set_model_data(model, 'link', entry.xpath('./fhir:link').map {|e| parse_xml_entry_BundleLinkComponent(e)})
                entry.xpath("./fhir:resource/*").each do |e|
                  model.resourceType = e.name
                  v = "FHIR::#{model.resourceType}".constantize.parse_xml_entry(e) unless v
                  model.resource = v
                  #model.resource = {type: model.resourceType, value: v}
                end
                set_model_data(model, 'search', parse_xml_entry_BundleEntrySearchComponent(entry.at_xpath('./fhir:search')))
                set_model_data(model, 'transaction', parse_xml_entry_BundleEntryTransactionComponent(entry.at_xpath('./fhir:transaction')))
                set_model_data(model, 'transactionResponse', parse_xml_entry_BundleEntryTransactionResponseComponent(entry.at_xpath('./fhir:transactionResponse')))
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
