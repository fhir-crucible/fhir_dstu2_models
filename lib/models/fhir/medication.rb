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
    class Medication 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::Medication
        
        SEARCH_PARAMS = [
            'container',
            'code',
            'ingredient',
            'form',
            'content',
            'manufacturer'
        ]
        # This is an ugly hack to deal with embedded structures in the spec ingredient
        class MedicationProductIngredientComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :item, class_name:'FHIR::Reference'
            validates_presence_of :item
            embeds_one :amount, class_name:'FHIR::Ratio'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec batch
        class MedicationProductBatchComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :lotNumber, type: String
            field :expirationDate, type: String
            validates :expirationDate, :allow_nil => true, :format => {  with: /\A[0-9]{4}(-(0[1-9]|1[0-2])(-(0[0-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?)?)?)?\Z/ }
        end
        
        # This is an ugly hack to deal with embedded structures in the spec product
        class MedicationProductComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :form, class_name:'FHIR::CodeableConcept'
            embeds_many :ingredient, class_name:'FHIR::Medication::MedicationProductIngredientComponent'
            embeds_many :batch, class_name:'FHIR::Medication::MedicationProductBatchComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec content
        class MedicationPackageContentComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :item, class_name:'FHIR::Reference'
            validates_presence_of :item
            embeds_one :amount, class_name:'FHIR::Quantity'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec package
        class MedicationPackageComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_one :container, class_name:'FHIR::CodeableConcept'
            embeds_many :content, class_name:'FHIR::Medication::MedicationPackageContentComponent'
        end
        
        embeds_one :code, class_name:'FHIR::CodeableConcept'
        field :isBrand, type: Boolean
        embeds_one :manufacturer, class_name:'FHIR::Reference'
        embeds_one :product, class_name:'FHIR::Medication::MedicationProductComponent'
        embeds_one :package, class_name:'FHIR::Medication::MedicationPackageComponent'
        track_history
    end
end
