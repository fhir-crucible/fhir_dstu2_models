module FHIR
    module Deserializer
        module Conformance
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ConformanceContactComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceContactComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_ConformanceSoftwareComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceSoftwareComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'version','versionNum',false)
                parse_primitive_field(model,entry,'releaseDate','releaseDate',false)
                model
            end
            
            def parse_xml_entry_ConformanceImplementationComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceImplementationComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'description','description',false)
                parse_primitive_field(model,entry,'url','url',false)
                model
            end
            
            def parse_xml_entry_ConformanceRestSecurityCertificateComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceRestSecurityCertificateComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'type','fhirType',false)
                parse_primitive_field(model,entry,'blob','blob',false)
                model
            end
            
            def parse_xml_entry_ConformanceRestSecurityComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceRestSecurityComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'cors','cors',false)
                set_model_data(model, 'service', entry.xpath('./fhir:service').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'certificate', entry.xpath('./fhir:certificate').map {|e| parse_xml_entry_ConformanceRestSecurityCertificateComponent(e)})
                model
            end
            
            def parse_xml_entry_ResourceInteractionComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ResourceInteractionComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'code','code',false)
                parse_primitive_field(model,entry,'documentation','documentation',false)
                model
            end
            
            def parse_xml_entry_ConformanceRestResourceSearchParamComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceRestResourceSearchParamComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'definition','definition',false)
                parse_primitive_field(model,entry,'type','fhirType',false)
                parse_primitive_field(model,entry,'documentation','documentation',false)
                parse_primitive_field(model,entry,'target','target',true)
                parse_primitive_field(model,entry,'modifier','fhirModifier',true)
                parse_primitive_field(model,entry,'chain','chain',true)
                model
            end
            
            def parse_xml_entry_ConformanceRestResourceComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceRestResourceComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'type','fhirType',false)
                set_model_data(model, 'profile', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:profile')))
                set_model_data(model, 'interaction', entry.xpath('./fhir:interaction').map {|e| parse_xml_entry_ResourceInteractionComponent(e)})
                parse_primitive_field(model,entry,'versioning','versioning',false)
                parse_primitive_field(model,entry,'readHistory','readHistory',false)
                parse_primitive_field(model,entry,'updateCreate','updateCreate',false)
                parse_primitive_field(model,entry,'conditionalCreate','conditionalCreate',false)
                parse_primitive_field(model,entry,'conditionalUpdate','conditionalUpdate',false)
                parse_primitive_field(model,entry,'conditionalDelete','conditionalDelete',false)
                parse_primitive_field(model,entry,'searchInclude','searchInclude',true)
                parse_primitive_field(model,entry,'searchRevInclude','searchRevInclude',true)
                set_model_data(model, 'searchParam', entry.xpath('./fhir:searchParam').map {|e| parse_xml_entry_ConformanceRestResourceSearchParamComponent(e)})
                model
            end
            
            def parse_xml_entry_SystemInteractionComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::SystemInteractionComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'code','code',false)
                parse_primitive_field(model,entry,'documentation','documentation',false)
                model
            end
            
            def parse_xml_entry_ConformanceRestOperationComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceRestOperationComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                set_model_data(model, 'definition', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:definition')))
                model
            end
            
            def parse_xml_entry_ConformanceRestComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceRestComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'mode','mode',false)
                parse_primitive_field(model,entry,'documentation','documentation',false)
                set_model_data(model, 'security', parse_xml_entry_ConformanceRestSecurityComponent(entry.at_xpath('./fhir:security')))
                set_model_data(model, 'resource', entry.xpath('./fhir:resource').map {|e| parse_xml_entry_ConformanceRestResourceComponent(e)})
                set_model_data(model, 'interaction', entry.xpath('./fhir:interaction').map {|e| parse_xml_entry_SystemInteractionComponent(e)})
                parse_primitive_field(model,entry,'transactionMode','transactionMode',false)
                set_model_data(model, 'searchParam', entry.xpath('./fhir:searchParam').map {|e| parse_xml_entry_ConformanceRestResourceSearchParamComponent(e)})
                set_model_data(model, 'operation', entry.xpath('./fhir:operation').map {|e| parse_xml_entry_ConformanceRestOperationComponent(e)})
                parse_primitive_field(model,entry,'compartment','compartment',true)
                model
            end
            
            def parse_xml_entry_ConformanceMessagingEndpointComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceMessagingEndpointComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'protocol', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:protocol')))
                parse_primitive_field(model,entry,'address','address',false)
                model
            end
            
            def parse_xml_entry_ConformanceMessagingEventComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceMessagingEventComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:code')))
                parse_primitive_field(model,entry,'category','category',false)
                parse_primitive_field(model,entry,'mode','mode',false)
                parse_primitive_field(model,entry,'focus','focus',false)
                set_model_data(model, 'request', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:request')))
                set_model_data(model, 'response', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:response')))
                parse_primitive_field(model,entry,'documentation','documentation',false)
                model
            end
            
            def parse_xml_entry_ConformanceMessagingComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceMessagingComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'endpoint', entry.xpath('./fhir:endpoint').map {|e| parse_xml_entry_ConformanceMessagingEndpointComponent(e)})
                parse_primitive_field(model,entry,'reliableCache','reliableCache',false)
                parse_primitive_field(model,entry,'documentation','documentation',false)
                set_model_data(model, 'event', entry.xpath('./fhir:event').map {|e| parse_xml_entry_ConformanceMessagingEventComponent(e)})
                model
            end
            
            def parse_xml_entry_ConformanceDocumentComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceDocumentComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'mode','mode',false)
                parse_primitive_field(model,entry,'documentation','documentation',false)
                set_model_data(model, 'profile', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:profile')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                parse_primitive_field(model,entry,'url','url',false)
                parse_primitive_field(model,entry,'version','versionNum',false)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'experimental','experimental',false)
                parse_primitive_field(model,entry,'publisher','publisher',false)
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| parse_xml_entry_ConformanceContactComponent(e)})
                parse_primitive_field(model,entry,'date','date',false)
                parse_primitive_field(model,entry,'description','description',false)
                parse_primitive_field(model,entry,'requirements','requirements',false)
                parse_primitive_field(model,entry,'copyright','copyright',false)
                parse_primitive_field(model,entry,'kind','kind',false)
                set_model_data(model, 'software', parse_xml_entry_ConformanceSoftwareComponent(entry.at_xpath('./fhir:software')))
                set_model_data(model, 'implementation', parse_xml_entry_ConformanceImplementationComponent(entry.at_xpath('./fhir:implementation')))
                parse_primitive_field(model,entry,'fhirVersion','fhirVersion',false)
                parse_primitive_field(model,entry,'acceptUnknown','acceptUnknown',false)
                parse_primitive_field(model,entry,'format','format',true)
                set_model_data(model, 'profile', entry.xpath('./fhir:profile').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'rest', entry.xpath('./fhir:rest').map {|e| parse_xml_entry_ConformanceRestComponent(e)})
                set_model_data(model, 'messaging', entry.xpath('./fhir:messaging').map {|e| parse_xml_entry_ConformanceMessagingComponent(e)})
                set_model_data(model, 'document', entry.xpath('./fhir:document').map {|e| parse_xml_entry_ConformanceDocumentComponent(e)})
                model
            end
        end
    end
end
