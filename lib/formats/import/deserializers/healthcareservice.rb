module FHIR
    module Deserializer
        module HealthcareService
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ServiceTypeComponent(entry) 
                return nil unless entry
                model = FHIR::HealthcareService::ServiceTypeComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'specialty', entry.xpath('./fhir:specialty').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                model
            end
            
            def parse_xml_entry_HealthcareServiceAvailableTimeComponent(entry) 
                return nil unless entry
                model = FHIR::HealthcareService::HealthcareServiceAvailableTimeComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'daysOfWeek', entry.xpath('./fhir:daysOfWeek').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'allDay', entry.at_xpath('./fhir:allDay/@value').try(:value))
                set_model_data(model, 'availableStartTime', entry.at_xpath('./fhir:availableStartTime/@value').try(:value))
                set_model_data(model, 'availableEndTime', entry.at_xpath('./fhir:availableEndTime/@value').try(:value))
                model
            end
            
            def parse_xml_entry_HealthcareServiceNotAvailableTimeComponent(entry) 
                return nil unless entry
                model = FHIR::HealthcareService::HealthcareServiceNotAvailableTimeComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'description', entry.at_xpath('./fhir:description/@value').try(:value))
                set_model_data(model, 'startDate', entry.at_xpath('./fhir:startDate/@value').try(:value))
                set_model_data(model, 'endDate', entry.at_xpath('./fhir:endDate/@value').try(:value))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'location', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:location')))
                set_model_data(model, 'serviceCategory', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:serviceCategory')))
                set_model_data(model, 'serviceType', entry.xpath('./fhir:serviceType').map {|e| parse_xml_entry_ServiceTypeComponent(e)})
                set_model_data(model, 'serviceName', entry.at_xpath('./fhir:serviceName/@value').try(:value))
                set_model_data(model, 'comment', entry.at_xpath('./fhir:comment/@value').try(:value))
                set_model_data(model, 'extraDetails', entry.at_xpath('./fhir:extraDetails/@value').try(:value))
                set_model_data(model, 'freeProvisionCode', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:freeProvisionCode')))
                set_model_data(model, 'eligibility', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:eligibility')))
                set_model_data(model, 'eligibilityNote', entry.at_xpath('./fhir:eligibilityNote/@value').try(:value))
                set_model_data(model, 'appointmentRequired', FHIR::CodeableConcept.parse_xml_entry(entry.at_xpath('./fhir:appointmentRequired')))
                set_model_data(model, 'imageURI', entry.at_xpath('./fhir:imageURI/@value').try(:value))
                set_model_data(model, 'availableTime', entry.xpath('./fhir:availableTime').map {|e| parse_xml_entry_HealthcareServiceAvailableTimeComponent(e)})
                set_model_data(model, 'notAvailableTime', entry.xpath('./fhir:notAvailableTime').map {|e| parse_xml_entry_HealthcareServiceNotAvailableTimeComponent(e)})
                set_model_data(model, 'availabilityExceptions', entry.at_xpath('./fhir:availabilityExceptions/@value').try(:value))
                set_model_data(model, 'publicKey', entry.at_xpath('./fhir:publicKey/@value').try(:value))
                set_model_data(model, 'programName', entry.xpath('./fhir:programName/@value').map {|e| e.value })
                set_model_data(model, 'contactPoint', entry.xpath('./fhir:contactPoint').map {|e| FHIR::ContactPoint.parse_xml_entry(e)})
                set_model_data(model, 'characteristic', entry.xpath('./fhir:characteristic').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'referralMethod', entry.xpath('./fhir:referralMethod').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'setting', entry.xpath('./fhir:setting').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'targetGroup', entry.xpath('./fhir:targetGroup').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'coverageArea', entry.xpath('./fhir:coverageArea').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'catchmentArea', entry.xpath('./fhir:catchmentArea').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                set_model_data(model, 'serviceCode', entry.xpath('./fhir:serviceCode').map {|e| FHIR::CodeableConcept.parse_xml_entry(e)})
                model
            end
        end
    end
end
