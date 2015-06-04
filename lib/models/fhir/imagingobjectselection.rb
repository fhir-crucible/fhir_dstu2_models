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
    class ImagingObjectSelection 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::ImagingObjectSelection
        
        SEARCH_PARAMS = [
            'identifier',
            'authoring-time',
            'selected-study',
            'author',
            'patient',
            'title'
        ]
        
        VALID_CODES = {
            title: [ "113000", "113001", "113002", "113003", "113004", "113005", "113006", "113007", "113008", "113009", "113010", "113013", "113018", "113020", "113021", "113030", "113031", "113032", "113033", "113034", "113035", "113036", "113037", "113038", "113039" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec frames
        class FramesComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :frameNumbers, type: Array # Array of Integers
            validates_presence_of :frameNumbers
            field :url, type: String
            validates_presence_of :url
        end
        
        # This is an ugly hack to deal with embedded structures in the spec instance
        class InstanceComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :sopClass, type: String
            validates_presence_of :sopClass
            field :uid, type: String
            validates_presence_of :uid
            field :url, type: String
            validates_presence_of :url
            embeds_many :frames, class_name:'FHIR::ImagingObjectSelection::FramesComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec series
        class SeriesComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :uid, type: String
            field :url, type: String
            embeds_many :instance, class_name:'FHIR::ImagingObjectSelection::InstanceComponent'
            validates_presence_of :instance
        end
        
        # This is an ugly hack to deal with embedded structures in the spec study
        class StudyComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :uid, type: String
            validates_presence_of :uid
            field :url, type: String
            embeds_many :series, class_name:'FHIR::ImagingObjectSelection::SeriesComponent'
            validates_presence_of :series
        end
        
        field :uid, type: String
        validates_presence_of :uid
        embeds_one :patient, class_name:'FHIR::Reference'
        validates_presence_of :patient
        embeds_one :title, class_name:'FHIR::CodeableConcept'
        validates_presence_of :title
        field :description, type: String
        embeds_one :author, class_name:'FHIR::Reference'
        field :authoringTime, type: String
        validates :authoringTime, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        embeds_many :study, class_name:'FHIR::ImagingObjectSelection::StudyComponent'
        validates_presence_of :study
        track_history
    end
end
