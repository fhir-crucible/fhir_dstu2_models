module FHIR
    module Deserializer
        module TestScript
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_TestScriptContactComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptContactComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_TestScriptMetadataLinkComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptMetadataLinkComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'url','url',false)
                parse_primitive_field(model,entry,'description','description',false)
                model
            end
            
            def parse_xml_entry_TestScriptMetadataCapabilityComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptMetadataCapabilityComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'required','required',false)
                parse_primitive_field(model,entry,'validated','fhirValidated',false)
                parse_primitive_field(model,entry,'description','description',false)
                parse_primitive_field(model,entry,'destination','destination',false)
                parse_primitive_field(model,entry,'link','link',true)
                set_model_data(model, 'conformance', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:conformance')))
                model
            end
            
            def parse_xml_entry_TestScriptMetadataComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptMetadataComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'link', entry.xpath('./fhir:link').map {|e| parse_xml_entry_TestScriptMetadataLinkComponent(e)})
                set_model_data(model, 'capability', entry.xpath('./fhir:capability').map {|e| parse_xml_entry_TestScriptMetadataCapabilityComponent(e)})
                model
            end
            
            def parse_xml_entry_TestScriptFixtureComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptFixtureComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'autocreate','autocreate',false)
                parse_primitive_field(model,entry,'autodelete','autodelete',false)
                set_model_data(model, 'resource', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:resource')))
                model
            end
            
            def parse_xml_entry_TestScriptVariableComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptVariableComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'headerField','headerField',false)
                parse_primitive_field(model,entry,'path','path',false)
                parse_primitive_field(model,entry,'sourceId','sourceId',false)
                model
            end
            
            def parse_xml_entry_TestScriptSetupActionOperationRequestHeaderComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptSetupActionOperationRequestHeaderComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'field','field',false)
                parse_primitive_field(model,entry,'value','value',false)
                model
            end
            
            def parse_xml_entry_TestScriptSetupActionOperationComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptSetupActionOperationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                parse_primitive_field(model,entry,'resource','resource',false)
                parse_primitive_field(model,entry,'label','label',false)
                parse_primitive_field(model,entry,'description','description',false)
                parse_primitive_field(model,entry,'accept','accept',false)
                parse_primitive_field(model,entry,'contentType','contentType',false)
                parse_primitive_field(model,entry,'destination','destination',false)
                parse_primitive_field(model,entry,'encodeRequestUrl','encodeRequestUrl',false)
                parse_primitive_field(model,entry,'params','params',false)
                set_model_data(model, 'requestHeader', entry.xpath('./fhir:requestHeader').map {|e| parse_xml_entry_TestScriptSetupActionOperationRequestHeaderComponent(e)})
                parse_primitive_field(model,entry,'responseId','responseId',false)
                parse_primitive_field(model,entry,'sourceId','sourceId',false)
                parse_primitive_field(model,entry,'targetId','targetId',false)
                parse_primitive_field(model,entry,'url','url',false)
                model
            end
            
            def parse_xml_entry_TestScriptSetupActionAssertComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptSetupActionAssertComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'label','label',false)
                parse_primitive_field(model,entry,'description','description',false)
                parse_primitive_field(model,entry,'direction','direction',false)
                parse_primitive_field(model,entry,'compareToSourceId','compareToSourceId',false)
                parse_primitive_field(model,entry,'compareToSourcePath','compareToSourcePath',false)
                parse_primitive_field(model,entry,'contentType','contentType',false)
                parse_primitive_field(model,entry,'headerField','headerField',false)
                parse_primitive_field(model,entry,'minimumId','minimumId',false)
                parse_primitive_field(model,entry,'navigationLinks','navigationLinks',false)
                parse_primitive_field(model,entry,'operator','operator',false)
                parse_primitive_field(model,entry,'path','path',false)
                parse_primitive_field(model,entry,'resource','resource',false)
                parse_primitive_field(model,entry,'response','response',false)
                parse_primitive_field(model,entry,'responseCode','responseCode',false)
                parse_primitive_field(model,entry,'sourceId','sourceId',false)
                parse_primitive_field(model,entry,'validateProfileId','validateProfileId',false)
                parse_primitive_field(model,entry,'value','value',false)
                parse_primitive_field(model,entry,'warningOnly','warningOnly',false)
                model
            end
            
            def parse_xml_entry_TestScriptSetupActionComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptSetupActionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'operation', parse_xml_entry_TestScriptSetupActionOperationComponent(entry.at_xpath('./fhir:operation')))
                set_model_data(model, 'assert', parse_xml_entry_TestScriptSetupActionAssertComponent(entry.at_xpath('./fhir:assert')))
                model
            end
            
            def parse_xml_entry_TestScriptSetupComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptSetupComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'metadata', parse_xml_entry_TestScriptMetadataComponent(entry.at_xpath('./fhir:metadata')))
                set_model_data(model, 'action', entry.xpath('./fhir:action').map {|e| parse_xml_entry_TestScriptSetupActionComponent(e)})
                model
            end
            
            def parse_xml_entry_TestScriptTestActionComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptTestActionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'operation', parse_xml_entry_TestScriptSetupActionOperationComponent(entry.at_xpath('./fhir:operation')))
                set_model_data(model, 'assert', parse_xml_entry_TestScriptSetupActionAssertComponent(entry.at_xpath('./fhir:assert')))
                model
            end
            
            def parse_xml_entry_TestScriptTestComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptTestComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'metadata', parse_xml_entry_TestScriptMetadataComponent(entry.at_xpath('./fhir:metadata')))
                set_model_data(model, 'action', entry.xpath('./fhir:action').map {|e| parse_xml_entry_TestScriptTestActionComponent(e)})
                model
            end
            
            def parse_xml_entry_TestScriptTeardownActionComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptTeardownActionComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'operation', parse_xml_entry_TestScriptSetupActionOperationComponent(entry.at_xpath('./fhir:operation')))
                model
            end
            
            def parse_xml_entry_TestScriptTeardownComponent(entry) 
                return nil unless entry
                model = FHIR::TestScript::TestScriptTeardownComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'action', entry.xpath('./fhir:action').map {|e| parse_xml_entry_TestScriptTeardownActionComponent(e)})
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                parse_primitive_field(model,entry,'url','url',false)
                parse_primitive_field(model,entry,'version','versionNum',false)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'identifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:identifier')))
                parse_primitive_field(model,entry,'experimental','experimental',false)
                parse_primitive_field(model,entry,'publisher','publisher',false)
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| parse_xml_entry_TestScriptContactComponent(e)})
                parse_primitive_field(model,entry,'date','date',false)
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'useContext', entry.xpath('./fhir:useContext').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'requirements','requirements',false)
                parse_primitive_field(model,entry,'copyright','copyright',false)
                set_model_data(model, 'metadata', parse_xml_entry_TestScriptMetadataComponent(entry.at_xpath('./fhir:metadata')))
                parse_primitive_field(model,entry,'multiserver','multiserver',false)
                set_model_data(model, 'fixture', entry.xpath('./fhir:fixture').map {|e| parse_xml_entry_TestScriptFixtureComponent(e)})
                set_model_data(model, 'profile', entry.xpath('./fhir:profile').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'variable', entry.xpath('./fhir:variable').map {|e| parse_xml_entry_TestScriptVariableComponent(e)})
                set_model_data(model, 'setup', parse_xml_entry_TestScriptSetupComponent(entry.at_xpath('./fhir:setup')))
                set_model_data(model, 'test', entry.xpath('./fhir:test').map {|e| parse_xml_entry_TestScriptTestComponent(e)})
                set_model_data(model, 'teardown', parse_xml_entry_TestScriptTeardownComponent(entry.at_xpath('./fhir:teardown')))
                model
            end
        end
    end
end
