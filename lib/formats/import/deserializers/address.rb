module FHIR
    module Deserializer
        module Address
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'use', entry.at_xpath('./fhir:use/@value').try(:value))
                set_model_data(model, 'text', entry.at_xpath('./fhir:text/@value').try(:value))
                set_model_data(model, 'line', entry.xpath('./fhir:line/@value').map {|e| e.value })
                set_model_data(model, 'city', entry.at_xpath('./fhir:city/@value').try(:value))
                set_model_data(model, 'state', entry.at_xpath('./fhir:state/@value').try(:value))
                set_model_data(model, 'postalCode', entry.at_xpath('./fhir:postalCode/@value').try(:value))
                set_model_data(model, 'country', entry.at_xpath('./fhir:country/@value').try(:value))
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                model
            end
        end
    end
end
