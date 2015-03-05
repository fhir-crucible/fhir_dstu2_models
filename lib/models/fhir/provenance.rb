# Copyright (c) 2011-2014, HL7, Inc & The MITRE Corporation
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
    class Provenance 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Provenance
        
        SEARCH_PARAMS = [
            'patient',
            'start',
            'end',
            'location',
            'partytype',
            'party',
            'target'
            ]
        # This is an ugly hack to deal with embedded structures in the spec agent
        class ProvenanceAgentComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :role, class_name:'FHIR::Coding'
            validates_presence_of :role
            embeds_one :fhirType, class_name:'FHIR::Coding'
            validates_presence_of :fhirType
            field :reference, type: String
            validates_presence_of :reference
            field :display, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec entity
        class ProvenanceEntityComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                role: [ "derivation", "revision", "quotation", "source" ]
            }
            
            field :role, type: String
            validates :role, :inclusion => { in: VALID_CODES[:role] }
            validates_presence_of :role
            embeds_one :fhirType, class_name:'FHIR::Coding'
            validates_presence_of :fhirType
            field :reference, type: String
            validates_presence_of :reference
            field :display, type: String
            embeds_one :agent, class_name:'FHIR::Provenance::ProvenanceAgentComponent'
        end
        
        embeds_many :target, class_name:'FHIR::Reference'
        validates_presence_of :target
        embeds_one :period, class_name:'FHIR::Period'
        field :recorded, type: DateTime
        validates_presence_of :recorded
        embeds_one :reason, class_name:'FHIR::CodeableConcept'
        embeds_one :location, class_name:'FHIR::Reference'
        field :policy, type: Array # Array of Strings
        embeds_many :agent, class_name:'FHIR::Provenance::ProvenanceAgentComponent'
        embeds_many :entity, class_name:'FHIR::Provenance::ProvenanceEntityComponent'
        field :integritySignature, type: String
        track_history
    end
end
