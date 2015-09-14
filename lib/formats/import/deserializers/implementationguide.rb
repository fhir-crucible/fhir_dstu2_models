module FHIR
    module Deserializer
        module ImplementationGuide
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ImplementationGuideContactComponent(entry) 
                return nil unless entry
                model = FHIR::ImplementationGuide::ImplementationGuideContactComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                set_model_data(model, 'telecom', entry.xpath('./fhir:telecom').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_ImplementationGuideDependencyComponent(entry) 
                return nil unless entry
                model = FHIR::ImplementationGuide::ImplementationGuideDependencyComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'type','fhirType',false)
                parse_primitive_field(model,entry,'uri','uri',false)
                model
            end
            
            def parse_xml_entry_ImplementationGuidePackageResourceComponent(entry) 
                return nil unless entry
                model = FHIR::ImplementationGuide::ImplementationGuidePackageResourceComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'purpose','purpose',false)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'description','description',false)
                parse_primitive_field(model,entry,'acronym','acronym',false)
                parse_primitive_field(model,entry,'sourceUri','sourceUri',false)
                set_model_data(model, 'sourceReference', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:sourceReference')))
                set_model_data(model, 'exampleFor', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:exampleFor')))
                model
            end
            
            def parse_xml_entry_ImplementationGuidePackageComponent(entry) 
                return nil unless entry
                model = FHIR::ImplementationGuide::ImplementationGuidePackageComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'resource', entry.xpath('./fhir:resource').map {|e| parse_xml_entry_ImplementationGuidePackageResourceComponent(e)})
                model
            end
            
            def parse_xml_entry_ImplementationGuideGlobalComponent(entry) 
                return nil unless entry
                model = FHIR::ImplementationGuide::ImplementationGuideGlobalComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'type','fhirType',false)
                set_model_data(model, 'profile', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:profile')))
                model
            end
            
            def parse_xml_entry_ImplementationGuidePageComponent(entry) 
                return nil unless entry
                model = FHIR::ImplementationGuide::ImplementationGuidePageComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'source','source',false)
                parse_primitive_field(model,entry,'name','name',false)
                parse_primitive_field(model,entry,'kind','kind',false)
                parse_primitive_field(model,entry,'type','fhirType',true)
                parse_primitive_field(model,entry,'package','package',true)
                parse_primitive_field(model,entry,'format','format',false)
                set_model_data(model, 'page', entry.xpath('./fhir:page').map {|e| parse_xml_entry_ImplementationGuidePageComponent(e)})
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
                parse_primitive_field(model,entry,'experimental','experimental',false)
                parse_primitive_field(model,entry,'publisher','publisher',false)
                set_model_data(model, 'contact', entry.xpath('./fhir:contact').map {|e| parse_xml_entry_ImplementationGuideContactComponent(e)})
                parse_primitive_field(model,entry,'date','date',false)
                parse_primitive_field(model,entry,'description','description',false)
                set_model_data(model, 'useContext', entry.xpath('./fhir:useContext').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'copyright','copyright',false)
                parse_primitive_field(model,entry,'fhirVersion','fhirVersion',false)
                set_model_data(model, 'dependency', entry.xpath('./fhir:dependency').map {|e| parse_xml_entry_ImplementationGuideDependencyComponent(e)})
                set_model_data(model, 'package', entry.xpath('./fhir:package').map {|e| parse_xml_entry_ImplementationGuidePackageComponent(e)})
                set_model_data(model, 'global', entry.xpath('./fhir:global').map {|e| parse_xml_entry_ImplementationGuideGlobalComponent(e)})
                parse_primitive_field(model,entry,'binary','binary',true)
                set_model_data(model, 'page', parse_xml_entry_ImplementationGuidePageComponent(entry.at_xpath('./fhir:page')))
                model
            end
        end
    end
end
