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
    class AllergyIntolerance 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::AllergyIntolerance
        
        SEARCH_PARAMS = [
            'severity',
            'date',
            'identifier',
            'manifestation',
            'recorder',
            'substance',
            'criticality',
            'reporter',
            'type',
            'onset',
            'route',
            'patient',
            'category',
            'last-date',
            'status'
        ]
        
        VALID_CODES = {
            substance: [ '160244002', '429625007', '409137002', '428607008' ],
            criticality: [ 'CRITL', 'CRITH', 'CRITU' ],
            category: [ 'food', 'medication', 'environment', 'other' ],
            fhirType: [ 'allergy', 'intolerance' ],
            status: [ 'active', 'unconfirmed', 'confirmed', 'inactive', 'resolved', 'refuted', 'entered-in-error' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec reaction
        class AllergyIntoleranceReactionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                severity: [ 'mild', 'moderate', 'severe' ],
                certainty: [ 'unlikely', 'likely', 'confirmed' ]
            }
            
            embeds_one :substance, class_name:'FHIR::CodeableConcept'
            field :certainty, type: String
            validates :certainty, :inclusion => { in: VALID_CODES[:certainty], :allow_nil => true }
            embeds_many :manifestation, class_name:'FHIR::CodeableConcept'
            validates_presence_of :manifestation
            field :description, type: String
            field :onset, type: String
            validates :onset, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
            field :severity, type: String
            validates :severity, :inclusion => { in: VALID_CODES[:severity], :allow_nil => true }
            embeds_one :exposureRoute, class_name:'FHIR::CodeableConcept'
            embeds_one :note, class_name:'FHIR::Annotation'
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        field :onset, type: String
        validates :onset, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        field :recordedDate, type: String
        validates :recordedDate, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        embeds_one :recorder, class_name:'FHIR::Reference'
        embeds_one :patient, class_name:'FHIR::Reference'
        validates_presence_of :patient
        embeds_one :reporter, class_name:'FHIR::Reference'
        embeds_one :substance, class_name:'FHIR::CodeableConcept'
        validates_presence_of :substance
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status], :allow_nil => true }
        field :criticality, type: String
        validates :criticality, :inclusion => { in: VALID_CODES[:criticality], :allow_nil => true }
        field :fhirType, type: String
        validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType], :allow_nil => true }
        field :category, type: String
        validates :category, :inclusion => { in: VALID_CODES[:category], :allow_nil => true }
        field :lastOccurence, type: String
        validates :lastOccurence, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        embeds_one :note, class_name:'FHIR::Annotation'
        embeds_many :reaction, class_name:'FHIR::AllergyIntolerance::AllergyIntoleranceReactionComponent'
        track_history
    end
end
