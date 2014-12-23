module FHIR
    module Deserializer
        module ConceptMap
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_OtherElementComponent(entry) 
                return nil unless entry
                model = FHIR::ConceptMap::OtherElementComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'element', entry.at_xpath('./fhir:element/@value').try(:value))
                set_model_data(model, 'codeSystem', entry.at_xpath('./fhir:codeSystem/@value').try(:value))
                set_model_data(model, 'code', entry.at_xpath('./fhir:code/@value').try(:value))
                model
            end
            
            def parse_xml_entry_ConceptMapElementMapComponent(entry) 
                return nil unless entry
                model = FHIR::ConceptMap::ConceptMapElementMapComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'codeSystem', entry.at_xpath('./fhir:codeSystem/@value').try(:value))
                set_model_data(model, 'code', entry.at_xpath('./fhir:code/@value').try(:value))
                set_model_data(model, 'equivalence', entry.at_xpath('./fhir:equivalence/@value').try(:value))
                set_model_data(model, 'comments', entry.at_xpath('./fhir:comments/@value').try(:value))
                set_model_data(model, 'product', entry.xpath('./fhir:product').map {|e| parse_xml_entry_OtherElementComponent(e)})
                model
            end
            
            def parse_xml_entry_ConceptMapElementComponent(entry) 
                return nil unless entry
                model = FHIR::ConceptMap::ConceptMapElementComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'codeSystem', entry.at_xpath('./fhir:codeSystem/@value').try(:value))
                set_model_data(model, 'code', entry.at_xpath('./fhir:code/@value').try(:value))
                set_model_data(model, 'dependsOn', entry.xpath('./fhir:dependsOn').map {|e| parse_xml_entry_OtherElementComponent(e)})
                set_model_data(model, 'map', entry.xpath('./fhir:map').map {|e| parse_xml_entry_ConceptMapElementMapComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.at_xpath('./fhir:identifier/@value').try(:value))
                set_model_data(model, 'versionNum', entry.at_xpath('./fhir:version/@value').try(:value))
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'publisher', entry.at_xpath('./fhir:publisher/@value').try(:value))
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'copyright', entry.at_xpath('./fhir:copyright/@value').try(:value))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'experimental', entry.at_xpath('./fhir:experimental/@value').try(:value))
                set_model_data(model, 'date', entry.at_xpath('./fhir:date/@value').try(:value))
                set_model_data(model, 'sourceUri', entry.at_xpath('./fhir:sourceUri/@value').try(:value))
                set_model_data(model, 'sourceReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:sourceReference')))
                set_model_data(model, 'targetUri', entry.at_xpath('./fhir:targetUri/@value').try(:value))
                set_model_data(model, 'targetReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:targetReference')))
                set_model_data(model, 'element', entry.xpath('./fhir:element').map {|e| parse_xml_entry_ConceptMapElementComponent(e)})
                model
            end
        end
    end
end
