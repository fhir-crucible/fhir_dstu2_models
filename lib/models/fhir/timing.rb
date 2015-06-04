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
    class Timing 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Timing
        
        
        VALID_CODES = {
            code: [ "BID", "TID", "QID", "AM", "PM" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec repeat
        class TimingRepeatComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                periodUnits: [ "s", "min", "h", "d", "wk", "mo", "a" ],
                durationUnits: [ "s", "min", "h", "d", "wk", "mo", "a" ],
                when: [ "HS", "WAKE", "C", "CM", "CD", "CV", "AC", "ACM", "ACD", "ACV", "PC", "PCM", "PCD", "PCV" ]
            }
            
            embeds_one :bounds, class_name:'FHIR::Period'
            field :count, type: Integer
            field :duration, type: Float
            field :durationUnits, type: String
            validates :durationUnits, :inclusion => { in: VALID_CODES[:durationUnits], :allow_nil => true }
            field :frequency, type: Integer
            field :frequencyMax, type: Integer
            field :period, type: Float
            field :periodMax, type: Float
            field :periodUnits, type: String
            validates :periodUnits, :inclusion => { in: VALID_CODES[:periodUnits], :allow_nil => true }
            field :when, type: String
            validates :when, :inclusion => { in: VALID_CODES[:when], :allow_nil => true }
        end
        
        field :event, type: Array # Array of Strings
        validates_each :event, allow_nil: true do |record, attr, values|
            values.each do |value|
                record.errors.add(attr, "#{value} is not a valid datetime.") if value.match(/\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/).nil?
            end
        end
        embeds_one :repeat, class_name:'FHIR::Timing::TimingRepeatComponent'
        embeds_one :code, class_name:'FHIR::CodeableConcept'
        track_history
    end
end
