module FHIR
    module Deserializer
        module Specimen
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_SpecimenSourceComponent(entry) 
                return nil unless entry
                model = FHIR::Specimen::SpecimenSourceComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'relationship', entry.at_xpath('./fhir:relationship/@value').try(:value))
                set_model_data(model, 'target', entry.xpath('./fhir:target').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_SpecimenCollectionComponent(entry) 
                return nil unless entry
                model = FHIR::Specimen::SpecimenCollectionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'collector', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:collector')))
                set_model_data(model, 'comment', entry.xpath('./fhir:comment/@value').map {|e| e.value })
                set_model_data(model, 'collectedDateTime', entry.at_xpath('./fhir:collectedDateTime/@value').try(:value))
                set_model_data(model, 'collectedPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:collectedPeriod')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'method', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:method')))
                set_model_data(model, 'sourceSite', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:sourceSite')))
                model
            end
            
            def parse_xml_entry_SpecimenTreatmentComponent(entry) 
                return nil unless entry
                model = FHIR::Specimen::SpecimenTreatmentComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'procedure', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:procedure')))
                set_model_data(model, 'additive', entry.xpath('./fhir:additive').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_SpecimenContainerComponent(entry) 
                return nil unless entry
                model = FHIR::Specimen::SpecimenContainerComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'capacity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:capacity')))
                set_model_data(model, 'specimenQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:specimenQuantity')))
                set_model_data(model, 'additiveCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:additiveCodeableConcept')))
                set_model_data(model, 'additiveReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:additiveReference')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'source', entry.xpath('./fhir:source').map {|e| parse_xml_entry_SpecimenSourceComponent(e)})
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'accessionIdentifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:accessionIdentifier')))
                set_model_data(model, 'receivedTime', entry.at_xpath('./fhir:receivedTime/@value').try(:value))
                set_model_data(model, 'fhirCollection', parse_xml_entry_SpecimenCollectionComponent(entry.at_xpath('./fhir:collection')))
                set_model_data(model, 'treatment', entry.xpath('./fhir:treatment').map {|e| parse_xml_entry_SpecimenTreatmentComponent(e)})
                set_model_data(model, 'container', entry.xpath('./fhir:container').map {|e| parse_xml_entry_SpecimenContainerComponent(e)})
                model
            end
        end
    end
end
