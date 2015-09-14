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
    class Observation 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Observation
        
        SEARCH_PARAMS = [
            'date',
            'code',
            'subject',
            'component-data-absent-reason',
            'value-concept',
            'value-date',
            'related',
            'patient',
            'specimen',
            'component-code',
            'value-string',
            'identifier',
            'component-code-value-[x]',
            'code-value-[x]',
            'performer',
            'value-quantity',
            'component-value-quantity',
            'data-absent-reason',
            'encounter',
            'related-type',
            'related-target',
            'component-value-string',
            'component-value-concept',
            'category',
            'device',
            'status'
        ]
        
        VALID_CODES = {
            category: [ 'social-history', 'vital-signs', 'imaging', 'laboratory', 'procedure', 'survey', 'exam', 'therapy' ],
            status: [ 'registered', 'preliminary', 'final', 'amended', 'cancelled', 'entered-in-error', 'unknown' ]
        }
        
        MULTIPLE_TYPES = {
            effective: [ 'effectiveDateTime', 'effectivePeriod' ],
            value: [ 'valueQuantity', 'valueCodeableConcept', 'valueString', 'valueRange', 'valueRatio', 'valueSampledData', 'valueAttachment', 'valueTime', 'valueDateTime', 'valuePeriod' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec referenceRange
        class ObservationReferenceRangeComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                meaning: [ 'type', 'normal', 'recommended', 'treatment', 'therapeutic', 'pre', 'post', 'endocrine', 'pre-puberty', 'follicular', 'midcycle', 'luteal', 'postmeopausal', '248153007', '248152002', '77386006' ]
            }
            
            embeds_one :low, class_name:'FHIR::Quantity'
            embeds_one :high, class_name:'FHIR::Quantity'
            embeds_one :meaning, class_name:'FHIR::CodeableConcept'
            embeds_one :age, class_name:'FHIR::Range'
            field :text, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec related
        class ObservationRelatedComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ 'has-member', 'derived-from', 'sequel-to', 'replaces', 'qualified-by', 'interfered-by' ]
            }
            
            field :fhirType, type: String
            embeds_one :target, class_name:'FHIR::Reference'
            validates_presence_of :target
        end
        
        # This is an ugly hack to deal with embedded structures in the spec component
        class ObservationComponentComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            MULTIPLE_TYPES = {
                value: [ 'valueQuantity', 'valueCodeableConcept', 'valueString', 'valueRange', 'valueRatio', 'valueSampledData', 'valueAttachment', 'valueTime', 'valueDateTime', 'valuePeriod' ]
            }
            
            embeds_one :code, class_name:'FHIR::CodeableConcept'
            validates_presence_of :code
            embeds_one :valueQuantity, class_name:'FHIR::Quantity'
            embeds_one :valueCodeableConcept, class_name:'FHIR::CodeableConcept'
            field :valueString, type: String
            embeds_one :valueRange, class_name:'FHIR::Range'
            embeds_one :valueRatio, class_name:'FHIR::Ratio'
            embeds_one :valueSampledData, class_name:'FHIR::SampledData'
            embeds_one :valueAttachment, class_name:'FHIR::Attachment'
            field :valueTime, type: String
            validates :valueTime, :allow_nil => true, :format => {  with: /\A([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?\Z/ }
            field :valueDateTime, type: String
            validates :valueDateTime, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
            embeds_one :valuePeriod, class_name:'FHIR::Period'
            embeds_one :dataAbsentReason, class_name:'FHIR::CodeableConcept'
            embeds_many :referenceRange, class_name:'FHIR::Observation::ObservationReferenceRangeComponent'
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        field :status, type: String
        validates_presence_of :status
        embeds_one :category, class_name:'FHIR::CodeableConcept'
        embeds_one :code, class_name:'FHIR::CodeableConcept'
        validates_presence_of :code
        embeds_one :subject, class_name:'FHIR::Reference'
        embeds_one :encounter, class_name:'FHIR::Reference'
        field :effectiveDateTime, type: String
        validates :effectiveDateTime, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        embeds_one :effectivePeriod, class_name:'FHIR::Period'
        field :issued, type: String
        validates :issued, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))))\Z/ }
        embeds_many :performer, class_name:'FHIR::Reference'
        embeds_one :valueQuantity, class_name:'FHIR::Quantity'
        embeds_one :valueCodeableConcept, class_name:'FHIR::CodeableConcept'
        field :valueString, type: String
        embeds_one :valueRange, class_name:'FHIR::Range'
        embeds_one :valueRatio, class_name:'FHIR::Ratio'
        embeds_one :valueSampledData, class_name:'FHIR::SampledData'
        embeds_one :valueAttachment, class_name:'FHIR::Attachment'
        field :valueTime, type: String
        validates :valueTime, :allow_nil => true, :format => {  with: /\A([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?\Z/ }
        field :valueDateTime, type: String
        validates :valueDateTime, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        embeds_one :valuePeriod, class_name:'FHIR::Period'
        embeds_one :dataAbsentReason, class_name:'FHIR::CodeableConcept'
        embeds_one :interpretation, class_name:'FHIR::CodeableConcept'
        field :comments, type: String
        embeds_one :bodySite, class_name:'FHIR::CodeableConcept'
        embeds_one :method, class_name:'FHIR::CodeableConcept'
        embeds_one :specimen, class_name:'FHIR::Reference'
        embeds_one :device, class_name:'FHIR::Reference'
        embeds_many :referenceRange, class_name:'FHIR::Observation::ObservationReferenceRangeComponent'
        embeds_many :related, class_name:'FHIR::Observation::ObservationRelatedComponent'
        embeds_many :component, class_name:'FHIR::Observation::ObservationComponentComponent'
        track_history
    end
end
