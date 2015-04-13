module FHIR
    module Deserializer
        module ImagingStudy
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ImagingStudySeriesInstanceComponent(entry) 
                return nil unless entry
                model = FHIR::ImagingStudy::ImagingStudySeriesInstanceComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'number', entry.at_xpath('./fhir:number/@value').try(:value))
                set_model_data(model, 'uid', entry.at_xpath('./fhir:uid/@value').try(:value))
                set_model_data(model, 'sopclass', entry.at_xpath('./fhir:sopclass/@value').try(:value))
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'title', entry.at_xpath('./fhir:title/@value').try(:value))
                set_model_data(model, 'content', entry.xpath('./fhir:content').map {|e| FHIR::Attachment.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_ImagingStudySeriesComponent(entry) 
                return nil unless entry
                model = FHIR::ImagingStudy::ImagingStudySeriesComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'number', entry.at_xpath('./fhir:number/@value').try(:value))
                set_model_data(model, 'modality', entry.at_xpath('./fhir:modality/@value').try(:value))
                set_model_data(model, 'uid', entry.at_xpath('./fhir:uid/@value').try(:value))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'numberOfInstances', entry.at_xpath('./fhir:numberOfInstances/@value').try(:value))
                set_model_data(model, 'availability', entry.at_xpath('./fhir:availability/@value').try(:value))
                set_model_data(model, 'url', entry.at_xpath('./fhir:url/@value').try(:value))
                set_model_data(model, 'bodySite', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:bodySite')))
                set_model_data(model, 'laterality', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:laterality')))
                set_model_data(model, 'dateTime', entry.at_xpath('./fhir:dateTime/@value').try(:value))
                set_model_data(model, 'instance', entry.xpath('./fhir:instance').map {|e| parse_xml_entry_ImagingStudySeriesInstanceComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'started', entry.at_xpath('./fhir:started/@value').try(:value))
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'uid', entry.at_xpath('./fhir:uid/@value').try(:value))
                set_model_data(model, 'accession', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:accession')))
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'order', entry.xpath('./fhir:order').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'modalityList', entry.xpath('./fhir:modalityList/@value').map {|e| e.value })
                set_model_data(model, 'referrer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:referrer')))
                set_model_data(model, 'availability', entry.at_xpath('./fhir:availability/@value').try(:value))
                set_model_data(model, 'url', entry.at_xpath('./fhir:url/@value').try(:value))
                set_model_data(model, 'numberOfSeries', entry.at_xpath('./fhir:numberOfSeries/@value').try(:value))
                set_model_data(model, 'numberOfInstances', entry.at_xpath('./fhir:numberOfInstances/@value').try(:value))
                set_model_data(model, 'clinicalInformation', entry.at_xpath('./fhir:clinicalInformation/@value').try(:value))
                set_model_data(model, 'procedure', entry.xpath('./fhir:procedure').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'interpreter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:interpreter')))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'series', entry.xpath('./fhir:series').map {|e| parse_xml_entry_ImagingStudySeriesComponent(e)})
                model
            end
        end
    end
end
