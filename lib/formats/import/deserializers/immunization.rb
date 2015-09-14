module FHIR
    module Deserializer
        module Immunization
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ImmunizationExplanationComponent(entry) 
                return nil unless entry
                model = FHIR::Immunization::ImmunizationExplanationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'reason', entry.xpath('./fhir:reason').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'reasonNotGiven', entry.xpath('./fhir:reasonNotGiven').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_ImmunizationReactionComponent(entry) 
                return nil unless entry
                model = FHIR::Immunization::ImmunizationReactionComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'date','date',false)
                set_model_data(model, 'detail', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:detail')))
                parse_primitive_field(model,entry,'reported','reported',false)
                model
            end
            
            def parse_xml_entry_ImmunizationVaccinationProtocolComponent(entry) 
                return nil unless entry
                model = FHIR::Immunization::ImmunizationVaccinationProtocolComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'doseSequence','doseSequence',false)
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'authority', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:authority')))
                parse_primitive_field(model,entry,'series','series',false)
                parse_primitive_field(model,entry,'seriesDoses','seriesDoses',false)
                set_model_data(model, 'targetDisease', entry.xpath('./fhir:targetDisease').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'doseStatus', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:doseStatus')))
                set_model_data(model, 'doseStatusReason', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:doseStatusReason')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'date','date',false)
                set_model_data(model, 'vaccineCode', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:vaccineCode')))
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                parse_primitive_field(model,entry,'wasNotGiven','wasNotGiven',false)
                parse_primitive_field(model,entry,'reported','reported',false)
                set_model_data(model, 'performer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:performer')))
                set_model_data(model, 'requester', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:requester')))
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'manufacturer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:manufacturer')))
                set_model_data(model, 'location', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:location')))
                parse_primitive_field(model,entry,'lotNumber','lotNumber',false)
                parse_primitive_field(model,entry,'expirationDate','expirationDate',false)
                set_model_data(model, 'site', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:site')))
                set_model_data(model, 'route', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:route')))
                set_model_data(model, 'doseQuantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:doseQuantity')))
                set_model_data(model, 'note', entry.xpath('./fhir:note').map {|e| FHIR::Annotation.parse_xml_entry(e)})
                set_model_data(model, 'explanation', parse_xml_entry_ImmunizationExplanationComponent(entry.at_xpath('./fhir:explanation')))
                set_model_data(model, 'reaction', entry.xpath('./fhir:reaction').map {|e| parse_xml_entry_ImmunizationReactionComponent(e)})
                set_model_data(model, 'vaccinationProtocol', entry.xpath('./fhir:vaccinationProtocol').map {|e| parse_xml_entry_ImmunizationVaccinationProtocolComponent(e)})
                model
            end
        end
    end
end
