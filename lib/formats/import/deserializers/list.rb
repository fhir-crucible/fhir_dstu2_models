module FHIR
    module Deserializer
        module List
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ListEntryComponent(entry) 
                return nil unless entry
                model = FHIR::List::ListEntryComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'flag', entry.xpath('./fhir:flag').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'fhirDeleted', entry.at_xpath('./fhir:deleted/@value').try(:value))
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'item', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:item')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'source', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:source')))
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'ordered', entry.at_xpath('./fhir:ordered/@value').try(:value))
                set_model_data(model, 'mode', entry.at_xpath('./fhir:mode/@value').try(:value))
                set_model_data(model, 'entry', entry.xpath('./fhir:entry').map {|e| parse_xml_entry_ListEntryComponent(e)})
                set_model_data(model, 'emptyReason', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:emptyReason')))
                model
            end
        end
    end
end
