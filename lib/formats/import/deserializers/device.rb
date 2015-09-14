module FHIR
    module Deserializer
        module Device
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'note', entry.xpath('./fhir:note').map {|e| FHIR::Annotation.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'status','status',false)
                parse_primitive_field(model,entry,'manufacturer','manufacturer',false)
                parse_primitive_field(model,entry,'model','model',false)
                parse_primitive_field(model,entry,'version','versionNum',false)
                parse_primitive_field(model,entry,'manufactureDate','manufactureDate',false)
                parse_primitive_field(model,entry,'expiry','expiry',false)
                parse_primitive_field(model,entry,'udi','udi',false)
                parse_primitive_field(model,entry,'lotNumber','lotNumber',false)
                set_model_data(model, 'owner', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:owner')))
                set_model_data(model, 'location', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:location')))
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'url','url',false)
                model
            end
        end
    end
end
