module FHIR
    module Deserializer
        module Bundle
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_BundleLinkComponent(entry) 
                return nil unless entry
                model = FHIR::Bundle::BundleLinkComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'relation','relation',false)
                parse_primitive_field(model,entry,'url','url',false)
                model
            end
            
            def parse_xml_entry_BundleEntrySearchComponent(entry) 
                return nil unless entry
                model = FHIR::Bundle::BundleEntrySearchComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'mode','mode',false)
                parse_primitive_field(model,entry,'score','score',false)
                model
            end
            
            def parse_xml_entry_BundleEntryRequestComponent(entry) 
                return nil unless entry
                model = FHIR::Bundle::BundleEntryRequestComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'method','method',false)
                parse_primitive_field(model,entry,'url','url',false)
                parse_primitive_field(model,entry,'ifNoneMatch','ifNoneMatch',false)
                parse_primitive_field(model,entry,'ifModifiedSince','ifModifiedSince',false)
                parse_primitive_field(model,entry,'ifMatch','ifMatch',false)
                parse_primitive_field(model,entry,'ifNoneExist','ifNoneExist',false)
                model
            end
            
            def parse_xml_entry_BundleEntryResponseComponent(entry) 
                return nil unless entry
                model = FHIR::Bundle::BundleEntryResponseComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'location','location',false)
                parse_primitive_field(model,entry,'etag','etag',false)
                parse_primitive_field(model,entry,'lastModified','lastModified',false)
                model
            end
            
            def parse_xml_entry_BundleEntryComponent(entry) 
                return nil unless entry
                model = FHIR::Bundle::BundleEntryComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'link', entry.xpath('./fhir:link').map {|e| parse_xml_entry_BundleLinkComponent(e)})
                parse_primitive_field(model,entry,'fullUrl','fullUrl',false)
                entry.xpath("./fhir:resource/*").each do |e|
                  model.resourceType = e.name
                  v = "FHIR::#{model.resourceType}".constantize.parse_xml_entry(e) unless v
                  model.resource = v
                end
                set_model_data(model, 'search', parse_xml_entry_BundleEntrySearchComponent(entry.at_xpath('./fhir:search')))
                set_model_data(model, 'request', parse_xml_entry_BundleEntryRequestComponent(entry.at_xpath('./fhir:request')))
                set_model_data(model, 'response', parse_xml_entry_BundleEntryResponseComponent(entry.at_xpath('./fhir:response')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                parse_primitive_field(model,entry,'type','fhirType',false)
                parse_primitive_field(model,entry,'total','total',false)
                set_model_data(model, 'link', entry.xpath('./fhir:link').map {|e| parse_xml_entry_BundleLinkComponent(e)})
                set_model_data(model, 'entry', entry.xpath('./fhir:entry').map {|e| parse_xml_entry_BundleEntryComponent(e)})
                set_model_data(model, 'signature', FHIR::Signature.parse_xml_entry(entry.at_xpath('./fhir:signature')))
                model
            end
        end
    end
end
