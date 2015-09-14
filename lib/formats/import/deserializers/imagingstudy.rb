module FHIR
    module Deserializer
        module ImagingStudy
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ImagingStudySeriesInstanceComponent(entry) 
                return nil unless entry
                model = FHIR::ImagingStudy::ImagingStudySeriesInstanceComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'number','number',false)
                parse_primitive_field(model,entry,'uid','uid',false)
                parse_primitive_field(model,entry,'sopClass','sopClass',false)
                parse_primitive_field(model,entry,'type','fhirType',false)
                parse_primitive_field(model,entry,'title','title',false)
                set_model_data(model, 'content', entry.xpath('./fhir:content').map {|e| FHIR::Attachment.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_ImagingStudySeriesComponent(entry) 
                return nil unless entry
                model = FHIR::ImagingStudy::ImagingStudySeriesComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'number','number',false)
                set_model_data(model, 'modality', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:modality')))
                parse_primitive_field(model,entry,'uid','uid',false)
                parse_primitive_field(model,entry,'description','description',false)
                parse_primitive_field(model,entry,'numberOfInstances','numberOfInstances',false)
                parse_primitive_field(model,entry,'availability','availability',false)
                parse_primitive_field(model,entry,'url','url',false)
                set_model_data(model, 'bodySite', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:bodySite')))
                set_model_data(model, 'laterality', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:laterality')))
                parse_primitive_field(model,entry,'started','started',false)
                set_model_data(model, 'instance', entry.xpath('./fhir:instance').map {|e| parse_xml_entry_ImagingStudySeriesInstanceComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                parse_primitive_field(model,entry,'started','started',false)
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                parse_primitive_field(model,entry,'uid','uid',false)
                set_model_data(model, 'accession', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:accession')))
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'order', entry.xpath('./fhir:order').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'modalityList', entry.xpath('./fhir:modalityList').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'referrer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:referrer')))
                parse_primitive_field(model,entry,'availability','availability',false)
                parse_primitive_field(model,entry,'url','url',false)
                parse_primitive_field(model,entry,'numberOfSeries','numberOfSeries',false)
                parse_primitive_field(model,entry,'numberOfInstances','numberOfInstances',false)
                set_model_data(model, 'procedure', entry.xpath('./fhir:procedure').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'interpreter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:interpreter')))
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'series', entry.xpath('./fhir:series').map {|e| parse_xml_entry_ImagingStudySeriesComponent(e)})
                model
            end
        end
    end
end
