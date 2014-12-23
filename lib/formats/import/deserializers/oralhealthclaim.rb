module FHIR
    module Deserializer
        module OralHealthClaim
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_PayeeComponent(entry) 
                return nil unless entry
                model = FHIR::OralHealthClaim::PayeeComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'provider', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:provider')))
                set_model_data(model, 'organization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:organization')))
                set_model_data(model, 'person', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:person')))
                model
            end
            
            def parse_xml_entry_DiagnosisComponent(entry) 
                return nil unless entry
                model = FHIR::OralHealthClaim::DiagnosisComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'sequence', entry.at_xpath('./fhir:sequence/@value').try(:value))
                set_model_data(model, 'diagnosis', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:diagnosis')))
                model
            end
            
            def parse_xml_entry_CoverageComponent(entry) 
                return nil unless entry
                model = FHIR::OralHealthClaim::CoverageComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'sequence', entry.at_xpath('./fhir:sequence/@value').try(:value))
                set_model_data(model, 'focal', entry.at_xpath('./fhir:focal/@value').try(:value))
                set_model_data(model, 'coverage', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:coverage')))
                set_model_data(model, 'businessArrangement', entry.at_xpath('./fhir:businessArrangement/@value').try(:value))
                set_model_data(model, 'relationship', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:relationship')))
                set_model_data(model, 'preauthref', entry.xpath('./fhir:preauthref/@value').map {|e| e.value })
                set_model_data(model, 'claimResponse', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:claimResponse')))
                set_model_data(model, 'originalRuleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:originalRuleset')))
                model
            end
            
            def parse_xml_entry_MissingTeethComponent(entry) 
                return nil unless entry
                model = FHIR::OralHealthClaim::MissingTeethComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'tooth', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:tooth')))
                set_model_data(model, 'reason', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:reason')))
                set_model_data(model, 'extractiondate', entry.at_xpath('./fhir:extractiondate/@value').try(:value))
                model
            end
            
            def parse_xml_entry_OrthodonticPlanComponent(entry) 
                return nil unless entry
                model = FHIR::OralHealthClaim::OrthodonticPlanComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'start', entry.at_xpath('./fhir:start/@value').try(:value))
                set_model_data(model, 'examFee', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:examFee')))
                set_model_data(model, 'diagnosticFee', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:diagnosticFee')))
                set_model_data(model, 'initialPayment', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:initialPayment')))
                set_model_data(model, 'durationMonths', entry.at_xpath('./fhir:durationMonths/@value').try(:value))
                set_model_data(model, 'paymentCount', entry.at_xpath('./fhir:paymentCount/@value').try(:value))
                set_model_data(model, 'periodicPayment', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:periodicPayment')))
                model
            end
            
            def parse_xml_entry_SubDetailComponent(entry) 
                return nil unless entry
                model = FHIR::OralHealthClaim::SubDetailComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'sequence', entry.at_xpath('./fhir:sequence/@value').try(:value))
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'service', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:service')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'unitPrice', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:unitPrice')))
                set_model_data(model, 'factor', entry.at_xpath('./fhir:factor/@value').try(:value))
                set_model_data(model, 'points', entry.at_xpath('./fhir:points/@value').try(:value))
                set_model_data(model, 'net', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:net')))
                set_model_data(model, 'udi', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:udi')))
                model
            end
            
            def parse_xml_entry_DetailComponent(entry) 
                return nil unless entry
                model = FHIR::OralHealthClaim::DetailComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'sequence', entry.at_xpath('./fhir:sequence/@value').try(:value))
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'service', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:service')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'unitPrice', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:unitPrice')))
                set_model_data(model, 'factor', entry.at_xpath('./fhir:factor/@value').try(:value))
                set_model_data(model, 'points', entry.at_xpath('./fhir:points/@value').try(:value))
                set_model_data(model, 'net', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:net')))
                set_model_data(model, 'udi', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:udi')))
                set_model_data(model, 'subDetail', entry.xpath('./fhir:subDetail').map {|e| parse_xml_entry_SubDetailComponent(e)})
                model
            end
            
            def parse_xml_entry_ProsthesisComponent(entry) 
                return nil unless entry
                model = FHIR::OralHealthClaim::ProsthesisComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'initial', entry.at_xpath('./fhir:initial/@value').try(:value))
                set_model_data(model, 'priorDate', entry.at_xpath('./fhir:priorDate/@value').try(:value))
                set_model_data(model, 'priorMaterial', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:priorMaterial')))
                model
            end
            
            def parse_xml_entry_ItemsComponent(entry) 
                return nil unless entry
                model = FHIR::OralHealthClaim::ItemsComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'sequence', entry.at_xpath('./fhir:sequence/@value').try(:value))
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'provider', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:provider')))
                set_model_data(model, 'diagnosisLinkId', entry.xpath('./fhir:diagnosisLinkId/@value').map {|e| e.value })
                set_model_data(model, 'service', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:service')))
                set_model_data(model, 'serviceDate', entry.at_xpath('./fhir:serviceDate/@value').try(:value))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'unitPrice', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:unitPrice')))
                set_model_data(model, 'factor', entry.at_xpath('./fhir:factor/@value').try(:value))
                set_model_data(model, 'points', entry.at_xpath('./fhir:points/@value').try(:value))
                set_model_data(model, 'net', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:net')))
                set_model_data(model, 'udi', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:udi')))
                set_model_data(model, 'bodySite', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:bodySite')))
                set_model_data(model, 'subsite', entry.xpath('./fhir:subsite').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'modifier', entry.xpath('./fhir:modifier').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'detail', entry.xpath('./fhir:detail').map {|e| parse_xml_entry_DetailComponent(e)})
                set_model_data(model, 'prosthesis', parse_xml_entry_ProsthesisComponent(entry.at_xpath('./fhir:prosthesis')))
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'ruleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:ruleset')))
                set_model_data(model, 'originalRuleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:originalRuleset')))
                set_model_data(model, 'created', entry.at_xpath('./fhir:created/@value').try(:value))
                set_model_data(model, 'target', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:target')))
                set_model_data(model, 'provider', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:provider')))
                set_model_data(model, 'organization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:organization')))
                set_model_data(model, 'use', entry.at_xpath('./fhir:use/@value').try(:value))
                set_model_data(model, 'priority', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:priority')))
                set_model_data(model, 'fundsReserve', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:fundsReserve')))
                set_model_data(model, 'enterer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:enterer')))
                set_model_data(model, 'facility', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:facility')))
                set_model_data(model, 'payee', parse_xml_entry_PayeeComponent(entry.at_xpath('./fhir:payee')))
                set_model_data(model, 'referral', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:referral')))
                set_model_data(model, 'diagnosis', entry.xpath('./fhir:diagnosis').map {|e| parse_xml_entry_DiagnosisComponent(e)})
                set_model_data(model, 'condition', entry.xpath('./fhir:condition').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'coverage', entry.xpath('./fhir:coverage').map {|e| parse_xml_entry_CoverageComponent(e)})
                set_model_data(model, 'exception', entry.xpath('./fhir:exception').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'school', entry.at_xpath('./fhir:school/@value').try(:value))
                set_model_data(model, 'accident', entry.at_xpath('./fhir:accident/@value').try(:value))
                set_model_data(model, 'accidentType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:accidentType')))
                set_model_data(model, 'interventionException', entry.xpath('./fhir:interventionException').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'missingteeth', entry.xpath('./fhir:missingteeth').map {|e| parse_xml_entry_MissingTeethComponent(e)})
                set_model_data(model, 'orthoPlan', parse_xml_entry_OrthodonticPlanComponent(entry.at_xpath('./fhir:orthoPlan')))
                set_model_data(model, 'item', entry.xpath('./fhir:item').map {|e| parse_xml_entry_ItemsComponent(e)})
                set_model_data(model, 'additionalMaterials', entry.xpath('./fhir:additionalMaterials').map {|e| FHIR::Coding.parse_xml_entry(e)})
                model
            end
        end
    end
end
