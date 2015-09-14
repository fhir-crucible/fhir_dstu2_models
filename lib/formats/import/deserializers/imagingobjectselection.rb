module FHIR
    module Deserializer
        module ImagingObjectSelection
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_FramesComponent(entry) 
                return nil unless entry
                model = FHIR::ImagingObjectSelection::FramesComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'frameNumbers','frameNumbers',true)
                parse_primitive_field(model,entry,'url','url',false)
                model
            end
            
            def parse_xml_entry_InstanceComponent(entry) 
                return nil unless entry
                model = FHIR::ImagingObjectSelection::InstanceComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'sopClass','sopClass',false)
                parse_primitive_field(model,entry,'uid','uid',false)
                parse_primitive_field(model,entry,'url','url',false)
                set_model_data(model, 'frames', entry.xpath('./fhir:frames').map {|e| parse_xml_entry_FramesComponent(e)})
                model
            end
            
            def parse_xml_entry_SeriesComponent(entry) 
                return nil unless entry
                model = FHIR::ImagingObjectSelection::SeriesComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'uid','uid',false)
                parse_primitive_field(model,entry,'url','url',false)
                set_model_data(model, 'instance', entry.xpath('./fhir:instance').map {|e| parse_xml_entry_InstanceComponent(e)})
                model
            end
            
            def parse_xml_entry_StudyComponent(entry) 
                return nil unless entry
                model = FHIR::ImagingObjectSelection::StudyComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'uid','uid',false)
                parse_primitive_field(model,entry,'url','url',false)
                set_model_data(model, 'imagingStudy', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:imagingStudy')))
                set_model_data(model, 'series', entry.xpath('./fhir:series').map {|e| parse_xml_entry_SeriesComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                parse_primitive_field(model,entry,'uid','uid',false)
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'title', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:title')))
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'author', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:author')))
                parse_primitive_field(model,entry,'authoringTime','authoringTime',false)
                set_model_data(model, 'study', entry.xpath('./fhir:study').map {|e| parse_xml_entry_StudyComponent(e)})
                model
            end
        end
    end
end
