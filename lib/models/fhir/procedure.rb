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
    class Procedure 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Procedure
        
        SEARCH_PARAMS = [
            'date',
            'identifier',
            'code',
            'performer',
            'subject',
            'patient',
            'location',
            'encounter'
        ]
        
        VALID_CODES = {
            followUp: [ '18949003', '30549001', '241031001', '35963001', '225164002', '447346005', '229506003', '274441001', '394725008', '359825008' ],
            category: [ '24642003', '409063005', '409073007', '387713003', '103693007', '46947000' ],
            outcome: [ '385669000', '385671000', '385670004' ],
            status: [ 'in-progress', 'aborted', 'completed', 'entered-in-error' ]
        }
        
        MULTIPLE_TYPES = {
            reason: [ 'reasonCodeableConcept', 'reasonReference' ],
            performed: [ 'performedDateTime', 'performedPeriod' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec performer
        class ProcedurePerformerComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :actor, class_name:'FHIR::Reference'
            embeds_one :role, class_name:'FHIR::CodeableConcept'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec focalDevice
        class ProcedureFocalDeviceComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                action: [ 'implanted', 'explanted', 'manipulated' ]
            }
            
            embeds_one :action, class_name:'FHIR::CodeableConcept'
            embeds_one :manipulated, class_name:'FHIR::Reference'
            validates_presence_of :manipulated
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :subject, class_name:'FHIR::Reference'
        validates_presence_of :subject
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        embeds_one :category, class_name:'FHIR::CodeableConcept'
        embeds_one :code, class_name:'FHIR::CodeableConcept'
        validates_presence_of :code
        field :notPerformed, type: Boolean
        embeds_many :reasonNotPerformed, class_name:'FHIR::CodeableConcept'
        embeds_many :bodySite, class_name:'FHIR::CodeableConcept'
        embeds_one :reasonCodeableConcept, class_name:'FHIR::CodeableConcept'
        embeds_one :reasonReference, class_name:'FHIR::Reference'
        embeds_many :performer, class_name:'FHIR::Procedure::ProcedurePerformerComponent'
        field :performedDateTime, type: String
        validates :performedDateTime, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        embeds_one :performedPeriod, class_name:'FHIR::Period'
        embeds_one :encounter, class_name:'FHIR::Reference'
        embeds_one :location, class_name:'FHIR::Reference'
        embeds_one :outcome, class_name:'FHIR::CodeableConcept'
        embeds_many :report, class_name:'FHIR::Reference'
        embeds_many :complication, class_name:'FHIR::CodeableConcept'
        embeds_many :followUp, class_name:'FHIR::CodeableConcept'
        embeds_one :request, class_name:'FHIR::Reference'
        embeds_many :notes, class_name:'FHIR::Annotation'
        embeds_many :focalDevice, class_name:'FHIR::Procedure::ProcedureFocalDeviceComponent'
        embeds_many :used, class_name:'FHIR::Reference'
        track_history
    end
end
