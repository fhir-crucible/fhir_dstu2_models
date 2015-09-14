module FHIR
    module Deserializer
        module MessageHeader
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_MessageHeaderResponseComponent(entry) 
                return nil unless entry
                model = FHIR::MessageHeader::MessageHeaderResponseComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'identifier','identifier',false)
                parse_primitive_field(model,entry,'code','code',false)
                set_model_data(model, 'details', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:details')))
                model
            end
            
            def parse_xml_entry_MessageSourceComponent(entry) 
                return nil unless entry
                model = FHIR::MessageHeader::MessageSourceComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'software','software',false)
                parse_primitive_field(model,entry,'version','versionNum',false)
                set_model_data(model, 'contact', FHIR::ContactPoint.parse_xml_entry(entry.at_xpath('./fhir:contact')))
                parse_primitive_field(model,entry,'endpoint','endpoint',false)
                model
            end
            
            def parse_xml_entry_MessageDestinationComponent(entry) 
                return nil unless entry
                model = FHIR::MessageHeader::MessageDestinationComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                set_model_data(model, 'target', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:target')))
                parse_primitive_field(model,entry,'endpoint','endpoint',false)
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                parse_primitive_field(model,entry,'timestamp','timestamp',false)
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
