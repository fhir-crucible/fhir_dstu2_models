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
    class VisionPrescription 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::VisionPrescription
        
        SEARCH_PARAMS = [
            'prescriber',
            'identifier',
            'patient',
            'datewritten',
            'encounter'
            ]
        # This is an ugly hack to deal with embedded structures in the spec dispense
        class VisionPrescriptionDispenseComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                eye: [ "right", "left" ],
                base: [ "up", "down", "in", "out" ]
            }
            
            embeds_one :product, class_name:'FHIR::Coding'
            validates_presence_of :product
            field :eye, type: String
            validates :eye, :inclusion => { in: VALID_CODES[:eye], :allow_nil => true }
            field :sphere, type: Float
            field :cylinder, type: Float
            field :axis, type: Integer
            field :prism, type: Float
            field :base, type: String
            validates :base, :inclusion => { in: VALID_CODES[:base], :allow_nil => true }
            field :add, type: Float
            field :power, type: Float
            field :backCurve, type: Float
            field :diameter, type: Float
            embeds_one :duration, class_name:'FHIR::Quantity'
            field :color, type: String
            field :brand, type: String
            field :notes, type: String
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        field :dateWritten, type: FHIR::PartialDateTime
        embeds_one :patient, class_name:'FHIR::Reference'
        embeds_one :prescriber, class_name:'FHIR::Reference'
        embeds_one :encounter, class_name:'FHIR::Reference'
        embeds_one :reasonCodeableConcept, class_name:'FHIR::CodeableConcept'
        embeds_one :reasonReference, class_name:'FHIR::Reference'
        embeds_many :dispense, class_name:'FHIR::VisionPrescription::VisionPrescriptionDispenseComponent'
        track_history
    end
end
