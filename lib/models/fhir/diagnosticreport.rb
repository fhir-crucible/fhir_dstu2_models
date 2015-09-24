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
    class DiagnosticReport 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::DiagnosticReport
        
        SEARCH_PARAMS = [
            'date',
            'identifier',
            'image',
            'request',
            'performer',
            'code',
            'subject',
            'diagnosis',
            'encounter',
            'result',
            'patient',
            'specimen',
            'issued',
            'category',
            'status'
        ]
        
        VALID_CODES = {
            category: [ 'AU', 'BG', 'BLB', 'CG', 'CH', 'CP', 'CT', 'CTH', 'CUS', 'EC', 'EN', 'GE', 'HM', 'ICU', 'IMG', 'IMM', 'LAB', 'MB', 'MCB', 'MYC', 'NMR', 'NMS', 'NRS', 'OSL', 'OT', 'OTH', 'OUS', 'PAR', 'PAT', 'PF', 'PHR', 'PHY', 'PT', 'RAD', 'RC', 'RT', 'RUS', 'RX', 'SP', 'SR', 'TX', 'URN', 'VR', 'VUS', 'XRC' ],
            status: [ 'registered', 'partial', 'final', 'corrected', 'appended', 'cancelled', 'entered-in-error' ]
        }
        
        MULTIPLE_TYPES = {
            effective: [ 'effectiveDateTime', 'effectivePeriod' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec image
        class DiagnosticReportImageComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :comment, type: String
            embeds_one :link, class_name:'FHIR::Reference'
            validates_presence_of :link
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        embeds_one :category, class_name:'FHIR::CodeableConcept'
        embeds_one :code, class_name:'FHIR::CodeableConcept'
        validates_presence_of :code
        embeds_one :subject, class_name:'FHIR::Reference'
        validates_presence_of :subject
        embeds_one :encounter, class_name:'FHIR::Reference'
        field :effectiveDateTime, type: String
        validates :effectiveDateTime, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        validates_presence_of :effectiveDateTime
        embeds_one :effectivePeriod, class_name:'FHIR::Period'
        validates_presence_of :effectivePeriod
        field :issued, type: String
        validates :issued, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))))\Z/ }
        validates_presence_of :issued
        embeds_one :performer, class_name:'FHIR::Reference'
        validates_presence_of :performer
        embeds_many :request, class_name:'FHIR::Reference'
        embeds_many :specimen, class_name:'FHIR::Reference'
        embeds_many :result, class_name:'FHIR::Reference'
        embeds_many :imagingStudy, class_name:'FHIR::Reference'
        embeds_many :image, class_name:'FHIR::DiagnosticReport::DiagnosticReportImageComponent'
        field :conclusion, type: String
        embeds_many :codedDiagnosis, class_name:'FHIR::CodeableConcept'
        embeds_many :presentedForm, class_name:'FHIR::Attachment'
        track_history
    end
end
