module FHIR
    module Deserializer
        module Location
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_LocationPositionComponent(entry) 
                return nil unless entry
                model = FHIR::Location::LocationPositionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'longitude', entry.at_xpath('./fhir:longitude/@value').try(:value))
                set_model_data(model, 'latitude', entry.at_xpath('./fhir:latitude/@value').try(:value))
                set_model_data(model, 'altitude', entry.at_xpath('./fhir:altitude/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                set_model_data(model, 'address', FHIR::Address.parse_xml_entry(entry.at_xpath('./fhir:address')))
                set_model_data(model, 'physicalType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:physicalType')))
                set_model_data(model, 'position', parse_xml_entry_LocationPositionComponent(entry.at_xpath('./fhir:position')))
                set_model_data(model, 'managingOrganization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:managingOrganization')))
                set_model_data(model, 'status', entry.at_xpath('./fhir:status/@value').try(:value))
                set_model_data(model, 'partOf', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:partOf')))
                set_model_data(model, 'mode', entry.at_xpath('./fhir:mode/@value').try(:value))
                model
            end
        end
    end
end
