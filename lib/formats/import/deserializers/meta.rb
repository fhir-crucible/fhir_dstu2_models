module FHIR
    module Deserializer
        module Meta
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'versionId', entry.at_xpath('./fhir:versionId/@value').try(:value))
                set_model_data(model, 'lastUpdated', parse_date_time(entry.at_xpath('./fhir:lastUpdated/@value').try(:value)))
                set_model_data(model, 'profile', entry.xpath('./fhir:profile/@value').map {|e| e.value })
                set_model_data(model, 'security', entry.xpath('./fhir:security').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'tag', entry.xpath('./fhir:tag').map {|e| FHIR::Coding.parse_xml_entry(e)})
                model
            end
        end
    end
end
