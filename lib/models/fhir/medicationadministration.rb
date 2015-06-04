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
    class MedicationAdministration 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::MedicationAdministration
        
        SEARCH_PARAMS = [
            'identifier',
            'prescription',
            'effectivetime',
            'practitioner',
            'patient',
            'medication',
            'encounter',
            'device',
            'notgiven',
            'status'
        ]
        
        VALID_CODES = {
            status: [ "in-progress", "on-hold", "completed", "entered-in-error", "stopped" ]
        }
        
        MULTIPLE_TYPES = {
            effectiveTime: [ "effectiveTimeDateTime", "effectiveTimePeriod" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec dosage
        class MedicationAdministrationDosageComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :text, type: String
            embeds_one :site, class_name:'FHIR::CodeableConcept'
            embeds_one :route, class_name:'FHIR::CodeableConcept'
            embeds_one :method, class_name:'FHIR::CodeableConcept'
            embeds_one :quantity, class_name:'FHIR::Quantity'
            embeds_one :rate, class_name:'FHIR::Ratio'
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        embeds_one :patient, class_name:'FHIR::Reference'
        validates_presence_of :patient
        embeds_one :practitioner, class_name:'FHIR::Reference'
        embeds_one :encounter, class_name:'FHIR::Reference'
        embeds_one :prescription, class_name:'FHIR::Reference'
        field :wasNotGiven, type: Boolean
        embeds_many :reasonNotGiven, class_name:'FHIR::CodeableConcept'
        embeds_many :reasonGiven, class_name:'FHIR::CodeableConcept'
        field :effectiveTimeDateTime, type: String
        validates :effectiveTimeDateTime, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        validates_presence_of :effectiveTimeDateTime
        embeds_one :effectiveTimePeriod, class_name:'FHIR::Period'
        validates_presence_of :effectiveTimePeriod
        embeds_one :medication, class_name:'FHIR::Reference'
        embeds_many :device, class_name:'FHIR::Reference'
        field :note, type: String
        embeds_one :dosage, class_name:'FHIR::MedicationAdministration::MedicationAdministrationDosageComponent'
        track_history
    end
end
