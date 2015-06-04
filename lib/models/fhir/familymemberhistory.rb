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
    class FamilyMemberHistory 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::FamilyMemberHistory
        
        SEARCH_PARAMS = [
            'date',
            'patient'
        ]
        
        VALID_CODES = {
            gender: [ "male", "female", "other", "unknown" ]
        }
        
        MULTIPLE_TYPES = {
            deceased: [ "deceasedBoolean", "deceasedAge", "deceasedRange", "deceasedDate", "deceasedString" ],
            born: [ "bornPeriod", "bornDate", "bornString" ],
            age: [ "ageAge", "ageRange", "ageString" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec condition
        class FamilyMemberHistoryConditionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            MULTIPLE_TYPES = {
                onset: [ "onsetAge", "onsetRange", "onsetString" ]
            }
            
            embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
            validates_presence_of :fhirType
            embeds_one :outcome, class_name:'FHIR::CodeableConcept'
            embeds_one :onsetAge, class_name:'FHIR::Quantity'
            embeds_one :onsetRange, class_name:'FHIR::Range'
            field :onsetString, type: String
            field :note, type: String
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :patient, class_name:'FHIR::Reference'
        validates_presence_of :patient
        field :date, type: String
        validates :date, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        field :name, type: String
        embeds_one :relationship, class_name:'FHIR::CodeableConcept'
        validates_presence_of :relationship
        field :gender, type: String
        validates :gender, :inclusion => { in: VALID_CODES[:gender], :allow_nil => true }
        embeds_one :bornPeriod, class_name:'FHIR::Period'
        field :bornDate, type: String
        validates :bornDate, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1]))?)?\Z/ }
        field :bornString, type: String
        embeds_one :ageAge, class_name:'FHIR::Quantity'
        embeds_one :ageRange, class_name:'FHIR::Range'
        field :ageString, type: String
        field :deceasedBoolean, type: Boolean
        embeds_one :deceasedAge, class_name:'FHIR::Quantity'
        embeds_one :deceasedRange, class_name:'FHIR::Range'
        field :deceasedDate, type: String
        validates :deceasedDate, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1]))?)?\Z/ }
        field :deceasedString, type: String
        field :note, type: String
        embeds_many :condition, class_name:'FHIR::FamilyMemberHistory::FamilyMemberHistoryConditionComponent'
        track_history
    end
end
