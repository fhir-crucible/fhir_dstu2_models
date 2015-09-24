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
            'identifier',
            'servicecategory',
            'servicetype',
            'organization',
            'name',
            'programname',
            'location',
            'characteristic'
        ]
        
        VALID_CODES = {
            serviceProvisionCode: [ 'free', 'disc', 'cost' ],
            referralMethod: [ 'fax', 'phone', 'elec', 'semail', 'mail' ]
        }
        
        # This is an ugly hack to deal with embedded structures in the spec serviceType
        class ServiceTypeComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ '408467006', '394577000', '394578005', '421661004', '408462000', '394579002', '394804000', '394580004', '394803006', '408480009', '408454008', '394809005', '394592004', '394600006', '394601005', '394581000', '408478003', '394812008', '408444009', '394582007', '408475000', '410005002', '394583002', '419772000', '394584008', '408443003', '394802001', '394915009', '394814009', '394808002', '394811001', '408446006', '394586005', '394916005', '408472002', '394597005', '394598000', '394807007', '419192003', '408468001', '394593009', '394813003', '410001006', '394589003', '394591006', '394599008', '394649004', '408470005', '394585009', '394821009', '422191005', '394594003', '416304004', '418960008', '394882004', '394806003', '394588006', '408459003', '394607009', '419610006', '418058008', '420208008', '418652005', '418535003', '418862001', '419365004', '418002000', '419983000', '419170002', '419472004', '394539006', '420112009', '409968004', '394587001', '394913002', '408440000', '418112009', '419815003', '394914008', '408455009', '394602003', '408447002', '394810000', '408450004', '408476004', '408469009', '408466002', '408471009', '408464004', '408441001', '408465003', '394605001', '394608004', '408461007', '408460008', '408460008', '394606000', '408449004', '394608004', '418018006', '394604002', '394609007', '408474001', '394610002', '394611003', '408477008', '394801008', '408463005', '419321007', '394576009', '394590007', '409967009', '408448007', '419043006', '394612005', '394733009', '394732004' ]
            }
            
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
                daysOfWeek: [ 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun' ]
            }
            
            field :daysOfWeek, type: Array # Array of Strings
            validates :daysOfWeek, :inclusion => { in: VALID_CODES[:daysOfWeek], :allow_nil => true }
            field :allDay, type: Boolean
            field :availableStartTime, type: String
            validates :availableStartTime, :allow_nil => true, :format => {  with: /\A([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?\Z/ }
            field :availableEndTime, type: String
            validates :availableEndTime, :allow_nil => true, :format => {  with: /\A([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?\Z/ }
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
        embeds_one :serviceCategory, class_name:'FHIR::CodeableConcept'
        embeds_many :serviceType, class_name:'FHIR::HealthcareService::ServiceTypeComponent'
        embeds_one :location, class_name:'FHIR::Reference'
        validates_presence_of :location
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
