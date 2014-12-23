module FHIR
    module Deserializer
        module Extension
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'url', entry.at_xpath('./@url').try(:value))
                entry.xpath("./*[contains(local-name(),'value')]").each do |e| 
                  model.valueType = e.name.gsub('value','')
                  v = e.at_xpath('@value').try(:value)
                  v = "FHIR::#{model.valueType}".constantize.parse_xml_entry(e) unless v
                  model.value = {type: model.valueType, value: v}
                end
                model
            end
        end
    end
end
