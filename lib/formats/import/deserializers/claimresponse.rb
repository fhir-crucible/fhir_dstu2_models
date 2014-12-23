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
                set_model_data(model, 'value', entry.at_xpath('./fhir:value/@value').try(:value))
                model
            end
            
            def parse_xml_entry_DetailAdjudicationComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::DetailAdjudicationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'amount', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:amount')))
                set_model_data(model, 'value', entry.at_xpath('./fhir:value/@value').try(:value))
                model
            end
            
            def parse_xml_entry_SubdetailAdjudicationComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::SubdetailAdjudicationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'amount', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:amount')))
                set_model_data(model, 'value', entry.at_xpath('./fhir:value/@value').try(:value))
                model
            end
            
            def parse_xml_entry_ItemSubdetailComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::ItemSubdetailComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'sequenceLinkId', entry.at_xpath('./fhir:sequenceLinkId/@value').try(:value))
                set_model_data(model, 'adjudication', entry.xpath('./fhir:adjudication').map {|e| parse_xml_entry_SubdetailAdjudicationComponent(e)})
                model
            end
            
            def parse_xml_entry_ItemDetailComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::ItemDetailComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'sequenceLinkId', entry.at_xpath('./fhir:sequenceLinkId/@value').try(:value))
                set_model_data(model, 'adjudication', entry.xpath('./fhir:adjudication').map {|e| parse_xml_entry_DetailAdjudicationComponent(e)})
                set_model_data(model, 'subdetail', entry.xpath('./fhir:subdetail').map {|e| parse_xml_entry_ItemSubdetailComponent(e)})
                model
            end
            
            def parse_xml_entry_ItemsComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::ItemsComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'sequenceLinkId', entry.at_xpath('./fhir:sequenceLinkId/@value').try(:value))
                set_model_data(model, 'noteNumber', entry.xpath('./fhir:noteNumber/@value').map {|e| e.value })
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
                set_model_data(model, 'value', entry.at_xpath('./fhir:value/@value').try(:value))
                model
            end
            
            def parse_xml_entry_AddedItemDetailAdjudicationComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::AddedItemDetailAdjudicationComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'code', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:code')))
                set_model_data(model, 'amount', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:amount')))
                set_model_data(model, 'value', entry.at_xpath('./fhir:value/@value').try(:value))
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
                set_model_data(model, 'sequenceLinkId', entry.xpath('./fhir:sequenceLinkId/@value').map {|e| e.value })
                set_model_data(model, 'service', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:service')))
                set_model_data(model, 'fee', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:fee')))
                set_model_data(model, 'noteNumberLinkId', entry.xpath('./fhir:noteNumberLinkId/@value').map {|e| e.value })
                set_model_data(model, 'adjudication', entry.xpath('./fhir:adjudication').map {|e| parse_xml_entry_AddedItemAdjudicationComponent(e)})
                set_model_data(model, 'detail', entry.xpath('./fhir:detail').map {|e| parse_xml_entry_AddedItemsDetailComponent(e)})
                model
            end
            
            def parse_xml_entry_ErrorsComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::ErrorsComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'sequenceLinkId', entry.at_xpath('./fhir:sequenceLinkId/@value').try(:value))
                set_model_data(model, 'detailSequenceLinkId', entry.at_xpath('./fhir:detailSequenceLinkId/@value').try(:value))
                set_model_data(model, 'subdetailSequenceLinkId', entry.at_xpath('./fhir:subdetailSequenceLinkId/@value').try(:value))
                set_model_data(model, 'code', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:code')))
                model
            end
            
            def parse_xml_entry_NotesComponent(entry) 
                return nil unless entry
                model = FHIR::ClaimResponse::NotesComponent.new
                self.parse_element_data(model, entry)
                set_model_data(model, 'number', entry.at_xpath('./fhir:number/@value').try(:value))
                set_model_data(model, 'fhirType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:type')))
                set_model_data(model, 'text', entry.at_xpath('./fhir:text/@value').try(:value))
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
                set_model_data(model, 'created', entry.at_xpath('./fhir:created/@value').try(:value))
                set_model_data(model, 'organization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:organization')))
                set_model_data(model, 'requestProvider', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:requestProvider')))
                set_model_data(model, 'requestOrganization', FHIR::Reference.parse_xml_entry(entry.at_xpath('./fhir:requestOrganization')))
                set_model_data(model, 'outcome', entry.at_xpath('./fhir:outcome/@value').try(:value))
                set_model_data(model, 'disposition', entry.at_xpath('./fhir:disposition/@value').try(:value))
                set_model_data(model, 'payeeType', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:payeeType')))
                set_model_data(model, 'item', entry.xpath('./fhir:item').map {|e| parse_xml_entry_ItemsComponent(e)})
                set_model_data(model, 'additem', entry.xpath('./fhir:additem').map {|e| parse_xml_entry_AddedItemComponent(e)})
                set_model_data(model, 'error', entry.xpath('./fhir:error').map {|e| parse_xml_entry_ErrorsComponent(e)})
                set_model_data(model, 'totalCost', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:totalCost')))
                set_model_data(model, 'unallocDeductable', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:unallocDeductable')))
                set_model_data(model, 'totalBenefit', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:totalBenefit')))
                set_model_data(model, 'paymentAdjustment', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:paymentAdjustment')))
                set_model_data(model, 'paymentAdjustmentReason', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:paymentAdjustmentReason')))
                set_model_data(model, 'paymentDate', entry.at_xpath('./fhir:paymentDate/@value').try(:value))
                set_model_data(model, 'paymentAmount', FHIR::Quantity.parse_xml_entry(entry.at_xpath('./fhir:paymentAmount')))
                set_model_data(model, 'paymentRef', FHIR::Identifier.parse_xml_entry(entry.at_xpath('./fhir:paymentRef')))
                set_model_data(model, 'reserved', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:reserved')))
                set_model_data(model, 'form', FHIR::Coding.parse_xml_entry(entry.at_xpath('./fhir:form')))
                set_model_data(model, 'note', entry.xpath('./fhir:note').map {|e| parse_xml_entry_NotesComponent(e)})
                model
            end
        end
    end
end
