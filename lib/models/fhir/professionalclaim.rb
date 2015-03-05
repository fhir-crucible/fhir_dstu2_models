# Copyright (c) 2011-2014, HL7, Inc & The MITRE Corporation
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
    class ProfessionalClaim 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::ProfessionalClaim
        
        SEARCH_PARAMS = [
            'identifier',
            'use',
            'patient',
            'priority'
            ]
        
        VALID_CODES = {
            use: [ "complete", "proposed", "exploratory", "other" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec payee
        class PayeeComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :fhirType, class_name:'FHIR::Coding'
            embeds_one :provider, class_name:'FHIR::Reference'
            embeds_one :organization, class_name:'FHIR::Reference'
            embeds_one :person, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec diagnosis
        class DiagnosisComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :sequence, type: Integer
            validates_presence_of :sequence
            embeds_one :diagnosis, class_name:'FHIR::Coding'
            validates_presence_of :diagnosis
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
            field :preauthref, type: Array # Array of Strings
            embeds_one :claimResponse, class_name:'FHIR::Reference'
            embeds_one :originalRuleset, class_name:'FHIR::Coding'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec subDetail
        class SubDetailComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :sequence, type: Integer
            validates_presence_of :sequence
            embeds_one :fhirType, class_name:'FHIR::Coding'
            validates_presence_of :fhirType
            embeds_one :service, class_name:'FHIR::Coding'
            validates_presence_of :service
            embeds_one :quantity, class_name:'FHIR::Quantity'
            embeds_one :unitPrice, class_name:'FHIR::Quantity'
            field :factor, type: Float
            field :points, type: Float
            embeds_one :net, class_name:'FHIR::Quantity'
            embeds_one :udi, class_name:'FHIR::Coding'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec detail
        class DetailComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :sequence, type: Integer
            validates_presence_of :sequence
            embeds_one :fhirType, class_name:'FHIR::Coding'
            validates_presence_of :fhirType
            embeds_one :service, class_name:'FHIR::Coding'
            validates_presence_of :service
            embeds_one :quantity, class_name:'FHIR::Quantity'
            embeds_one :unitPrice, class_name:'FHIR::Quantity'
            field :factor, type: Float
            field :points, type: Float
            embeds_one :net, class_name:'FHIR::Quantity'
            embeds_one :udi, class_name:'FHIR::Coding'
            embeds_many :subDetail, class_name:'FHIR::ProfessionalClaim::SubDetailComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec item
        class ItemsComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :sequence, type: Integer
            validates_presence_of :sequence
            embeds_one :fhirType, class_name:'FHIR::Coding'
            validates_presence_of :fhirType
            embeds_one :provider, class_name:'FHIR::Reference'
            field :diagnosisLinkId, type: Array # Array of Integers
            embeds_one :service, class_name:'FHIR::Coding'
            validates_presence_of :service
            field :serviceDate, type: FHIR::PartialDateTime
            embeds_one :quantity, class_name:'FHIR::Quantity'
            embeds_one :unitPrice, class_name:'FHIR::Quantity'
            field :factor, type: Float
            field :points, type: Float
            embeds_one :net, class_name:'FHIR::Quantity'
            embeds_one :udi, class_name:'FHIR::Coding'
            embeds_one :bodySite, class_name:'FHIR::Coding'
            embeds_many :subsite, class_name:'FHIR::Coding'
            embeds_many :modifier, class_name:'FHIR::Coding'
            embeds_many :detail, class_name:'FHIR::ProfessionalClaim::DetailComponent'
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :ruleset, class_name:'FHIR::Coding'
        embeds_one :originalRuleset, class_name:'FHIR::Coding'
        field :created, type: FHIR::PartialDateTime
        embeds_one :target, class_name:'FHIR::Reference'
        embeds_one :provider, class_name:'FHIR::Reference'
        embeds_one :organization, class_name:'FHIR::Reference'
        field :use, type: String
        validates :use, :inclusion => { in: VALID_CODES[:use], :allow_nil => true }
        embeds_one :priority, class_name:'FHIR::Coding'
        embeds_one :fundsReserve, class_name:'FHIR::Coding'
        embeds_one :enterer, class_name:'FHIR::Reference'
        embeds_one :facility, class_name:'FHIR::Reference'
        embeds_one :payee, class_name:'FHIR::ProfessionalClaim::PayeeComponent'
        embeds_one :referral, class_name:'FHIR::Reference'
        embeds_many :diagnosis, class_name:'FHIR::ProfessionalClaim::DiagnosisComponent'
        embeds_many :condition, class_name:'FHIR::Coding'
        embeds_one :patient, class_name:'FHIR::Reference'
        validates_presence_of :patient
        embeds_many :coverage, class_name:'FHIR::ProfessionalClaim::CoverageComponent'
        embeds_many :exception, class_name:'FHIR::Coding'
        field :school, type: String
        field :accident, type: FHIR::PartialDateTime
        embeds_one :accidentType, class_name:'FHIR::Coding'
        embeds_many :interventionException, class_name:'FHIR::Coding'
        embeds_many :item, class_name:'FHIR::ProfessionalClaim::ItemsComponent'
        embeds_many :additionalMaterials, class_name:'FHIR::Coding'
        track_history
    end
end
