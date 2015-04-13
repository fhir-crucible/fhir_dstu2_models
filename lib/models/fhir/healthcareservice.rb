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
    class HealthcareService 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::HealthcareService
        
        SEARCH_PARAMS = [
            'servicecategory',
            'servicetype',
            'organization',
            'name',
            'programname',
            'location',
            'characteristic'
            ]
        
        VALID_CODES = {
            serviceProvisionCode: [ "free", "disc", "cost" ],
            referralMethod: [ "fax", "phone", "elec", "semail", "mail" ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec serviceType
        class ServiceTypeComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :fhirType, class_name:'FHIR::CodeableConcept'
            validates_presence_of :fhirType
            embeds_many :specialty, class_name:'FHIR::CodeableConcept'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec availableTime
        class HealthcareServiceAvailableTimeComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                daysOfWeek: [ "mon", "tue", "wed", "thu", "fri", "sat", "sun" ]
            }
            
            field :daysOfWeek, type: Array # Array of Strings
            validates :daysOfWeek, :inclusion => { in: VALID_CODES[:daysOfWeek], :allow_nil => true }
            field :allDay, type: Boolean
            field :availableStartTime, type: FHIR::PartialDateTime
            field :availableEndTime, type: FHIR::PartialDateTime
        end
        
        # This is an ugly hack to deal with embedded structures in the spec notAvailable
        class HealthcareServiceNotAvailableComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :description, type: String
            validates_presence_of :description
            embeds_one :during, class_name:'FHIR::Period'
        end
        
        embeds_many :identifier, class_name:'FHIR::Identifier'
        embeds_one :providedBy, class_name:'FHIR::Reference'
        embeds_one :location, class_name:'FHIR::Reference'
        validates_presence_of :location
        embeds_one :serviceCategory, class_name:'FHIR::CodeableConcept'
        embeds_many :serviceType, class_name:'FHIR::HealthcareService::ServiceTypeComponent'
        field :serviceName, type: String
        field :comment, type: String
        field :extraDetails, type: String
        embeds_one :photo, class_name:'FHIR::Attachment'
        embeds_many :telecom, class_name:'FHIR::ContactPoint'
        embeds_many :coverageArea, class_name:'FHIR::Reference'
        embeds_many :serviceProvisionCode, class_name:'FHIR::CodeableConcept'
        embeds_one :eligibility, class_name:'FHIR::CodeableConcept'
        field :eligibilityNote, type: String
        field :programName, type: Array # Array of Strings
        embeds_many :characteristic, class_name:'FHIR::CodeableConcept'
        embeds_many :referralMethod, class_name:'FHIR::CodeableConcept'
        field :publicKey, type: String
        field :appointmentRequired, type: Boolean
        embeds_many :availableTime, class_name:'FHIR::HealthcareService::HealthcareServiceAvailableTimeComponent'
        embeds_many :notAvailable, class_name:'FHIR::HealthcareService::HealthcareServiceNotAvailableComponent'
        field :availabilityExceptions, type: String
        track_history
    end
end
