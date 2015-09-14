module FHIR
    module Deserializer
        module Claim
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_PayeeComponent(entry) 
                return nil unless entry
                model = FHIR::Claim::PayeeComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'provider', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:provider')))
                set_model_data(model, 'organization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:organization')))
                set_model_data(model, 'person', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:person')))
                model
            end
            
            def parse_xml_entry_DiagnosisComponent(entry) 
                return nil unless entry
                model = FHIR::Claim::DiagnosisComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'sequence','sequence',false)
                set_model_data(model, 'diagnosis', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:diagnosis')))
                model
            end
            
            def parse_xml_entry_CoverageComponent(entry) 
                return nil unless entry
                model = FHIR::Claim::CoverageComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'sequence','sequence',false)
                parse_primitive_field(model,entry,'focal','focal',false)
                set_model_data(model, 'coverage', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:coverage')))
                parse_primitive_field(model,entry,'businessArrangement','businessArrangement',false)
                set_model_data(model, 'relationship', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:relationship')))
                parse_primitive_field(model,entry,'preAuthRef','preAuthRef',true)
                set_model_data(model, 'claimResponse', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:claimResponse')))
                set_model_data(model, 'originalRuleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:originalRuleset')))
                model
            end
            
            def parse_xml_entry_SubDetailComponent(entry) 
                return nil unless entry
                model = FHIR::Claim::SubDetailComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'sequence','sequence',false)
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'service', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:service')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'unitPrice', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:unitPrice')))
                parse_primitive_field(model,entry,'factor','factor',false)
                parse_primitive_field(model,entry,'points','points',false)
                set_model_data(model, 'net', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:net')))
                set_model_data(model, 'udi', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:udi')))
                model
            end
            
            def parse_xml_entry_DetailComponent(entry) 
                return nil unless entry
                model = FHIR::Claim::DetailComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'sequence','sequence',false)
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'service', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:service')))
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'unitPrice', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:unitPrice')))
                parse_primitive_field(model,entry,'factor','factor',false)
                parse_primitive_field(model,entry,'points','points',false)
                set_model_data(model, 'net', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:net')))
                set_model_data(model, 'udi', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:udi')))
                set_model_data(model, 'subDetail', entry.xpath('./fhir:subDetail').map {|e| parse_xml_entry_SubDetailComponent(e)})
                model
            end
            
            def parse_xml_entry_ProsthesisComponent(entry) 
                return nil unless entry
                model = FHIR::Claim::ProsthesisComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'initial','initial',false)
                parse_primitive_field(model,entry,'priorDate','priorDate',false)
                set_model_data(model, 'priorMaterial', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:priorMaterial')))
                model
            end
            
            def parse_xml_entry_ItemsComponent(entry) 
                return nil unless entry
                model = FHIR::Claim::ItemsComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'sequence','sequence',false)
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'provider', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:provider')))
                parse_primitive_field(model,entry,'diagnosisLinkId','diagnosisLinkId',true)
                set_model_data(model, 'service', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:service')))
                parse_primitive_field(model,entry,'serviceDate','serviceDate',false)
                set_model_data(model, 'quantity', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:quantity')))
                set_model_data(model, 'unitPrice', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:unitPrice')))
                parse_primitive_field(model,entry,'factor','factor',false)
                parse_primitive_field(model,entry,'points','points',false)
                set_model_data(model, 'net', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:net')))
                set_model_data(model, 'udi', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:udi')))
                set_model_data(model, 'bodySite', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:bodySite')))
                set_model_data(model, 'subSite', entry.xpath('./fhir:subSite').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'fhirModifier', entry.xpath('./fhir:modifier').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'detail', entry.xpath('./fhir:detail').map {|e| parse_xml_entry_DetailComponent(e)})
                set_model_data(model, 'prosthesis', parse_xml_entry_ProsthesisComponent(entry.at_xpath('./fhir:prosthesis')))
                model
            end
            
            def parse_xml_entry_MissingTeethComponent(entry) 
                return nil unless entry
                model = FHIR::Claim::MissingTeethComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'tooth', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:tooth')))
                set_model_data(model, 'reason', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:reason')))
                parse_primitive_field(model,entry,'extractionDate','extractionDate',false)
                model
            end
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                parse_primitive_field(model,entry,'type','fhirType',false)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'ruleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:ruleset')))
                set_model_data(model, 'originalRuleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:originalRuleset')))
                parse_primitive_field(model,entry,'created','created',false)
                set_model_data(model, 'target', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:target')))
                set_model_data(model, 'provider', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:provider')))
                set_model_data(model, 'organization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:organization')))
                parse_primitive_field(model,entry,'use','use',false)
                set_model_data(model, 'priority', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:priority')))
                set_model_data(model, 'fundsReserve', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:fundsReserve')))
                set_model_data(model, 'enterer', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:enterer')))
                set_model_data(model, 'facility', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:facility')))
                set_model_data(model, 'prescription', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:prescription')))
                set_model_data(model, 'originalPrescription', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:originalPrescription')))
                set_model_data(model, 'payee', parse_xml_entry_PayeeComponent(entry.at_xpath('./fhir:payee')))
                set_model_data(model, 'referral', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:referral')))
                set_model_data(model, 'diagnosis', entry.xpath('./fhir:diagnosis').map {|e| parse_xml_entry_DiagnosisComponent(e)})
                set_model_data(model, 'condition', entry.xpath('./fhir:condition').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'patient', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:patient')))
                set_model_data(model, 'coverage', entry.xpath('./fhir:coverage').map {|e| parse_xml_entry_CoverageComponent(e)})
                set_model_data(model, 'exception', entry.xpath('./fhir:exception').map {|e| FHIR::Coding.parse_xml_entry(e)})
                parse_primitive_field(model,entry,'school','school',false)
                parse_primitive_field(model,entry,'accident','accident',false)
                set_model_data(model, 'accidentType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:accidentType')))
                set_model_data(model, 'interventionException', entry.xpath('./fhir:interventionException').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'item', entry.xpath('./fhir:item').map {|e| parse_xml_entry_ItemsComponent(e)})
                set_model_data(model, 'additionalMaterials', entry.xpath('./fhir:additionalMaterials').map {|e| FHIR::Coding.parse_xml_entry(e)})
                set_model_data(model, 'missingTeeth', entry.xpath('./fhir:missingTeeth').map {|e| parse_xml_entry_MissingTeethComponent(e)})
                model
            end
        end
    end
end
