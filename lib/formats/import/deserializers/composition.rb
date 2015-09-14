module FHIR
    module Deserializer
        module Composition
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_CompositionAttesterComponent(entry) 
                return nil unless entry
                model = FHIR::Composition::CompositionAttesterComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'mode','mode',true)
                parse_primitive_field(model,entry,'time','time',false)
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
                parse_primitive_field(model,entry,'title','title',false)
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'text', FHIR::Narrative.parse_xml_entry(entry.at_xpath('./fhir:text')))
                parse_primitive_field(model,entry,'mode','mode',false)
                set_model_data(model, 'orderedBy', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:orderedBy')))
                set_model_data(model, 'entry', entry.xpath('./fhir:entry').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'emptyReason', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:emptyReason')))
                set_model_data(model, 'section', entry.xpath('./fhir:section').map {|e| parse_xml_entry_SectionComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                parse_primitive_field(model,entry,'date','date',false)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'fhirClass', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:class')))
                parse_primitive_field(model,entry,'title','title',false)
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'confidentiality','confidentiality',false)
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
