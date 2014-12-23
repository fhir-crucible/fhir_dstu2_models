module FHIR
    module Deserializer
        module DocumentReference
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_DocumentReferenceRelatesToComponent(entry) 
                return nil unless entry
                model = FHIR::DocumentReference::DocumentReferenceRelatesToComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', entry.at_xpath('./fhir:code/@value').try(:value))
                set_model_data(model, 'target', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:target')))
                model
            end
            
            def parse_xml_entry_DocumentReferenceServiceParameterComponent(entry) 
                return nil unless entry
                model = FHIR::DocumentReference::DocumentReferenceServiceParameterComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'value', entry.at_xpath('./fhir:value/@value').try(:value))
                model
            end
            
            def parse_xml_entry_DocumentReferenceServiceComponent(entry) 
                return nil unless entry
                model = FHIR::DocumentReference::DocumentReferenceServiceComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'address', entry.at_xpath('./fhir:address/@value').try(:value))
                set_model_data(model, 'parameter', entry.xpath('./fhir:parameter').map {|e| parse_xml_entry_DocumentReferenceServiceParameterComponent(e)})
                model
            end
            
            def parse_xml_entry_DocumentReferenceContextComponent(entry) 
                return nil unless entry
                model = FHIR::DocumentReference::DocumentReferenceContextComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'event', entry.xpath('./fhir:event').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                set_model_data(model, 'facilityType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:facilityType')))
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
                set_model_data(model, 'policyManager', entry.at_xpath('./fhir:policyManager/@value').try(:value))
                set_model_data(model, 'authenticator', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:authenticator')))
                set_model_data(model, 'created', entry.at_xpath('./fhir:created/@value').try(:value))
                set_model_data(model, 'indexed', parse_date_time(entry.at_xpath('./fhir:indexed/@value').try(:value)))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'docStatus', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:docStatus')))
                set_model_data(model, 'relatesTo', entry.xpath('./fhir:relatesTo').map {|e| parse_xml_entry_DocumentReferenceRelatesToComponent(e)})
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'confidentiality', entry.xpath('./fhir:confidentiality').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'primaryLanguage', entry.at_xpath('./fhir:primaryLanguage/@value').try(:value))
                set_model_data(model, 'mimeType', entry.at_xpath('./fhir:mimeType/@value').try(:value))
                set_model_data(model, 'format', entry.xpath('./fhir:format/@value').map {|e| e.value })
                set_model_data(model, 'size', entry.at_xpath('./fhir:size/@value').try(:value))
                set_model_data(model, 'fhirHash', entry.at_xpath('./fhir:hash/@value').try(:value))
                set_model_data(model, 'location', entry.at_xpath('./fhir:location/@value').try(:value))
                set_model_data(model, 'service', parse_xml_entry_DocumentReferenceServiceComponent(entry.at_xpath('./fhir:service')))
                set_model_data(model, 'context', parse_xml_entry_DocumentReferenceContextComponent(entry.at_xpath('./fhir:context')))
                model
            end
        end
    end
end
