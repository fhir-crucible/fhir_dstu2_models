module FHIR
    module Deserializer
        module Composition
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_CompositionAttesterComponent(entry) 
                return nil unless entry
                model = FHIR::Composition::CompositionAttesterComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'mode', entry.xpath('./fhir:mode/@value').map {|e| e.value })
                set_model_data(model, 'time', entry.at_xpath('./fhir:time/@value').try(:value))
                set_model_data(model, 'party', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:party')))
                model
            end
            
            def parse_xml_entry_CompositionEventComponent(entry) 
                return nil unless entry
                model = FHIR::Composition::CompositionEventComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', entry.xpath('./fhir:code').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                set_model_data(model, 'detail', entry.xpath('./fhir:detail').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_SectionComponent(entry) 
                return nil unless entry
                model = FHIR::Composition::SectionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'title', entry.at_xpath('./fhir:title/@value').try(:value))
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'content', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:content')))
                set_model_data(model, 'section', entry.xpath('./fhir:section').map {|e| parse_xml_entry_SectionComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'fhirClass', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:class')))
                set_model_data(model, 'title', entry.at_xpath('./fhir:title/@value').try(:value))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'confidentiality', entry.at_xpath('./fhir:confidentiality/@value').try(:value))
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'author', entry.xpath('./fhir:author').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'attester', entry.xpath('./fhir:attester').map {|e| parse_xml_entry_CompositionAttesterComponent(e)})
                set_model_data(model, 'custodian', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:custodian')))
                set_model_data(model, 'event', entry.xpath('./fhir:event').map {|e| parse_xml_entry_CompositionEventComponent(e)})
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'section', entry.xpath('./fhir:section').map {|e| parse_xml_entry_SectionComponent(e)})
                model
            end
        end
    end
end
