module FHIR
    module Deserializer
        module EpisodeOfCare
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_EpisodeOfCareStatusHistoryComponent(entry) 
                return nil unless entry
                model = FHIR::EpisodeOfCare::EpisodeOfCareStatusHistoryComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                model
            end
            
            def parse_xml_entry_EpisodeOfCareCareTeamComponent(entry) 
                return nil unless entry
                model = FHIR::EpisodeOfCare::EpisodeOfCareCareTeamComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'role', entry.xpath('./fhir:role').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                set_model_data(model, 'member', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:member')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'statusHistory', entry.xpath('./fhir:statusHistory').map {|e| parse_xml_entry_EpisodeOfCareStatusHistoryComponent(e)})
                set_model_data(model, 'fhirType', entry.xpath('./fhir:type').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'condition', entry.xpath('./fhir:condition').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'managingOrganization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:managingOrganization')))
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                set_model_data(model, 'referralRequest', entry.xpath('./fhir:referralRequest').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'careManager', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:careManager')))
                set_model_data(model, 'careTeam', entry.xpath('./fhir:careTeam').map {|e| parse_xml_entry_EpisodeOfCareCareTeamComponent(e)})
                model
            end
        end
    end
end
