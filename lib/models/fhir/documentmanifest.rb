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
    class DocumentManifest 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::DocumentManifest
        
        SEARCH_PARAMS = [
            'identifier',
            'subject',
            'author',
            'created',
            'relatedref',
            'description',
            'source',
            'type',
            'relatedid',
            'patient',
            'recipient',
            'status',
            'contentref'
            ]
        
        VALID_CODES = {
            status: [ "current", "superceded", "entered-in-error" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec content
        class DocumentManifestContentComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :pAttachment, class_name:'FHIR::Attachment'
            validates_presence_of :pAttachment
            embeds_one :pReference, class_name:'FHIR::Reference'
            validates_presence_of :pReference
        end
        
        # This is an ugly hack to deal with embedded structures in the spec related
        class DocumentManifestRelatedComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :identifier, class_name:'FHIR::Identifier'
            embeds_one :ref, class_name:'FHIR::Reference'
        end
        
        embeds_one :masterIdentifier, class_name:'FHIR::Identifier'
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :subject, class_name:'FHIR::Reference'
        embeds_many :recipient, class_name:'FHIR::Reference'
        embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
        embeds_many :author, class_name:'FHIR::Reference'
        field :created, type: FHIR::PartialDateTime
        field :source, type: String
        field :status, type: String
        validates :status, :inclusion => { in: VALID_CODES[:status] }
        validates_presence_of :status
        field :description, type: String
        embeds_many :content, class_name:'FHIR::DocumentManifest::DocumentManifestContentComponent'
        validates_presence_of :content
        embeds_many :related, class_name:'FHIR::DocumentManifest::DocumentManifestRelatedComponent'
        track_history
    end
end
