module FHIR
    module Deserializer
        module Procedure
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ProcedurePerformerComponent(entry) 
                return nil unless entry
                model = FHIR::Procedure::ProcedurePerformerComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'actor', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:actor')))
                set_model_data(model, 'role', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:role')))
                model
            end
            
            def parse_xml_entry_ProcedureFocalDeviceComponent(entry) 
                return nil unless entry
                model = FHIR::Procedure::ProcedureFocalDeviceComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'action', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:action')))
                set_model_data(model, 'manipulated', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:manipulated')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'category', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:category')))
                set_model_data(model, 'code', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:code')))
                parse_primitive_field(model,entry,'notPerformed','notPerformed',false)
                set_model_data(model, 'reasonNotPerformed', entry.xpath('./fhir:reasonNotPerformed').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'bodySite', entry.xpath('./fhir:bodySite').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'reasonCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:reasonCodeableConcept')))
                set_model_data(model, 'reasonReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:reasonReference')))
                set_model_data(model, 'performer', entry.xpath('./fhir:performer').map {|e| parse_xml_entry_ProcedurePerformerComponent(e)})
                parse_primitive_field(model,entry,'performedDateTime','performedDateTime',false)
                set_model_data(model, 'performedPeriod', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:performedPeriod')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'location', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:location')))
                set_model_data(model, 'outcome', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:outcome')))
                set_model_data(model, 'report', entry.xpath('./fhir:report').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'complication', entry.xpath('./fhir:complication').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'followUp', entry.xpath('./fhir:followUp').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'request', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:request')))
                set_model_data(model, 'notes', entry.xpath('./fhir:notes').map {|e| FHIR::Annotation.parse_xml_entry(e)})
                set_model_data(model, 'focalDevice', entry.xpath('./fhir:focalDevice').map {|e| parse_xml_entry_ProcedureFocalDeviceComponent(e)})
                set_model_data(model, 'used', entry.xpath('./fhir:used').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
        end
    end
end
