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
                severity: [ 'fatal', 'error', 'warning', 'information' ],
                code: [ 'invalid', 'structure', 'required', 'value', 'invariant', 'security', 'login', 'unknown', 'expired', 'forbidden', 'suppressed', 'processing', 'not-supported', 'duplicate', 'not-found', 'too-long', 'code-invalid', 'extension', 'too-costly', 'business-rule', 'conflict', 'incomplete', 'transient', 'lock-error', 'no-store', 'exception', 'timeout', 'throttled', 'informational' ],
                details: [ 'MSG_AUTH_REQUIRED', 'MSG_BAD_FORMAT', 'MSG_BAD_SYNTAX', 'MSG_CANT_PARSE_CONTENT', 'MSG_CANT_PARSE_ROOT', 'MSG_CREATED', 'MSG_DATE_FORMAT', 'MSG_DELETED', 'MSG_DELETED_DONE', 'MSG_DELETED_ID', 'MSG_DUPLICATE_ID', 'MSG_ERROR_PARSING', 'MSG_ID_INVALID', 'MSG_ID_TOO_LONG', 'MSG_INVALID_ID', 'MSG_JSON_OBJECT', 'MSG_LOCAL_FAIL', 'MSG_NO_MATCH', 'MSG_NO_EXIST', 'MSG_NO_MODULE', 'MSG_NO_SUMMARY', 'MSG_OP_NOT_ALLOWED', 'MSG_PARAM_CHAINED', 'MSG_PARAM_NO_REPEAT', 'MSG_PARAM_UNKNOWN', 'MSG_RESOURCE_EXAMPLE_PROTECTED', 'MSG_RESOURCE_ID_FAIL', 'MSG_RESOURCE_NOT_ALLOWED', 'MSG_RESOURCE_REQUIRED', 'MSG_RESOURCE_ID_MISMATCH', 'MSG_RESOURCE_ID_MISSING', 'MSG_RESOURCE_TYPE_MISMATCH', 'MSG_SORT_UNKNOWN', 'MSG_TRANSACTION_DUPLICATE_ID', 'MSG_TRANSACTION_MISSING_ID', 'MSG_UNHANDLED_NODE_TYPE', 'MSG_UNKNOWN_CONTENT', 'MSG_UNKNOWN_OPERATION', 'MSG_UNKNOWN_TYPE', 'MSG_UPDATED', 'MSG_VERSION_AWARE', 'MSG_VERSION_AWARE_CONFLICT', 'MSG_VERSION_AWARE_URL', 'MSG_WRONG_NS', 'SEARCH_MULTIPLE', 'UPDATE_MULTIPLE_MATCHES', 'SEARCH_NONE' ]
            }
            
            field :severity, type: String
            validates_presence_of :severity
            field :code, type: String
            validates_presence_of :code
            embeds_one :details, class_name:'FHIR::CodeableConcept'
            field :diagnostics, type: String
            field :location, type: Array # Array of Strings
        end
        
        embeds_many :issue, class_name:'FHIR::OperationOutcome::OperationOutcomeIssueComponent'
        validates_presence_of :issue
        track_history
    end
end
