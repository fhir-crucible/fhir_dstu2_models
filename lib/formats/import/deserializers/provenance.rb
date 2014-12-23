module FHIR
    module Deserializer
        module Provenance
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ProvenanceAgentComponent(entry) 
                return nil unless entry
                model = FHIR::Provenance::ProvenanceAgentComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'role', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:role')))
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'reference', entry.at_xpath('./fhir:reference/@value').try(:value))
                set_model_data(model, 'display', entry.at_xpath('./fhir:display/@value').try(:value))
                model
            end
            
            def parse_xml_entry_ProvenanceEntityComponent(entry) 
                return nil unless entry
                model = FHIR::Provenance::ProvenanceEntityComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'role', entry.at_xpath('./fhir:role/@value').try(:value))
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'reference', entry.at_xpath('./fhir:reference/@value').try(:value))
                set_model_data(model, 'display', entry.at_xpath('./fhir:display/@value').try(:value))
                set_model_data(model, 'agent', parse_xml_entry_ProvenanceAgentComponent(entry.at_xpath('./fhir:agent')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'target', entry.xpath('./fhir:target').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                set_model_data(model, 'recorded', parse_date_time(entry.at_xpath('./fhir:recorded/@value').try(:value)))
                set_model_data(model, 'reason', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:reason')))
                set_model_data(model, 'location', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:location')))
                set_model_data(model, 'policy', entry.xpath('./fhir:policy/@value').map {|e| e.value })
                set_model_data(model, 'agent', entry.xpath('./fhir:agent').map {|e| parse_xml_entry_ProvenanceAgentComponent(e)})
                set_model_data(model, 'entity', entry.xpath('./fhir:entity').map {|e| parse_xml_entry_ProvenanceEntityComponent(e)})
                set_model_data(model, 'integritySignature', entry.at_xpath('./fhir:integritySignature/@value').try(:value))
                model
            end
        end
    end
end
