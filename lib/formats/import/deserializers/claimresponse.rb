module FHIR
    module Deserializer
        module ClaimResponse
        include FHIR::Formats::Utilities
        include FHIR::Deserializer::Utilities
            def parse_xml_entry_ItemAdjudicationComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::ItemAdjudicationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'amount', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:amount')))
                parse_primitive_field(model,entry,'value','value',false)
                model
            end
            
            def parse_xml_entry_DetailAdjudicationComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::DetailAdjudicationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'amount', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:amount')))
                parse_primitive_field(model,entry,'value','value',false)
                model
            end
            
            def parse_xml_entry_SubdetailAdjudicationComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::SubdetailAdjudicationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'amount', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:amount')))
                parse_primitive_field(model,entry,'value','value',false)
                model
            end
            
            def parse_xml_entry_SubDetailComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::SubDetailComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'sequenceLinkId','sequenceLinkId',false)
                set_model_data(model, 'adjudication', entry.xpath('./fhir:adjudication').map {|e| parse_xml_entry_SubdetailAdjudicationComponent(e)})
                model
            end
            
            def parse_xml_entry_ItemDetailComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::ItemDetailComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'sequenceLinkId','sequenceLinkId',false)
                set_model_data(model, 'adjudication', entry.xpath('./fhir:adjudication').map {|e| parse_xml_entry_DetailAdjudicationComponent(e)})
                set_model_data(model, 'subDetail', entry.xpath('./fhir:subDetail').map {|e| parse_xml_entry_SubDetailComponent(e)})
                model
            end
            
            def parse_xml_entry_ItemsComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::ItemsComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'sequenceLinkId','sequenceLinkId',false)
                parse_primitive_field(model,entry,'noteNumber','noteNumber',true)
                set_model_data(model, 'adjudication', entry.xpath('./fhir:adjudication').map {|e| parse_xml_entry_ItemAdjudicationComponent(e)})
                set_model_data(model, 'detail', entry.xpath('./fhir:detail').map {|e| parse_xml_entry_ItemDetailComponent(e)})
                model
            end
            
            def parse_xml_entry_AddedItemAdjudicationComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::AddedItemAdjudicationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'amount', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:amount')))
                parse_primitive_field(model,entry,'value','value',false)
                model
            end
            
            def parse_xml_entry_AddedItemDetailAdjudicationComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::AddedItemDetailAdjudicationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'amount', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:amount')))
                parse_primitive_field(model,entry,'value','value',false)
                model
            end
            
            def parse_xml_entry_AddedItemsDetailComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::AddedItemsDetailComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'service', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:service')))
                set_model_data(model, 'fee', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:fee')))
                set_model_data(model, 'adjudication', entry.xpath('./fhir:adjudication').map {|e| parse_xml_entry_AddedItemDetailAdjudicationComponent(e)})
                model
            end
            
            def parse_xml_entry_AddedItemComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::AddedItemComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'sequenceLinkId','sequenceLinkId',true)
                set_model_data(model, 'service', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:service')))
                set_model_data(model, 'fee', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:fee')))
                parse_primitive_field(model,entry,'noteNumberLinkId','noteNumberLinkId',true)
                set_model_data(model, 'adjudication', entry.xpath('./fhir:adjudication').map {|e| parse_xml_entry_AddedItemAdjudicationComponent(e)})
                set_model_data(model, 'detail', entry.xpath('./fhir:detail').map {|e| parse_xml_entry_AddedItemsDetailComponent(e)})
                model
            end
            
            def parse_xml_entry_ErrorsComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::ErrorsComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'sequenceLinkId','sequenceLinkId',false)
                parse_primitive_field(model,entry,'detailSequenceLinkId','detailSequenceLinkId',false)
                parse_primitive_field(model,entry,'subdetailSequenceLinkId','subdetailSequenceLinkId',false)
                set_model_data(model, 'code', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:code')))
                model
            end
            
            def parse_xml_entry_NotesComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::NotesComponent.new
                self.parse_element_data(model, entry)
                parse_primitive_field(model,entry,'number','number',false)
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                parse_primitive_field(model,entry,'text','text',false)
                model
            end
            
            def parse_xml_entry_CoverageComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::CoverageComponent.new
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
            
            def parse_xml_entry(entry) 
                return nil unless entry
                model = self.new
                self.parse_element_data(model, entry)
                self.parse_resource_data(model, entry)
                set_model_data(model, 'identifier', entry.xpath('./fhir:identifier').map {|e| FHIR::Identifier.parse_xml_entry(e)})
                set_model_data(model, 'request', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:request')))
                set_model_data(model, 'ruleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:ruleset')))
                set_model_data(model, 'originalRuleset', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:originalRuleset')))
                parse_primitive_field(model,entry,'created','created',false)
                set_model_data(model, 'organization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:organization')))
                set_model_data(model, 'requestProvider', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:requestProvider')))
                set_model_data(model, 'requestOrganization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:requestOrganization')))
                parse_primitive_field(model,entry,'outcome','outcome',false)
                parse_primitive_field(model,entry,'disposition','disposition',false)
                set_model_data(model, 'payeeType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:payeeType')))
                set_model_data(model, 'item', entry.xpath('./fhir:item').map {|e| parse_xml_entry_ItemsComponent(e)})
                set_model_data(model, 'addItem', entry.xpath('./fhir:addItem').map {|e| parse_xml_entry_AddedItemComponent(e)})
                set_model_data(model, 'error', entry.xpath('./fhir:error').map {|e| parse_xml_entry_ErrorsComponent(e)})
                set_model_data(model, 'totalCost', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:totalCost')))
                set_model_data(model, 'unallocDeductable', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:unallocDeductable')))
                set_model_data(model, 'totalBenefit', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:totalBenefit')))
                set_model_data(model, 'paymentAdjustment', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:paymentAdjustment')))
                set_model_data(model, 'paymentAdjustmentReason', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:paymentAdjustmentReason')))
                parse_primitive_field(model,entry,'paymentDate','paymentDate',false)
                set_model_data(model, 'paymentAmount', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:paymentAmount')))
                set_model_data(model, 'paymentRef', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:paymentRef')))
                set_model_data(model, 'reserved', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:reserved')))
                set_model_data(model, 'form', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:form')))
                set_model_data(model, 'note', entry.xpath('./fhir:note').map {|e| parse_xml_entry_NotesComponent(e)})
                set_model_data(model, 'coverage', entry.xpath('./fhir:coverage').map {|e| parse_xml_entry_CoverageComponent(e)})
                model
            end
        end
    end
end
