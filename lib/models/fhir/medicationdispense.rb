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
    class MedicationDispense 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::MedicationDispense
        
        SEARCH_PARAMS = [
            'identifier',
            'code',
            'receiver',
            'destination',
            'medication',
            'responsibleparty',
            'type',
            'whenhandedover',
            'whenprepared',
            'dispenser',
            'prescription',
            'patient',
            'status'
        ]
        
        VALID_CODES = {
            status: [ 'in-progress', 'on-hold', 'completed', 'entered-in-error', 'stopped' ]
        }
        
        MULTIPLE_TYPES = {
            medication: [ 'medicationCodeableConcept', 'medicationReference' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec dosageInstruction
        class MedicationDispenseDosageInstructionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            MULTIPLE_TYPES = {
                asNeeded: [ 'asNeededBoolean', 'asNeededCodeableConcept' ],
                site: [ 'siteCodeableConcept', 'siteReference' ],
                dose: [ 'doseRange', 'doseQuantity' ],
                rate: [ 'rateRatio', 'rateRange' ]
            }
            
            field :text, type: String
            embeds_one :additionalInstructions, class_name:'FHIR::CodeableConcept'
            embeds_one :timing, class_name:'FHIR::Timing'
            field :asNeededBoolean, type: Boolean
            embeds_one :asNeededCodeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :siteCodeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :siteReference, class_name:'FHIR::Reference'
            embeds_one :route, class_name:'FHIR::CodeableConcept'
            embeds_one :method, class_name:'FHIR::CodeableConcept'
            embeds_one :doseRange, class_name:'FHIR::Range'
            embeds_one :doseQuantity, class_name:'FHIR::Quantity'
            embeds_one :rateRatio, class_name:'FHIR::Ratio'
            embeds_one :rateRange, class_name:'FHIR::Range'
            embeds_one :maxDosePerPeriod, class_name:'FHIR::Ratio'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec substitution
        class MedicationDispenseSubstitutionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
            validates_presence_of :fhirType
            embeds_many :reason, class_name:'FHIR::CodeableConcept'
            embeds_many :responsibleParty, class_name:'FHIR::Reference'
        end
        
        embeds_one :identifier, class_name:'FHIR::Identifier'
        field :status, type: String
        embeds_one :patient, class_name:'FHIR::Reference'
        embeds_one :dispenser, class_name:'FHIR::Reference'
        embeds_many :authorizingPrescription, class_name:'FHIR::Reference'
        embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
        embeds_one :quantity, class_name:'FHIR::Quantity'
        embeds_one :daysSupply, class_name:'FHIR::Quantity'
        embeds_one :medicationCodeableConcept, class_name:'FHIR::CodeableConcept'
        validates_presence_of :medicationCodeableConcept
        embeds_one :medicationReference, class_name:'FHIR::Reference'
        validates_presence_of :medicationReference
        field :whenPrepared, type: String
        validates :whenPrepared, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        field :whenHandedOver, type: String
        validates :whenHandedOver, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        embeds_one :destination, class_name:'FHIR::Reference'
        embeds_many :receiver, class_name:'FHIR::Reference'
        field :note, type: String
        embeds_many :dosageInstruction, class_name:'FHIR::MedicationDispense::MedicationDispenseDosageInstructionComponent'
        embeds_one :substitution, class_name:'FHIR::MedicationDispense::MedicationDispenseSubstitutionComponent'
        track_history
    end
end
