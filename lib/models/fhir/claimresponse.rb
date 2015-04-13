# Copyright (c) 2011-2015, HL7, Inc & The MITRE Corporation
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without modification, 
# are permitted provided that the following conditions are met:
# 
#     * Redistributions of source code must retain the above copyright notice, this 
#       list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright notice, 
#       this list of conditions and the following disclaimer in the documentation 
#       and/or other materials provided with the distribution.
#     * Neither the name of HL7 nor the names of its contributors may be used to 
#       endorse or promote products derived from this software without specific 
#       prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
# IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT 
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
# POSSIBILITY OF SUCH DAMAGE.

module FHIR
    class ClaimResponse 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::ClaimResponse
        
        SEARCH_PARAMS = [
            'identifier'
            ]
        
        VALID_CODES = {
            outcome: [ "complete", "error" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec adjudication
        class ItemAdjudicationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :code, class_name:'FHIR::Coding'
            validates_presence_of :code
            embeds_one :amount, class_name:'FHIR::Quantity'
            field :value, type: Float
        end
        
        # This is an ugly hack to deal with embedded structures in the spec adjudication
        class DetailAdjudicationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :code, class_name:'FHIR::Coding'
            validates_presence_of :code
            embeds_one :amount, class_name:'FHIR::Quantity'
            field :value, type: Float
        end
        
        # This is an ugly hack to deal with embedded structures in the spec adjudication
        class SubdetailAdjudicationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :code, class_name:'FHIR::Coding'
            validates_presence_of :code
            embeds_one :amount, class_name:'FHIR::Quantity'
            field :value, type: Float
        end
        
        # This is an ugly hack to deal with embedded structures in the spec subDetail
        class SubDetailComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :sequenceLinkId, type: Integer
            validates_presence_of :sequenceLinkId
            embeds_many :adjudication, class_name:'FHIR::ClaimResponse::SubdetailAdjudicationComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec detail
        class ItemDetailComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :sequenceLinkId, type: Integer
            validates_presence_of :sequenceLinkId
            embeds_many :adjudication, class_name:'FHIR::ClaimResponse::DetailAdjudicationComponent'
            embeds_many :subDetail, class_name:'FHIR::ClaimResponse::SubDetailComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec item
        class ItemsComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :sequenceLinkId, type: Integer
            validates_presence_of :sequenceLinkId
            field :noteNumber, type: Array # Array of Integers
            embeds_many :adjudication, class_name:'FHIR::ClaimResponse::ItemAdjudicationComponent'
            embeds_many :detail, class_name:'FHIR::ClaimResponse::ItemDetailComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec adjudication
        class AddedItemAdjudicationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :code, class_name:'FHIR::Coding'
            validates_presence_of :code
            embeds_one :amount, class_name:'FHIR::Quantity'
            field :value, type: Float
        end
        
        # This is an ugly hack to deal with embedded structures in the spec adjudication
        class AddedItemDetailAdjudicationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :code, class_name:'FHIR::Coding'
            validates_presence_of :code
            embeds_one :amount, class_name:'FHIR::Quantity'
            field :value, type: Float
        end
        
        # This is an ugly hack to deal with embedded structures in the spec detail
        class AddedItemsDetailComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :service, class_name:'FHIR::Coding'
            validates_presence_of :service
            embeds_one :fee, class_name:'FHIR::Quantity'
            embeds_many :adjudication, class_name:'FHIR::ClaimResponse::AddedItemDetailAdjudicationComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec addItem
        class AddedItemComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :sequenceLinkId, type: Array # Array of Integers
            embeds_one :service, class_name:'FHIR::Coding'
            validates_presence_of :service
            embeds_one :fee, class_name:'FHIR::Quantity'
            field :noteNumberLinkId, type: Array # Array of Integers
            embeds_many :adjudication, class_name:'FHIR::ClaimResponse::AddedItemAdjudicationComponent'
            embeds_many :detail, class_name:'FHIR::ClaimResponse::AddedItemsDetailComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec error
        class ErrorsComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :sequenceLinkId, type: Integer
            field :detailSequenceLinkId, type: Integer
            field :subdetailSequenceLinkId, type: Integer
            embeds_one :code, class_name:'FHIR::Coding'
            validates_presence_of :code
        end
        
        # This is an ugly hack to deal with embedded structures in the spec note
        class NotesComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ "display", "print", "printoper" ]
            }
            
            field :number, type: Integer
            embeds_one :fhirType, class_name:'FHIR::Coding'
            field :text, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec coverage
        class CoverageComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :sequence, type: Integer
            validates_presence_of :sequence
            field :focal, type: Boolean
            validates_presence_of :focal
            embeds_one :coverage, class_name:'FHIR::Reference'
            validates_presence_of :coverage
            field :businessArrangement, type: String
            embeds_one :relationship, class_name:'FHIR::Coding'
            validates_presence_of :relationship
            field :preAuthRef, type: Array # Array of Strings
            embeds_one :claimResponse, class_name:'FHIR::Reference'
            embeds_one :originalRuleset, class_name:'FHIR::Coding'
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :request, class_name:'FHIR::Reference'
        embeds_one :ruleset, class_name:'FHIR::Coding'
        embeds_one :originalRuleset, class_name:'FHIR::Coding'
        field :created, type: FHIR::PartialDateTime
        embeds_one :organization, class_name:'FHIR::Reference'
        embeds_one :requestProvider, class_name:'FHIR::Reference'
        embeds_one :requestOrganization, class_name:'FHIR::Reference'
        field :outcome, type: String
        validates :outcome, :inclusion => { in: VALID_CODES[:outcome], :allow_nil => true }
        field :disposition, type: String
        embeds_one :payeeType, class_name:'FHIR::Coding'
        embeds_many :item, class_name:'FHIR::ClaimResponse::ItemsComponent'
        embeds_many :addItem, class_name:'FHIR::ClaimResponse::AddedItemComponent'
        embeds_many :error, class_name:'FHIR::ClaimResponse::ErrorsComponent'
        embeds_one :totalCost, class_name:'FHIR::Quantity'
        embeds_one :unallocDeductable, class_name:'FHIR::Quantity'
        embeds_one :totalBenefit, class_name:'FHIR::Quantity'
        embeds_one :paymentAdjustment, class_name:'FHIR::Quantity'
        embeds_one :paymentAdjustmentReason, class_name:'FHIR::Coding'
        field :paymentDate, type: FHIR::PartialDateTime
        embeds_one :paymentAmount, class_name:'FHIR::Quantity'
        embeds_one :paymentRef, class_name:'FHIR::Identifier'
        embeds_one :reserved, class_name:'FHIR::Coding'
        embeds_one :form, class_name:'FHIR::Coding'
        embeds_many :note, class_name:'FHIR::ClaimResponse::NotesComponent'
        embeds_many :coverage, class_name:'FHIR::ClaimResponse::CoverageComponent'
        track_history
    end
end
