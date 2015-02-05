module FHIR
    module Deserializer
        module DataElement
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_DataElementBindingComponent(entry) 
                return nil unless entry
                model = FHIR::DataElement::DataElementBindingComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'isExtensible', entry.at_xpath('./fhir:isExtensible/@value').try(:value))
                set_model_data(model, 'conformance', entry.at_xpath('./fhir:conformance/@value').try(:value))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'valueSet', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:valueSet')))
                model
            end
            
            def parse_xml_entry_DataElementMappingComponent(entry) 
                return nil unless entry
                model = FHIR::DataElement::DataElementMappingComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'uri', entry.at_xpath('./fhir:uri/@value').try(:value))
                set_model_data(model, 'definitional', entry.at_xpath('./fhir:definitional/@value').try(:value))
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'comments', entry.at_xpath('./fhir:comments/@value').try(:value))
                set_model_data(model, 'map', entry.at_xpath('./fhir:map/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                set_model_data(model, 'versionNum', entry.at_xpath('./fhir:version/@value').try(:value))
                set_model_data(model, 'publisher', entry.at_xpath('./fhir:publisher/@value').try(:value))
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'category', entry.xpath('./fhir:category').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'granularity', entry.at_xpath('./fhir:granularity/@value').try(:value))
                set_model_data(model, 'code', entry.xpath('./fhir:code').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'question', entry.at_xpath('./fhir:question/@value').try(:value))
                set_model_data(model, 'label', entry.at_xpath('./fhir:label/@value').try(:value))
                set_model_data(model, 'definition', entry.at_xpath('./fhir:definition/@value').try(:value))
                set_model_data(model, 'comments', entry.at_xpath('./fhir:comments/@value').try(:value))
                set_model_data(model, 'requirements', entry.at_xpath('./fhir:requirements/@value').try(:value))
                set_model_data(model, 'synonym', entry.xpath('./fhir:synonym/@value').map {|e| e.value })
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                entry.xpath("./*[contains(local-name(),'example')]").each do |e| 
                  model.exampleType = e.name.gsub('example','')
                  v = e.at_xpath('@value').try(:value)
                  if v.nil? && is_fhir_class?("FHIR::#{model.exampleType}")
                    v = "FHIR::#{model.exampleType}".constantize.parse_xml_entry(e)
                  end
                  model.example = {type: model.exampleType, value: v}
                end
                set_model_data(model, 'maxLength', entry.at_xpath('./fhir:maxLength/@value').try(:value))
                set_model_data(model, 'unitsCodeableConcept', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:unitsCodeableConcept')))
                set_model_data(model, 'unitsReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:unitsReference')))
                set_model_data(model, 'binding', parse_xml_entry_DataElementBindingComponent(entry.at_xpath('./fhir:binding')))
                set_model_data(model, 'mapping', entry.xpath('./fhir:mapping').map {|e| parse_xml_entry_DataElementMappingComponent(e)})
                model
            end
        end
    end
end
