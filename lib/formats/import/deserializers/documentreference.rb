module FHIR
    module Deserializer
        module DocumentReference
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_DocumentReferenceRelatesToComponent(entry) 
                return nil unless entry
                model = FHIR::DocumentReference::DocumentReferenceRelatesToComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'code','code',false)
                set_model_data(model, 'target', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:target')))
                model
            end
            
            def parse_xml_entry_DocumentReferenceContentComponent(entry) 
                return nil unless entry
                model = FHIR::DocumentReference::DocumentReferenceContentComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'attachment', FHIR::Attachment.parse_xml_entry(entry.at_xpath('./fhir:attachment')))
                set_model_data(model, 'format', entry.xpath('./fhir:format').map {|e| FHIR::Coding.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_DocumentReferenceContextRelatedComponent(entry) 
                return nil unless entry
                model = FHIR::DocumentReference::DocumentReferenceContextRelatedComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'ref', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:ref')))
                model
            end
            
            def parse_xml_entry_DocumentReferenceContextComponent(entry) 
                return nil unless entry
                model = FHIR::DocumentReference::DocumentReferenceContextComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'encounter', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:encounter')))
                set_model_data(model, 'event', entry.xpath('./fhir:event').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                set_model_data(model, 'facilityType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:facilityType')))
                set_model_data(model, 'practiceSetting', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:practiceSetting')))
                set_model_data(model, 'sourcePatientInfo', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:sourcePatientInfo')))
                set_model_data(model, 'related', entry.xpath('./fhir:related').map {|e| parse_xml_entry_DocumentReferenceContextRelatedComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'masterIdentifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:masterIdentifier')))
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'subject', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:subject')))
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'fhirClass', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:class')))
                set_model_data(model, 'author', entry.xpath('./fhir:author').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'custodian', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:custodian')))
                set_model_data(model, 'authenticator', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:authenticator')))
                parse_primitive_field(model,entry,'created','created',false)
                parse_primitive_field(model,entry,'indexed','indexed',false)
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'docStatus', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:docStatus')))
                set_model_data(model, 'relatesTo', entry.xpath('./fhir:relatesTo').map {|e| parse_xml_entry_DocumentReferenceRelatesToComponent(e)})
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'securityLabel', entry.xpath('./fhir:securityLabel').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'content', entry.xpath('./fhir:content').map {|e| parse_xml_entry_DocumentReferenceContentComponent(e)})
                set_model_data(model, 'context', parse_xml_entry_DocumentReferenceContextComponent(entry.at_xpath('./fhir:context')))
                model
            end
        end
    end
end
