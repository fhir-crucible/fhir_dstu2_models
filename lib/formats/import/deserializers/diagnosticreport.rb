module FHIR
    module Deserializer
        module DiagnosticReport
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_DiagnosticReportImageComponent(entry) 
                return nil unless entry
                model = FHIR::DiagnosticReport::DiagnosticReportImageComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'comment','comment',false)
                set_model_data(model, 'link', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:link')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'category', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:category')))
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                parse_primitive_field(model,entry,'effectiveDateTime','effectiveDateTime',false)
                set_model_data(model, 'effectivePeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:effectivePeriod')))
                parse_primitive_field(model,entry,'issued','issued',false)
                set_model_data(model, 'performer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:performer')))
                set_model_data(model, 'request', entry.xpath('./fhir:request').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'specimen', entry.xpath('./fhir:specimen').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'result', entry.xpath('./fhir:result').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'imagingStudy', entry.xpath('./fhir:imagingStudy').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'image', entry.xpath('./fhir:image').map {|e| parse_xml_entry_DiagnosticReportImageComponent(e)})
                parse_primitive_field(model,entry,'conclusion','conclusion',false)
                set_model_data(model, 'codedDiagnosis', entry.xpath('./fhir:codedDiagnosis').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'presentedForm', entry.xpath('./fhir:presentedForm').map {|e| FHIR::Attachment.parse_xml_entry(e)})
                model
            end
        end
    end
end
