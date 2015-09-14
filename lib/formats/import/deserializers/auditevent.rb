module FHIR
    module Deserializer
        module AuditEvent
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_AuditEventEventComponent(entry) 
                return nil unless entry
                model = FHIR::AuditEvent::AuditEventEventComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'subtype', entry.xpath('./fhir:subtype').map {|e| FHIR::Coding.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'action','action',false)
                parse_primitive_field(model,entry,'dateTime','dateTime',false)
                parse_primitive_field(model,entry,'outcome','outcome',false)
                parse_primitive_field(model,entry,'outcomeDesc','outcomeDesc',false)
                set_model_data(model, 'purposeOfEvent', entry.xpath('./fhir:purposeOfEvent').map {|e| FHIR::Coding.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_AuditEventParticipantNetworkComponent(entry) 
                return nil unless entry
                model = FHIR::AuditEvent::AuditEventParticipantNetworkComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'address','address',false)
                parse_primitive_field(model,entry,'type','fhirType',false)
                model
            end
            
            def parse_xml_entry_AuditEventParticipantComponent(entry) 
                return nil unless entry
                model = FHIR::AuditEvent::AuditEventParticipantComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'role', entry.xpath('./fhir:role').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'reference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:reference')))
                set_model_data(model, 'userId', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:userId')))
                parse_primitive_field(model,entry,'altId','altId',false)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'requestor','requestor',false)
                set_model_data(model, 'location', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:location')))
                parse_primitive_field(model,entry,'policy','policy',true)
                set_model_data(model, 'media', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:media')))
                set_model_data(model, 'network', parse_xml_entry_AuditEventParticipantNetworkComponent(entry.at_xpath('./fhir:network')))
                set_model_data(model, 'purposeOfUse', entry.xpath('./fhir:purposeOfUse').map {|e| FHIR::Coding.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_AuditEventSourceComponent(entry) 
                return nil unless entry
                model = FHIR::AuditEvent::AuditEventSourceComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'site','site',false)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'fhirType', entry.xpath('./fhir:type').map {|e| FHIR::Coding.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_AuditEventObjectDetailComponent(entry) 
                return nil unless entry
                model = FHIR::AuditEvent::AuditEventObjectDetailComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'type','fhirType',false)
                parse_primitive_field(model,entry,'value','value',false)
                model
            end
            
            def parse_xml_entry_AuditEventObjectComponent(entry) 
                return nil unless entry
                model = FHIR::AuditEvent::AuditEventObjectComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'reference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:reference')))
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'role', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:role')))
                set_model_data(model, 'lifecycle', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:lifecycle')))
                set_model_data(model, 'securityLabel', entry.xpath('./fhir:securityLabel').map {|e| FHIR::Coding.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'description','description',false)
                parse_primitive_field(model,entry,'query','query',false)
                set_model_data(model, 'detail', entry.xpath('./fhir:detail').map {|e| parse_xml_entry_AuditEventObjectDetailComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'event', parse_xml_entry_AuditEventEventComponent(entry.at_xpath('./fhir:event')))
                set_model_data(model, 'participant', entry.xpath('./fhir:participant').map {|e| parse_xml_entry_AuditEventParticipantComponent(e)})
                set_model_data(model, 'source', parse_xml_entry_AuditEventSourceComponent(entry.at_xpath('./fhir:source')))
                set_model_data(model, 'object', entry.xpath('./fhir:object').map {|e| parse_xml_entry_AuditEventObjectComponent(e)})
                model
            end
        end
    end
end
