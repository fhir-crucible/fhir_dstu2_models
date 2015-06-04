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
    class OperationOutcome 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::OperationOutcome
        
        SEARCH_PARAMS = [
        ]
        # This is an ugly hack to deal with embedded structures in the spec issue
        class OperationOutcomeIssueComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                severity: [ "fatal", "error", "warning", "information" ],
                code: [ "invalid", "structure", "required", "value", "invariant", "security", "login", "unknown", "expired", "forbidden", "suppressed", "processing", "not-supported", "duplicate", "not-found", "too-long", "code-invalid", "extension", "too-costly", "business-rule", "conflict", "incomplete", "transient", "lock-error", "no-store", "exception", "timeout", "throttled", "informational" ]
            }
            
            field :severity, type: String
            validates :severity, :inclusion => { in: VALID_CODES[:severity] }
            validates_presence_of :severity
            embeds_one :code, class_name:'FHIR::CodeableConcept'
            validates_presence_of :code
            field :details, type: String
            field :location, type: Array # Array of Strings
        end
        
        embeds_many :issue, class_name:'FHIR::OperationOutcome::OperationOutcomeIssueComponent'
        validates_presence_of :issue
        track_history
    end
end
