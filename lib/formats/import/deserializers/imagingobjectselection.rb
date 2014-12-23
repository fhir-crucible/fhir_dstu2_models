module FHIR
    module Deserializer
        module ImagingObjectSelection
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_InstanceComponent(entry) 
                return nil unless entry
                model = FHIR::ImagingObjectSelection::InstanceComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'sopClass', entry.at_xpath('./fhir:sopClass/@value').try(:value))
                set_model_data(model, 'uid', entry.at_xpath('./fhir:uid/@value').try(:value))
                set_model_data(model, 'retrieveAETitle', entry.at_xpath('./fhir:retrieveAETitle/@value').try(:value))
                set_model_data(model, 'retrieveUrl', entry.at_xpath('./fhir:retrieveUrl/@value').try(:value))
                model
            end
            
            def parse_xml_entry_SeriesComponent(entry) 
                return nil unless entry
                model = FHIR::ImagingObjectSelection::SeriesComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'uid', entry.at_xpath('./fhir:uid/@value').try(:value))
                set_model_data(model, 'retrieveAETitle', entry.at_xpath('./fhir:retrieveAETitle/@value').try(:value))
                set_model_data(model, 'retrieveUrl', entry.at_xpath('./fhir:retrieveUrl/@value').try(:value))
                set_model_data(model, 'instance', entry.xpath('./fhir:instance').map {|e| parse_xml_entry_InstanceComponent(e)})
                model
            end
            
            def parse_xml_entry_StudyComponent(entry) 
                return nil unless entry
                model = FHIR::ImagingObjectSelection::StudyComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'uid', entry.at_xpath('./fhir:uid/@value').try(:value))
                set_model_data(model, 'retrieveAETitle', entry.at_xpath('./fhir:retrieveAETitle/@value').try(:value))
                set_model_data(model, 'retrieveUrl', entry.at_xpath('./fhir:retrieveUrl/@value').try(:value))
                set_model_data(model, 'series', entry.xpath('./fhir:series').map {|e| parse_xml_entry_SeriesComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'uid', entry.at_xpath('./fhir:uid/@value').try(:value))
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'title', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:title')))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'author', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:author')))
                set_model_data(model, 'authoringTime', entry.at_xpath('./fhir:authoringTime/@value').try(:value))
                set_model_data(model, 'study', entry.xpath('./fhir:study').map {|e| parse_xml_entry_StudyComponent(e)})
                model
            end
        end
    end
end
