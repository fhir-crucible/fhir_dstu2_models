module FHIR
    module Deserializer
        module DiagnosticReport
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_DiagnosticReportImageComponent(entry) 
                return nil unless entry
                model = FHIR::DiagnosticReport::DiagnosticReportImageComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'comment', entry.at_xpath('./fhir:comment/@value').try(:value))
                set_model_data(model, 'link', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:link')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'name', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:name')))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'issued', entry.at_xpath('./fhir:issued/@value').try(:value))
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'performer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:performer')))
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'requestDetail', entry.xpath('./fhir:requestDetail').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'serviceCategory', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:serviceCategory')))
                set_model_data(model, 'diagnosticDateTime', entry.at_xpath('./fhir:diagnosticDateTime/@value').try(:value))
                set_model_data(model, 'diagnosticPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:diagnosticPeriod')))
                set_model_data(model, 'specimen', entry.xpath('./fhir:specimen').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'result', entry.xpath('./fhir:result').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'imagingStudy', entry.xpath('./fhir:imagingStudy').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'image', entry.xpath('./fhir:image').map {|e| parse_xml_entry_DiagnosticReportImageComponent(e)})
                set_model_data(model, 'conclusion', entry.at_xpath('./fhir:conclusion/@value').try(:value))
                set_model_data(model, 'codedDiagnosis', entry.xpath('./fhir:codedDiagnosis').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'presentedForm', entry.xpath('./fhir:presentedForm').map {|e| FHIR::Attachment.parse_xml_entry(e)})
                model
            end
        end
    end
end
