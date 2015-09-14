module FHIR
    module Deserializer
        module DocumentManifest
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_DocumentManifestContentComponent(entry) 
                return nil unless entry
                model = FHIR::DocumentManifest::DocumentManifestContentComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'pAttachment', FHIR::Attachment.parse_xml_entry(entry.at_xpath('./fhir:pAttachment')))
                set_model_data(model, 'pReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:pReference')))
                model
            end
            
            def parse_xml_entry_DocumentManifestRelatedComponent(entry) 
                return nil unless entry
                model = FHIR::DocumentManifest::DocumentManifestRelatedComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'ref', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:ref')))
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
                set_model_data(model, 'recipient', entry.xpath('./fhir:recipient').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'author', entry.xpath('./fhir:author').map {|e| FHIR::Reference.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'created','created',false)
                parse_primitive_field(model,entry,'source','source',false)
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'content', entry.xpath('./fhir:content').map {|e| parse_xml_entry_DocumentManifestContentComponent(e)})
                set_model_data(model, 'related', entry.xpath('./fhir:related').map {|e| parse_xml_entry_DocumentManifestRelatedComponent(e)})
                model
            end
        end
    end
end
