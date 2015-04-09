module FHIR
    module Deserializer
        module AuditEvent
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_AuditEventEventComponent(entry) 
                return nil unless entry
                model = FHIR::AuditEvent::AuditEventEventComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'subtype', entry.xpath('./fhir:subtype').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'action', entry.at_xpath('./fhir:action/@value').try(:value))
                set_model_data(model, 'dateTime', parse_date_time(entry.at_xpath('./fhir:dateTime/@value').try(:value)))
                set_model_data(model, 'outcome', entry.at_xpath('./fhir:outcome/@value').try(:value))
                set_model_data(model, 'outcomeDesc', entry.at_xpath('./fhir:outcomeDesc/@value').try(:value))
                set_model_data(model, 'purposeOfEvent', entry.xpath('./fhir:purposeOfEvent').map {|e| FHIR::Coding.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_AuditEventParticipantNetworkComponent(entry) 
                return nil unless entry
                model = FHIR::AuditEvent::AuditEventParticipantNetworkComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'identifier', entry.at_xpath('./fhir:identifier/@value').try(:value))
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                model
            end
            
            def parse_xml_entry_AuditEventParticipantComponent(entry) 
                return nil unless entry
                model = FHIR::AuditEvent::AuditEventParticipantComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'role', entry.xpath('./fhir:role').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'reference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:reference')))
                set_model_data(model, 'userId', entry.at_xpath('./fhir:userId/@value').try(:value))
                set_model_data(model, 'altId', entry.at_xpath('./fhir:altId/@value').try(:value))
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'requestor', entry.at_xpath('./fhir:requestor/@value').try(:value))
                set_model_data(model, 'location', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:location')))
                set_model_data(model, 'policy', entry.xpath('./fhir:policy/@value').map {|e| e.value })
                set_model_data(model, 'media', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:media')))
                set_model_data(model, 'network', parse_xml_entry_AuditEventParticipantNetworkComponent(entry.at_xpath('./fhir:network')))
                set_model_data(model, 'purposeOfUse', entry.xpath('./fhir:purposeOfUse').map {|e| FHIR::Coding.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_AuditEventSourceComponent(entry) 
                return nil unless entry
                model = FHIR::AuditEvent::AuditEventSourceComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'site', entry.at_xpath('./fhir:site/@value').try(:value))
                set_model_data(model, 'identifier', entry.at_xpath('./fhir:identifier/@value').try(:value))
                set_model_data(model, 'fhirType', entry.xpath('./fhir:type').map {|e| FHIR::Coding.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_AuditEventObjectDetailComponent(entry) 
                return nil unless entry
                model = FHIR::AuditEvent::AuditEventObjectDetailComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'value', entry.at_xpath('./fhir:value/@value').try(:value))
                model
            end
            
            def parse_xml_entry_AuditEventObjectComponent(entry) 
                return nil unless entry
                model = FHIR::AuditEvent::AuditEventObjectComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'reference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:reference')))
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'role', entry.at_xpath('./fhir:role/@value').try(:value))
                set_model_data(model, 'lifecycle', entry.at_xpath('./fhir:lifecycle/@value').try(:value))
                set_model_data(model, 'sensitivity', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:sensitivity')))
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'query', entry.at_xpath('./fhir:query/@value').try(:value))
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
