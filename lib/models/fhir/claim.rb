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
    class Claim 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Claim
        
        SEARCH_PARAMS = [
            'identifier',
            'provider',
            'use',
            'patient',
            'priority'
        ]
        
        VALID_CODES = {
            exception: [ 'student', 'disabled' ],
            condition: [ '123987' ],
            additionalMaterials: [ 'xray', 'image', 'email', 'model', 'document', 'other' ],
            fundsReserve: [ 'patient', 'provider', 'none' ],
            interventionException: [ 'unknown', 'other' ],
            use: [ 'complete', 'proposed', 'exploratory', 'other' ],
            ruleset: [ 'x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3' ],
            originalRuleset: [ 'x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3' ],
            priority: [ 'stat', 'normal', 'deferred' ],
            fhirType: [ 'institutional', 'oral', 'pharmacy', 'professional', 'vision' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec payee
        class PayeeComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ 'subscriber', 'provider', 'other' ]
            }
            
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
            
            VALID_CODES = {
                diagnosis: [ '123456', '123457', '987654', '123987', '112233', '997755', '321789' ]
            }
            
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
            
            VALID_CODES = {
                originalRuleset: [ 'x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3' ],
                relationship: [ '1', '2', '3', '4', '5' ]
            }
            
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
        
        # This is an ugly hack to deal with embedded structures in the spec subDetail
        class SubDetailComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                service: [ '1101', '1102', '1103', '1201', '1205', '2101', '2102', '2141', '2601', '11101', '11102', '11103', '11104', '21211', '21212', '27211', '99111', '99333', '99555' ],
                udi: [ '{01}123456789' ]
            }
            
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
            
            VALID_CODES = {
                service: [ '1101', '1102', '1103', '1201', '1205', '2101', '2102', '2141', '2601', '11101', '11102', '11103', '11104', '21211', '21212', '27211', '99111', '99333', '99555' ],
                udi: [ '{01}123456789' ]
            }
            
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
            embeds_many :subDetail, class_name:'FHIR::Claim::SubDetailComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec prosthesis
        class ProsthesisComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                priorMaterial: [ '1', '2', '3', '4' ]
            }
            
            field :initial, type: Boolean
            field :priorDate, type: String
            validates :priorDate, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1]))?)?\Z/ }
            embeds_one :priorMaterial, class_name:'FHIR::Coding'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec item
        class ItemsComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirModifier: [ 'A', 'B', 'C', 'E', 'X' ],
                bodySite: [ '0', '1', '2', '3', '4', '5', '6', '7', '8', '11', '12', '13', '14', '15', '16', '17', '18', '21', '22', '23', '24', '25', '26', '27', '28', '31', '32', '33', '34', '35', '36', '37', '38', '41', '42', '43', '44', '45', '46', '47', '48' ],
                service: [ '1101', '1102', '1103', '1201', '1205', '2101', '2102', '2141', '2601', '11101', '11102', '11103', '11104', '21211', '21212', '27211', '99111', '99333', '99555' ],
                subSite: [ 'M', 'O', 'I', 'D', 'B', 'V', 'L', 'MO', 'DO', 'DI', 'MOD' ],
                udi: [ '{01}123456789' ]
            }
            
            field :sequence, type: Integer
            validates_presence_of :sequence
            embeds_one :fhirType, class_name:'FHIR::Coding'
            validates_presence_of :fhirType
            embeds_one :provider, class_name:'FHIR::Reference'
            field :diagnosisLinkId, type: Array # Array of Integers
            embeds_one :service, class_name:'FHIR::Coding'
            validates_presence_of :service
            field :serviceDate, type: String
            validates :serviceDate, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1]))?)?\Z/ }
            embeds_one :quantity, class_name:'FHIR::Quantity'
            embeds_one :unitPrice, class_name:'FHIR::Quantity'
            field :factor, type: Float
            field :points, type: Float
            embeds_one :net, class_name:'FHIR::Quantity'
            embeds_one :udi, class_name:'FHIR::Coding'
            embeds_one :bodySite, class_name:'FHIR::Coding'
            embeds_many :subSite, class_name:'FHIR::Coding'
            embeds_many :fhirModifier, class_name:'FHIR::Coding'
            embeds_many :detail, class_name:'FHIR::Claim::DetailComponent'
            embeds_one :prosthesis, class_name:'FHIR::Claim::ProsthesisComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec missingTeeth
        class MissingTeethComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                reason: [ 'E', 'C', 'U', 'O' ],
                tooth: [ '11', '12', '13', '14', '15', '16', '17', '18', '21', '22', '23', '24', '25', '26', '27', '28', '31', '32', '33', '34', '35', '36', '37', '38', '41', '42', '43', '44', '45', '46', '47', '48' ]
            }
            
            embeds_one :tooth, class_name:'FHIR::Coding'
            validates_presence_of :tooth
            embeds_one :reason, class_name:'FHIR::Coding'
            field :extractionDate, type: String
            validates :extractionDate, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1]))?)?\Z/ }
        end
        
        field :fhirType, type: String
        validates_presence_of :fhirType
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :ruleset, class_name:'FHIR::Coding'
        embeds_one :originalRuleset, class_name:'FHIR::Coding'
        field :created, type: String
        validates :created, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        embeds_one :target, class_name:'FHIR::Reference'
        embeds_one :provider, class_name:'FHIR::Reference'
        embeds_one :organization, class_name:'FHIR::Reference'
        field :use, type: String
        embeds_one :priority, class_name:'FHIR::Coding'
        embeds_one :fundsReserve, class_name:'FHIR::Coding'
        embeds_one :enterer, class_name:'FHIR::Reference'
        embeds_one :facility, class_name:'FHIR::Reference'
        embeds_one :prescription, class_name:'FHIR::Reference'
        embeds_one :originalPrescription, class_name:'FHIR::Reference'
        embeds_one :payee, class_name:'FHIR::Claim::PayeeComponent'
        embeds_one :referral, class_name:'FHIR::Reference'
        embeds_many :diagnosis, class_name:'FHIR::Claim::DiagnosisComponent'
        embeds_many :condition, class_name:'FHIR::Coding'
        embeds_one :patient, class_name:'FHIR::Reference'
        validates_presence_of :patient
        embeds_many :coverage, class_name:'FHIR::Claim::CoverageComponent'
        embeds_many :exception, class_name:'FHIR::Coding'
        field :school, type: String
        field :accident, type: String
        validates :accident, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1]))?)?\Z/ }
        embeds_one :accidentType, class_name:'FHIR::Coding'
        embeds_many :interventionException, class_name:'FHIR::Coding'
        embeds_many :item, class_name:'FHIR::Claim::ItemsComponent'
        embeds_many :additionalMaterials, class_name:'FHIR::Coding'
        embeds_many :missingTeeth, class_name:'FHIR::Claim::MissingTeethComponent'
        track_history
    end
end
