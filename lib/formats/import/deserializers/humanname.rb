module FHIR
    module Deserializer
        module HumanName
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'use', entry.at_xpath('./fhir:use/@value').try(:value))
                set_model_data(model, 'text', entry.at_xpath('./fhir:text/@value').try(:value))
                set_model_data(model, 'family', entry.xpath('./fhir:family/@value').map {|e| e.value })
                set_model_data(model, 'given', entry.xpath('./fhir:given/@value').map {|e| e.value })
                set_model_data(model, 'prefix', entry.xpath('./fhir:prefix/@value').map {|e| e.value })
                set_model_data(model, 'suffix', entry.xpath('./fhir:suffix/@value').map {|e| e.value })
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                model
            end
        end
    end
end
