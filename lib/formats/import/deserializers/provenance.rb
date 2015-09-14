module FHIR
    module Deserializer
        module Provenance
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ProvenanceAgentRelatedAgentComponent(entry) 
                return nil unless entry
                model = FHIR::Provenance::ProvenanceAgentRelatedAgentComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                parse_primitive_field(model,entry,'target','target',false)
                model
            end
            
            def parse_xml_entry_ProvenanceAgentComponent(entry) 
                return nil unless entry
                model = FHIR::Provenance::ProvenanceAgentComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'role', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:role')))
                set_model_data(model, 'actor', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:actor')))
                set_model_data(model, 'userId', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:userId')))
                set_model_data(model, 'relatedAgent', entry.xpath('./fhir:relatedAgent').map {|e| parse_xml_entry_ProvenanceAgentRelatedAgentComponent(e)})
                model
            end
            
            def parse_xml_entry_ProvenanceEntityComponent(entry) 
                return nil unless entry
                model = FHIR::Provenance::ProvenanceEntityComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'role','role',false)
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                parse_primitive_field(model,entry,'reference','reference',false)
                parse_primitive_field(model,entry,'display','display',false)
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
                parse_primitive_field(model,entry,'recorded','recorded',false)
                set_model_data(model, 'reason', entry.xpath('./fhir:reason').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'activity', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:activity')))
                set_model_data(model, 'location', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:location')))
                parse_primitive_field(model,entry,'policy','policy',true)
                set_model_data(model, 'agent', entry.xpath('./fhir:agent').map {|e| parse_xml_entry_ProvenanceAgentComponent(e)})
                set_model_data(model, 'entity', entry.xpath('./fhir:entity').map {|e| parse_xml_entry_ProvenanceEntityComponent(e)})
                set_model_data(model, 'signature', entry.xpath('./fhir:signature').map {|e| FHIR::Signature.parse_xml_entry(e)})
                model
            end
        end
    end
end
