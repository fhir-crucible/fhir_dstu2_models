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
    class Specimen 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Specimen
        
        SEARCH_PARAMS = [
            'container',
            'identifier',
            'parent',
            'subject',
            'patient',
            'site-reference',
            'collected',
            'accession',
            'type',
            'containerid',
            'site-code',
            'collector'
        ]
        # This is an ugly hack to deal with embedded structures in the spec fhirCollection
        class SpecimenCollectionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            MULTIPLE_TYPES = {
                bodySite: [ "bodySiteCodeableConcept", "bodySiteReference" ],
                collected: [ "collectedDateTime", "collectedPeriod" ]
            }
            
            embeds_one :collector, class_name:'FHIR::Reference'
            field :comment, type: Array # Array of Strings
            field :collectedDateTime, type: String
            validates :collectedDateTime, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
            embeds_one :collectedPeriod, class_name:'FHIR::Period'
            embeds_one :quantity, class_name:'FHIR::Quantity'
            embeds_one :method, class_name:'FHIR::CodeableConcept'
            embeds_one :bodySiteCodeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :bodySiteReference, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec treatment
        class SpecimenTreatmentComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :description, type: String
            embeds_one :procedure, class_name:'FHIR::CodeableConcept'
            embeds_many :additive, class_name:'FHIR::Reference'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec container
        class SpecimenContainerComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            MULTIPLE_TYPES = {
                additive: [ "additiveCodeableConcept", "additiveReference" ]
            }
            
            embeds_many :identifier, class_name:'FHIR::Identifier'
            field :description, type: String
            embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
            embeds_one :capacity, class_name:'FHIR::Quantity'
            embeds_one :specimenQuantity, class_name:'FHIR::Quantity'
            embeds_one :additiveCodeableConcept, class_name:'FHIR::CodeableConcept'
            embeds_one :additiveReference, class_name:'FHIR::Reference'
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
        embeds_many :parent, class_name:'FHIR::Reference'
        embeds_one :subject, class_name:'FHIR::Reference'
        validates_presence_of :subject
        embeds_one :accessionIdentifier, class_name:'FHIR::Identifier'
        field :receivedTime, type: String
        validates :receivedTime, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        embeds_one :fhirCollection, class_name:'FHIR::Specimen::SpecimenCollectionComponent'
        embeds_many :treatment, class_name:'FHIR::Specimen::SpecimenTreatmentComponent'
        embeds_many :container, class_name:'FHIR::Specimen::SpecimenContainerComponent'
        track_history
    end
end
