module FHIR
    module Deserializer
        module TestScript
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_TestScriptFixtureComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptFixtureComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'uri', entry.at_xpath('./fhir:uri/@value').try(:value))
                entry.xpath("./fhir:resource/*").each do |e|
                  model.resourceType = e.name
                  if v.nil? && is_fhir_class?("FHIR::#{model.resourceType}")
                    v = "FHIR::#{model.resourceType}".constantize.parse_xml_entry(e)
                  end
                  model.resource = {type: model.resourceType, value: v}
                end
                model
            end
            
            def parse_xml_entry_TestScriptSetupOperationComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptSetupOperationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'source', entry.at_xpath('./fhir:source/@value').try(:value))
                set_model_data(model, 'target', entry.at_xpath('./fhir:target/@value').try(:value))
                set_model_data(model, 'destination', entry.at_xpath('./fhir:destination/@value').try(:value))
                set_model_data(model, 'parameter', entry.at_xpath('./fhir:parameter/@value').try(:value))
                model
            end
            
            def parse_xml_entry_TestScriptSetupComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptSetupComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'operation', entry.xpath('./fhir:operation').map {|e| parse_xml_entry_TestScriptSetupOperationComponent(e)})
                model
            end
            
            def parse_xml_entry_TestScriptTestMetadataLinkComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptTestMetadataLinkComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'url', entry.at_xpath('./fhir:url/@value').try(:value))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                model
            end
            
            def parse_xml_entry_TestScriptTestMetadataRequiresComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptTestMetadataRequiresComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'operations', entry.at_xpath('./fhir:operations/@value').try(:value))
                set_model_data(model, 'destination', entry.at_xpath('./fhir:destination/@value').try(:value))
                model
            end
            
            def parse_xml_entry_TestScriptTestMetadataValidatesComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptTestMetadataValidatesComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'operations', entry.at_xpath('./fhir:operations/@value').try(:value))
                set_model_data(model, 'destination', entry.at_xpath('./fhir:destination/@value').try(:value))
                model
            end
            
            def parse_xml_entry_TestScriptTestMetadataComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptTestMetadataComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'link', entry.xpath('./fhir:link').map {|e| parse_xml_entry_TestScriptTestMetadataLinkComponent(e)})
                set_model_data(model, 'requires', entry.xpath('./fhir:requires').map {|e| parse_xml_entry_TestScriptTestMetadataRequiresComponent(e)})
                set_model_data(model, 'validates', entry.xpath('./fhir:validates').map {|e| parse_xml_entry_TestScriptTestMetadataValidatesComponent(e)})
                model
            end
            
            def parse_xml_entry_TestScriptTestOperationComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptTestOperationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'source', entry.at_xpath('./fhir:source/@value').try(:value))
                set_model_data(model, 'target', entry.at_xpath('./fhir:target/@value').try(:value))
                set_model_data(model, 'destination', entry.at_xpath('./fhir:destination/@value').try(:value))
                set_model_data(model, 'parameter', entry.at_xpath('./fhir:parameter/@value').try(:value))
                model
            end
            
            def parse_xml_entry_TestScriptTestComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptTestComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'metadata', parse_xml_entry_TestScriptTestMetadataComponent(entry.at_xpath('./fhir:metadata')))
                set_model_data(model, 'operation', entry.xpath('./fhir:operation').map {|e| parse_xml_entry_TestScriptTestOperationComponent(e)})
                model
            end
            
            def parse_xml_entry_TestScriptTeardownOperationComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptTeardownOperationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.at_xpath('./fhir:type/@value').try(:value))
                set_model_data(model, 'source', entry.at_xpath('./fhir:source/@value').try(:value))
                set_model_data(model, 'target', entry.at_xpath('./fhir:target/@value').try(:value))
                set_model_data(model, 'destination', entry.at_xpath('./fhir:destination/@value').try(:value))
                set_model_data(model, 'parameter', entry.at_xpath('./fhir:parameter/@value').try(:value))
                model
            end
            
            def parse_xml_entry_TestScriptTeardownComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptTeardownComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'operation', entry.xpath('./fhir:operation').map {|e| parse_xml_entry_TestScriptTeardownOperationComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'name', entry.at_xpath('./fhir:name/@value').try(:value))
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'multiserver', entry.at_xpath('./fhir:multiserver/@value').try(:value))
                set_model_data(model, 'fixture', entry.xpath('./fhir:fixture').map {|e| parse_xml_entry_TestScriptFixtureComponent(e)})
                set_model_data(model, 'setup', parse_xml_entry_TestScriptSetupComponent(entry.at_xpath('./fhir:setup')))
                set_model_data(model, 'test', entry.xpath('./fhir:test').map {|e| parse_xml_entry_TestScriptTestComponent(e)})
                set_model_data(model, 'teardown', parse_xml_entry_TestScriptTeardownComponent(entry.at_xpath('./fhir:teardown')))
                model
            end
        end
    end
end
