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
    class MedicationStatement 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::MedicationStatement
        
        SEARCH_PARAMS = [
            'identifier',
            'code',
            'patient',
            'medication',
            'source',
            'effectivedate',
            'status'
        ]
        
        VALID_CODES = {
            reasonNotTaken: [ 'a', 'b', 'c', 'd' ],
            status: [ 'active', 'completed', 'entered-in-error', 'intended' ]
        }
        
        MULTIPLE_TYPES = {
            effective: [ 'effectiveDateTime', 'effectivePeriod' ],
            medication: [ 'medicationCodeableConcept', 'medicationReference' ],
            reasonForUse: [ 'reasonForUseCodeableConcept', 'reasonForUseReference' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec dosage
        class MedicationStatementDosageComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            MULTIPLE_TYPES = {
                asNeeded: [ 'asNeededBoolean', 'asNeededCodeableConcept' ],
                site: [ 'siteCodeableConcept', 'siteReference' ],
                quantity: [ 'quantityQuantity', 'quantityRange' ],
                rate: [ 'rateRatio', 'rateRange' ]
            }
            
            field :text, type: String
            embeds_one :timing, class_name:'FHIR::Timing'
            field :asNeededBoolean, type: Boolean
            embeds_one :asNeededCodeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :siteCodeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :siteReference, class_name:'FHIR::Reference'
            embeds_one :route, class_name:'FHIR::CodeableConcept'
            embeds_one :method, class_name:'FHIR::CodeableConcept'
            embeds_one :quantityQuantity, class_name:'FHIR::Quantity'
            embeds_one :quantityRange, class_name:'FHIR::Range'
            embeds_one :rateRatio, class_name:'FHIR::Ratio'
            embeds_one :rateRange, class_name:'FHIR::Range'
            embeds_one :maxDosePerPeriod, class_name:'FHIR::Ratio'
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :patient, class_name:'FHIR::Reference'
        validates_presence_of :patient
        embeds_one :informationSource, class_name:'FHIR::Reference'
        field :dateAsserted, type: String
        validates :dateAsserted, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        field :wasNotTaken, type: Boolean
        embeds_many :reasonNotTaken, class_name:'FHIR::CodeableConcept'
        embeds_one :reasonForUseCodeableConcept, class_name:'FHIR::CodeableConcept'
        embeds_one :reasonForUseReference, class_name:'FHIR::Reference'
        field :effectiveDateTime, type: String
        validates :effectiveDateTime, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        embeds_one :effectivePeriod, class_name:'FHIR::Period'
        field :note, type: String
        embeds_many :supportingInformation, class_name:'FHIR::Reference'
        embeds_one :medicationCodeableConcept, class_name:'FHIR::CodeableConcept'
        validates_presence_of :medicationCodeableConcept
        embeds_one :medicationReference, class_name:'FHIR::Reference'
        validates_presence_of :medicationReference
        embeds_many :dosage, class_name:'FHIR::MedicationStatement::MedicationStatementDosageComponent'
        track_history
    end
end
