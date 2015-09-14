module FHIR
    module Deserializer
        module Encounter
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_EncounterStatusHistoryComponent(entry) 
                return nil unless entry
                model = FHIR::Encounter::EncounterStatusHistoryComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                model
            end
            
            def parse_xml_entry_EncounterParticipantComponent(entry) 
                return nil unless entry
                model = FHIR::Encounter::EncounterParticipantComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', entry.xpath('./fhir:type').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                set_model_data(model, 'individual', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:individual')))
                model
            end
            
            def parse_xml_entry_EncounterHospitalizationComponent(entry) 
                return nil unless entry
                model = FHIR::Encounter::EncounterHospitalizationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'preAdmissionIdentifier', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:preAdmissionIdentifier')))
                set_model_data(model, 'origin', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:origin')))
                set_model_data(model, 'admitSource', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:admitSource')))
                set_model_data(model, 'admittingDiagnosis', entry.xpath('./fhir:admittingDiagnosis').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'reAdmission', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:reAdmission')))
                set_model_data(model, 'dietPreference', entry.xpath('./fhir:dietPreference').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'specialCourtesy', entry.xpath('./fhir:specialCourtesy').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'specialArrangement', entry.xpath('./fhir:specialArrangement').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'destination', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:destination')))
                set_model_data(model, 'dischargeDisposition', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:dischargeDisposition')))
                set_model_data(model, 'dischargeDiagnosis', entry.xpath('./fhir:dischargeDiagnosis').map {|e| FHIR::Reference.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_EncounterLocationComponent(entry) 
                return nil unless entry
                model = FHIR::Encounter::EncounterLocationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'location', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:location')))
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'status','status',false)
                set_model_data(model, 'statusHistory', entry.xpath('./fhir:statusHistory').map {|e| parse_xml_entry_EncounterStatusHistoryComponent(e)})
                parse_primitive_field(model,entry,'class','fhirClass',false)
                set_model_data(model, 'fhirType', entry.xpath('./fhir:type').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'priority', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:priority')))
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'episodeOfCare', entry.xpath('./fhir:episodeOfCare').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'incomingReferral', entry.xpath('./fhir:incomingReferral').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'participant', entry.xpath('./fhir:participant').map {|e| parse_xml_entry_EncounterParticipantComponent(e)})
                set_model_data(model, 'appointment', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:appointment')))
                set_model_data(model, 'period', FHIR::Period.parse_xml_entry(entry.at_xpath('./fhir:period')))
                set_model_data(model, 'length', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:length')))
                set_model_data(model, 'reason', entry.xpath('./fhir:reason').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'indication', entry.xpath('./fhir:indication').map {|e| FHIR::Reference.parse_xml_entry(e)})
                set_model_data(model, 'hospitalization', parse_xml_entry_EncounterHospitalizationComponent(entry.at_xpath('./fhir:hospitalization')))
                set_model_data(model, 'location', entry.xpath('./fhir:location').map {|e| parse_xml_entry_EncounterLocationComponent(e)})
                set_model_data(model, 'serviceProvider', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:serviceProvider')))
                set_model_data(model, 'partOf', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:partOf')))
                model
            end
        end
    end
end
