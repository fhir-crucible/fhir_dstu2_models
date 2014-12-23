module FHIR
    module Deserializer
        module AllergyIntolerance
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_AllergyIntoleranceEventComponent(entry) 
                return nil unless entry
                model = FHIR::AllergyIntolerance::AllergyIntoleranceEventComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'substance', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:substance')))
                set_model_data(model, 'certainty', entry.at_xpath('./fhir:certainty/@value').try(:value))
                set_model_data(model, 'manifestation', entry.xpath('./fhir:manifestation').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'onset', entry.at_xpath('./fhir:onset/@value').try(:value))
                set_model_data(model, 'duration', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:duration')))
                set_model_data(model, 'severity', entry.at_xpath('./fhir:severity/@value').try(:value))
                set_model_data(model, 'exposureRoute', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:exposureRoute')))
                set_model_data(model, 'comment', entry.at_xpath('./fhir:comment/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'recordedDate', entry.at_xpath('./fhir:recordedDate/@value').try(:value))
                set_model_data(model, 'recorder', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:recorder')))
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'substance', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:substance')))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'criticality', entry.at_xpath('./fhir:criticality/@value').try(:value))
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'category', entry.at_xpath('./fhir:category/@value').try(:value))
                set_model_data(model, 'lastOccurence', entry.at_xpath('./fhir:lastOccurence/@value').try(:value))
                set_model_data(model, 'comment', entry.at_xpath('./fhir:comment/@value').try(:value))
                set_model_data(model, 'event', entry.xpath('./fhir:event').map {|e| parse_xml_entry_AllergyIntoleranceEventComponent(e)})
                model
            end
        end
    end
end
