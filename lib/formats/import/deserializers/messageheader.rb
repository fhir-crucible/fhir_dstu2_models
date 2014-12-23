module FHIR
    module Deserializer
        module MessageHeader
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_MessageHeaderResponseComponent(entry) 
                return nil unless entry
                model = FHIR::MessageHeader::MessageHeaderResponseComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'identifier', entry.at_xpath('./fhir:identifier/@value').try(:value))
                set_model_data(model, 'code', entry.at_xpath('./fhir:code/@value').try(:value))
                set_model_data(model, 'details', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:details')))
                model
            end
            
            def parse_xml_entry_MessageSourceComponent(entry) 
                return nil unless entry
                model = FHIR::MessageHeader::MessageSourceComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'software', entry.at_xpath('./fhir:software/@value').try(:value))
                set_model_data(model, 'versionNum', entry.at_xpath('./fhir:version/@value').try(:value))
                set_model_data(model, 'contact', FHIR::ContactPoint.parse_xml_entry(entry.at_xpath('./fhir:contact')))
                set_model_data(model, 'endpoint', entry.at_xpath('./fhir:endpoint/@value').try(:value))
                model
            end
            
            def parse_xml_entry_MessageDestinationComponent(entry) 
                return nil unless entry
                model = FHIR::MessageHeader::MessageDestinationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'target', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:target')))
                set_model_data(model, 'endpoint', entry.at_xpath('./fhir:endpoint/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.at_xpath('./fhir:identifier/@value').try(:value))
                set_model_data(model, 'timestamp', parse_date_time(entry.at_xpath('./fhir:timestamp/@value').try(:value)))
                set_model_data(model, 'event', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:event')))
                set_model_data(model, 'response', parse_xml_entry_MessageHeaderResponseComponent(entry.at_xpath('./fhir:response')))
                set_model_data(model, 'source', parse_xml_entry_MessageSourceComponent(entry.at_xpath('./fhir:source')))
                set_model_data(model, 'destination', entry.xpath('./fhir:destination').map {|e| parse_xml_entry_MessageDestinationComponent(e)})
                set_model_data(model, 'enterer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:enterer')))
                set_model_data(model, 'author', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:author')))
                set_model_data(model, 'receiver', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:receiver')))
                set_model_data(model, 'responsible', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:responsible')))
                set_model_data(model, 'reason', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:reason')))
                set_model_data(model, 'data', entry.xpath('./fhir:data').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
        end
    end
end
