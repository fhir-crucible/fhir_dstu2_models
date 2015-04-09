module FHIR
    module Deserializer
        module Conformance
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ConformanceContactComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceContactComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_ConformanceSoftwareComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceSoftwareComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'versionNum', entry.at_xpath('./fhir:version/@value').try(:value))
                set_model_data(model, 'releaseDate', entry.at_xpath('./fhir:releaseDate/@value').try(:value))
                model
            end
            
            def parse_xml_entry_ConformanceImplementationComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceImplementationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'url', entry.at_xpath('./fhir:url/@value').try(:value))
                model
            end
            
            def parse_xml_entry_ConformanceRestSecurityCertificateComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceRestSecurityCertificateComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'blob', entry.at_xpath('./fhir:blob/@value').try(:value))
                model
            end
            
            def parse_xml_entry_ConformanceRestSecurityComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceRestSecurityComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'cors', entry.at_xpath('./fhir:cors/@value').try(:value))
                set_model_data(model, 'service', entry.xpath('./fhir:service').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'certificate', entry.xpath('./fhir:certificate').map {|e| parse_xml_entry_ConformanceRestSecurityCertificateComponent(e)})
                model
            end
            
            def parse_xml_entry_ResourceInteractionComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ResourceInteractionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', entry.at_xpath('./fhir:code/@value').try(:value))
                set_model_data(model, 'documentation', entry.at_xpath('./fhir:documentation/@value').try(:value))
                model
            end
            
            def parse_xml_entry_ConformanceRestResourceSearchParamComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceRestResourceSearchParamComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'definition', entry.at_xpath('./fhir:definition/@value').try(:value))
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'documentation', entry.at_xpath('./fhir:documentation/@value').try(:value))
                set_model_data(model, 'target', entry.xpath('./fhir:target/@value').map {|e| e.value })
                set_model_data(model, 'chain', entry.xpath('./fhir:chain/@value').map {|e| e.value })
                model
            end
            
            def parse_xml_entry_ConformanceRestResourceComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceRestResourceComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'profile', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:profile')))
                set_model_data(model, 'interaction', entry.xpath('./fhir:interaction').map {|e| parse_xml_entry_ResourceInteractionComponent(e)})
                set_model_data(model, 'versioning', entry.at_xpath('./fhir:versioning/@value').try(:value))
                set_model_data(model, 'readHistory', entry.at_xpath('./fhir:readHistory/@value').try(:value))
                set_model_data(model, 'updateCreate', entry.at_xpath('./fhir:updateCreate/@value').try(:value))
                set_model_data(model, 'conditionalCreate', entry.at_xpath('./fhir:conditionalCreate/@value').try(:value))
                set_model_data(model, 'conditionalUpdate', entry.at_xpath('./fhir:conditionalUpdate/@value').try(:value))
                set_model_data(model, 'conditionalDelete', entry.at_xpath('./fhir:conditionalDelete/@value').try(:value))
                set_model_data(model, 'searchInclude', entry.xpath('./fhir:searchInclude/@value').map {|e| e.value })
                set_model_data(model, 'searchParam', entry.xpath('./fhir:searchParam').map {|e| parse_xml_entry_ConformanceRestResourceSearchParamComponent(e)})
                model
            end
            
            def parse_xml_entry_SystemInteractionComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::SystemInteractionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', entry.at_xpath('./fhir:code/@value').try(:value))
                set_model_data(model, 'documentation', entry.at_xpath('./fhir:documentation/@value').try(:value))
                model
            end
            
            def parse_xml_entry_ConformanceRestOperationComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceRestOperationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'definition', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:definition')))
                model
            end
            
            def parse_xml_entry_ConformanceRestComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceRestComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'mode', entry.at_xpath('./fhir:mode/@value').try(:value))
                set_model_data(model, 'documentation', entry.at_xpath('./fhir:documentation/@value').try(:value))
                set_model_data(model, 'security', parse_xml_entry_ConformanceRestSecurityComponent(entry.at_xpath('./fhir:security')))
                set_model_data(model, 'resource', entry.xpath('./fhir:resource').map {|e| parse_xml_entry_ConformanceRestResourceComponent(e)})
                set_model_data(model, 'interaction', entry.xpath('./fhir:interaction').map {|e| parse_xml_entry_SystemInteractionComponent(e)})
                set_model_data(model, 'operation', entry.xpath('./fhir:operation').map {|e| parse_xml_entry_ConformanceRestOperationComponent(e)})
                set_model_data(model, 'documentMailbox', entry.xpath('./fhir:documentMailbox/@value').map {|e| e.value })
                set_model_data(model, 'compartment', entry.xpath('./fhir:compartment/@value').map {|e| e.value })
                model
            end
            
            def parse_xml_entry_ConformanceMessagingEventComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceMessagingEventComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'category', entry.at_xpath('./fhir:category/@value').try(:value))
                set_model_data(model, 'mode', entry.at_xpath('./fhir:mode/@value').try(:value))
                set_model_data(model, 'protocol', entry.xpath('./fhir:protocol').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'focus', entry.at_xpath('./fhir:focus/@value').try(:value))
                set_model_data(model, 'request', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:request')))
                set_model_data(model, 'response', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:response')))
                set_model_data(model, 'documentation', entry.at_xpath('./fhir:documentation/@value').try(:value))
                model
            end
            
            def parse_xml_entry_ConformanceMessagingComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceMessagingComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'endpoint', entry.at_xpath('./fhir:endpoint/@value').try(:value))
                set_model_data(model, 'reliableCache', FHIR::unsignedInt.parse_xml_entry(entry.at_xpath('./fhir:reliableCache')))
                set_model_data(model, 'documentation', entry.at_xpath('./fhir:documentation/@value').try(:value))
                set_model_data(model, 'event', entry.xpath('./fhir:event').map {|e| parse_xml_entry_ConformanceMessagingEventComponent(e)})
                model
            end
            
            def parse_xml_entry_ConformanceDocumentComponent(entry) 
                return nil unless entry
                model = FHIR::Conformance::ConformanceDocumentComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'mode', entry.at_xpath('./fhir:mode/@value').try(:value))
                set_model_data(model, 'documentation', entry.at_xpath('./fhir:documentation/@value').try(:value))
                set_model_data(model, 'profile', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:profile')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'url', entry.at_xpath('./fhir:url/@value').try(:value))
                set_model_data(model, 'versionNum', entry.at_xpath('./fhir:version/@value').try(:value))
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'publisher', entry.at_xpath('./fhir:publisher/@value').try(:value))
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| parse_xml_entry_ConformanceContactComponent(e)})
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'requirements', entry.at_xpath('./fhir:requirements/@value').try(:value))
                set_model_data(model, 'copyright', entry.at_xpath('./fhir:copyright/@value').try(:value))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'experimental', entry.at_xpath('./fhir:experimental/@value').try(:value))
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'software', parse_xml_entry_ConformanceSoftwareComponent(entry.at_xpath('./fhir:software')))
                set_model_data(model, 'implementation', parse_xml_entry_ConformanceImplementationComponent(entry.at_xpath('./fhir:implementation')))
                set_model_data(model, 'fhirVersion', entry.at_xpath('./fhir:fhirVersion/@value').try(:value))
                set_model_data(model, 'acceptUnknown', entry.at_xpath('./fhir:acceptUnknown/@value').try(:value))
                set_model_data(model, 'format', entry.xpath('./fhir:format/@value').map {|e| e.value })
                set_model_data(model, 'profile', entry.xpath('./fhir:profile').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'rest', entry.xpath('./fhir:rest').map {|e| parse_xml_entry_ConformanceRestComponent(e)})
                set_model_data(model, 'messaging', entry.xpath('./fhir:messaging').map {|e| parse_xml_entry_ConformanceMessagingComponent(e)})
                set_model_data(model, 'document', entry.xpath('./fhir:document').map {|e| parse_xml_entry_ConformanceDocumentComponent(e)})
                model
            end
        end
    end
end
