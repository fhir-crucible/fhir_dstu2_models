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
    class TestScript 
        
        include Mongoid::Document
        include Mongoid::History::Trackable
        include FHIR::Element
        include FHIR::Resource
        include FHIR::Formats::Utilities
        include FHIR::Serializer::Utilities
        extend FHIR::Deserializer::TestScript
        
        SEARCH_PARAMS = [
            'name',
            'description'
            ]
        # This is an ugly hack to deal with embedded structures in the spec fixture
        class TestScriptFixtureComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :uri, type: String
            field :resourceType, type: String
            field :resource, type: FHIR::AnyType
        end
        
        # This is an ugly hack to deal with embedded structures in the spec operation
        class TestScriptSetupOperationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ "read", "vread", "update", "delete", "history", "create", "search", "transaction", "conformance" ]
            }
            
            field :fhirType, type: String
            validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType] }
            validates_presence_of :fhirType
            field :source, type: String
            field :target, type: String
            field :destination, type: Integer
        end
        
        # This is an ugly hack to deal with embedded structures in the spec setup
        class TestScriptSetupComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_many :operation, class_name:'FHIR::TestScript::TestScriptSetupOperationComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec link
        class TestScriptTestMetadataLinkComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :url, type: String
            validates_presence_of :url
            field :description, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec requires
        class TestScriptTestMetadataRequiresComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :fhirType, type: String
            validates_presence_of :fhirType
            field :operations, type: String
            validates_presence_of :operations
            field :destination, type: Integer
        end
        
        # This is an ugly hack to deal with embedded structures in the spec validates
        class TestScriptTestMetadataValidatesComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :fhirType, type: String
            validates_presence_of :fhirType
            field :operations, type: String
            validates_presence_of :operations
            field :destination, type: Integer
        end
        
        # This is an ugly hack to deal with embedded structures in the spec metadata
        class TestScriptTestMetadataComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_many :link, class_name:'FHIR::TestScript::TestScriptTestMetadataLinkComponent'
            embeds_many :requires, class_name:'FHIR::TestScript::TestScriptTestMetadataRequiresComponent'
            embeds_many :validates, class_name:'FHIR::TestScript::TestScriptTestMetadataValidatesComponent'
        end
        
        # This is an ugly hack to deal with embedded structures in the spec operation
        class TestScriptTestOperationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ "read", "vread", "update", "delete", "history", "create", "search", "transaction", "conformance" ]
            }
            
            field :fhirType, type: String
            validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType] }
            validates_presence_of :fhirType
            field :source, type: String
            field :target, type: String
            field :destination, type: Integer
        end
        
        # This is an ugly hack to deal with embedded structures in the spec assertion
        class TestScriptTestAssertionComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :fhirType, type: String
            validates_presence_of :fhirType
            field :args, type: String
        end
        
        # This is an ugly hack to deal with embedded structures in the spec test
        class TestScriptTestComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            field :name, type: String
            field :description, type: String
            embeds_one :metadata, class_name:'FHIR::TestScript::TestScriptTestMetadataComponent'
            embeds_many :operation, class_name:'FHIR::TestScript::TestScriptTestOperationComponent'
            validates_presence_of :operation
            embeds_many :assertion, class_name:'FHIR::TestScript::TestScriptTestAssertionComponent'
            validates_presence_of :assertion
        end
        
        # This is an ugly hack to deal with embedded structures in the spec operation
        class TestScriptTeardownOperationComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            
            VALID_CODES = {
                fhirType: [ "read", "vread", "update", "delete", "history", "create", "search", "transaction", "conformance" ]
            }
            
            field :fhirType, type: String
            validates :fhirType, :inclusion => { in: VALID_CODES[:fhirType] }
            validates_presence_of :fhirType
            field :source, type: String
            field :target, type: String
            field :destination, type: Integer
        end
        
        # This is an ugly hack to deal with embedded structures in the spec teardown
        class TestScriptTeardownComponent
        include Mongoid::Document
        include FHIR::Element
        include FHIR::Formats::Utilities
            embeds_many :operation, class_name:'FHIR::TestScript::TestScriptTeardownOperationComponent'
        end
        
        field :name, type: String
        field :description, type: String
        embeds_many :fixture, class_name:'FHIR::TestScript::TestScriptFixtureComponent'
        embeds_one :setup, class_name:'FHIR::TestScript::TestScriptSetupComponent'
        embeds_many :test, class_name:'FHIR::TestScript::TestScriptTestComponent'
        embeds_one :teardown, class_name:'FHIR::TestScript::TestScriptTeardownComponent'
        track_history
    end
end
