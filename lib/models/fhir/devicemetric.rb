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
    class DeviceMetric 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::DeviceMetric
        
        SEARCH_PARAMS = [
            'parent',
            'identifier',
            'source',
            'type',
            'category'
        ]
        
        VALID_CODES = {
            operationalStatus: [ "on", "off", "standby" ],
            color: [ "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" ],
            category: [ "measurement", "setting", "calculation", "unspecified" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec calibration
        class DeviceMetricCalibrationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                state: [ "not-calibrated", "calibration-required", "calibrated", "unspecified" ],
                fhirType: [ "unspecified", "offset", "gain", "two-point" ]
            }
            
            field :fhirType, type: String
            validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType], :allow_nil => true }
            field :state, type: String
            validates :state, :inclusion => { in: VALID_CODES[:state], :allow_nil => true }
            field :time, type: String
            validates :time, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))))\Z/ }
        end
        
        embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
        validates_presence_of :fhirType
        embeds_one :identifier, class_name:'FHIR::Identifier'
        validates_presence_of :identifier
        embeds_one :unit, class_name:'FHIR::CodeableConcept'
        embeds_one :source, class_name:'FHIR::Reference'
        embeds_one :parent, class_name:'FHIR::Reference'
        field :operationalStatus, type: String
        validates :operationalStatus, :inclusion => { in: VALID_CODES[:operationalStatus], :allow_nil => true }
        field :color, type: String
        validates :color, :inclusion => { in: VALID_CODES[:color], :allow_nil => true }
        field :category, type: String
        validates :category, :inclusion => { in: VALID_CODES[:category] }
        validates_presence_of :category
        embeds_one :measurementPeriod, class_name:'FHIR::Timing'
        embeds_many :calibration, class_name:'FHIR::DeviceMetric::DeviceMetricCalibrationComponent'
        track_history
    end
end
