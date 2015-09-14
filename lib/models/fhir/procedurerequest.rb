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
    class ProcedureRequest 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::ProcedureRequest
        
        SEARCH_PARAMS = [
            'identifier',
            'performer',
            'subject',
            'patient',
            'orderer',
            'encounter'
        ]
        
        VALID_CODES = {
            priority: [ 'routine', 'urgent', 'stat', 'asap' ],
            status: [ 'proposed', 'draft', 'requested', 'received', 'accepted', 'in-progress', 'completed', 'suspended', 'rejected', 'aborted' ]
        }
        
        MULTIPLE_TYPES = {
            asNeeded: [ 'asNeededBoolean', 'asNeededCodeableConcept' ],
            reason: [ 'reasonCodeableConcept', 'reasonReference' ],
            scheduled: [ 'scheduledDateTime', 'scheduledPeriod', 'scheduledTiming' ]
        }
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :subject, class_name:'FHIR::Reference'
        validates_presence_of :subject
        embeds_one :code, class_name:'FHIR::CodeableConcept'
        validates_presence_of :code
        embeds_many :bodySite, class_name:'FHIR::CodeableConcept'
        embeds_one :reasonCodeableConcept, class_name:'FHIR::CodeableConcept'
        embeds_one :reasonReference, class_name:'FHIR::Reference'
        field :scheduledDateTime, type: String
        validates :scheduledDateTime, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        embeds_one :scheduledPeriod, class_name:'FHIR::Period'
        embeds_one :scheduledTiming, class_name:'FHIR::Timing'
        embeds_one :encounter, class_name:'FHIR::Reference'
        embeds_one :performer, class_name:'FHIR::Reference'
        field :status, type: String
        embeds_many :notes, class_name:'FHIR::Annotation'
        field :asNeededBoolean, type: Boolean
        embeds_one :asNeededCodeableConcept, class_name:'FHIR::CodeableConcept'
        field :orderedOn, type: String
        validates :orderedOn, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        embeds_one :orderer, class_name:'FHIR::Reference'
        field :priority, type: String
        track_history
    end
end
