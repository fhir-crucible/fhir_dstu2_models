module FHIR
  module DSTU2
    class ImplementationGuide < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['context', 'date', 'dependency', 'description', 'experimental', 'name', 'publisher', 'status', 'url', 'version']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'ImplementationGuide.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'ImplementationGuide.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'ImplementationGuide.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'ImplementationGuide.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'ImplementationGuide.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'ImplementationGuide.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'ImplementationGuide.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'ImplementationGuide.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'url' => {'type'=>'uri', 'path'=>'ImplementationGuide.url', 'min'=>1, 'max'=>1},
        'version' => {'type'=>'string', 'path'=>'ImplementationGuide.version', 'min'=>0, 'max'=>1},
        'name' => {'type'=>'string', 'path'=>'ImplementationGuide.name', 'min'=>1, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/conformance-resource-status'=>['draft', 'active', 'retired']}, 'type'=>'code', 'path'=>'ImplementationGuide.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/conformance-resource-status'}},
        'experimental' => {'type'=>'boolean', 'path'=>'ImplementationGuide.experimental', 'min'=>0, 'max'=>1},
        'publisher' => {'type'=>'string', 'path'=>'ImplementationGuide.publisher', 'min'=>0, 'max'=>1},
        'contact' => {'type'=>'ImplementationGuide::Contact', 'path'=>'ImplementationGuide.contact', 'min'=>0, 'max'=>Float::INFINITY},
        'date' => {'type'=>'dateTime', 'path'=>'ImplementationGuide.date', 'min'=>0, 'max'=>1},
        'description' => {'type'=>'string', 'path'=>'ImplementationGuide.description', 'min'=>0, 'max'=>1},
        'useContext' => {'valid_codes'=>{'urn:iso:std:iso:3166'=>[], 'http://unstats.un.org/unsd/methods/m49/m49.htm'=>[], 'https://www.usps.com/'=>['AK', 'AL', 'AR', 'AS', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'FM', 'GA', 'GU', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MH', 'MI', 'MN', 'MO', 'MP', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'PR', 'PW', 'RI', 'SC', 'SD', 'TN', 'TX', 'UM', 'UT', 'VA', 'VI', 'VT', 'WA', 'WI', 'WV', 'WY'], 'http://hl7.org/fhir/practitioner-specialty'=>['cardio', 'dent', 'dietary', 'midw', 'sysarch']}, 'type'=>'CodeableConcept', 'path'=>'ImplementationGuide.useContext', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/use-context'}},
        'copyright' => {'type'=>'string', 'path'=>'ImplementationGuide.copyright', 'min'=>0, 'max'=>1},
        'fhirVersion' => {'type'=>'id', 'path'=>'ImplementationGuide.fhirVersion', 'min'=>0, 'max'=>1},
        'dependency' => {'type'=>'ImplementationGuide::Dependency', 'path'=>'ImplementationGuide.dependency', 'min'=>0, 'max'=>Float::INFINITY},
        'package' => {'type'=>'ImplementationGuide::Package', 'path'=>'ImplementationGuide.package', 'min'=>1, 'max'=>Float::INFINITY},
        'global' => {'type'=>'ImplementationGuide::Global', 'path'=>'ImplementationGuide.global', 'min'=>0, 'max'=>Float::INFINITY},
        'binary' => {'type'=>'uri', 'path'=>'ImplementationGuide.binary', 'min'=>0, 'max'=>Float::INFINITY},
        'page' => {'type'=>'ImplementationGuide::Page', 'path'=>'ImplementationGuide.page', 'min'=>1, 'max'=>1}
      }

      class Contact < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Contact.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Contact.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Contact.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'name' => {'type'=>'string', 'path'=>'Contact.name', 'min'=>0, 'max'=>1},
          'telecom' => {'type'=>'ContactPoint', 'path'=>'Contact.telecom', 'min'=>0, 'max'=>Float::INFINITY}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :name              # 0-1 string
        attr_accessor :telecom           # 0-* [ ContactPoint ]
      end

      class Dependency < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Dependency.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Dependency.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Dependency.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'type' => {'valid_codes'=>{'http://hl7.org/fhir/guide-dependency-type'=>['reference', 'inclusion']}, 'type'=>'code', 'path'=>'Dependency.type', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/guide-dependency-type'}},
          'uri' => {'type'=>'uri', 'path'=>'Dependency.uri', 'min'=>1, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :type              # 1-1 code
        attr_accessor :uri               # 1-1 uri
      end

      class Package < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Package.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Package.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Package.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'name' => {'type'=>'string', 'path'=>'Package.name', 'min'=>1, 'max'=>1},
          'description' => {'type'=>'string', 'path'=>'Package.description', 'min'=>0, 'max'=>1},
          'resource' => {'type'=>'ImplementationGuide::Package::Resource', 'path'=>'Package.resource', 'min'=>1, 'max'=>Float::INFINITY}
        }

        class Resource < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          MULTIPLE_TYPES = {
            'source' => ['uri', 'Reference']
          }
          METADATA = {
            'id' => {'type'=>'id', 'path'=>'Resource.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Resource.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Resource.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'purpose' => {'valid_codes'=>{'http://hl7.org/fhir/guide-resource-purpose'=>['example', 'terminology', 'profile', 'extension', 'dictionary', 'logical']}, 'type'=>'code', 'path'=>'Resource.purpose', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/guide-resource-purpose'}},
            'name' => {'type'=>'string', 'path'=>'Resource.name', 'min'=>0, 'max'=>1},
            'description' => {'type'=>'string', 'path'=>'Resource.description', 'min'=>0, 'max'=>1},
            'acronym' => {'type'=>'string', 'path'=>'Resource.acronym', 'min'=>0, 'max'=>1},
            'sourceUri' => {'type'=>'uri', 'path'=>'Resource.source[x]', 'min'=>1, 'max'=>1},
            'sourceReference' => {'type'=>'Reference', 'path'=>'Resource.source[x]', 'min'=>1, 'max'=>1},
            'exampleFor' => {'type'=>'Reference', 'path'=>'Resource.exampleFor', 'min'=>0, 'max'=>1}
          }

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :purpose           # 1-1 code
          attr_accessor :name              # 0-1 string
          attr_accessor :description       # 0-1 string
          attr_accessor :acronym           # 0-1 string
          attr_accessor :sourceUri         # 1-1 uri
          attr_accessor :sourceReference   # 1-1 Reference()
          attr_accessor :exampleFor        # 0-1 Reference()
        end

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :name              # 1-1 string
        attr_accessor :description       # 0-1 string
        attr_accessor :resource          # 1-* [ ImplementationGuide::Package::Resource ]
      end

      class Global < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Global.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Global.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Global.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'type' => {'valid_codes'=>{'http://hl7.org/fhir/resource-types'=>['Account', 'AllergyIntolerance', 'Appointment', 'AppointmentResponse', 'AuditEvent', 'Basic', 'Binary', 'BodySite', 'Bundle', 'CarePlan', 'Claim', 'ClaimResponse', 'ClinicalImpression', 'Communication', 'CommunicationRequest', 'Composition', 'ConceptMap', 'Condition', 'Conformance', 'Contract', 'Coverage', 'DataElement', 'DetectedIssue', 'Device', 'DeviceComponent', 'DeviceMetric', 'DeviceUseRequest', 'DeviceUseStatement', 'DiagnosticOrder', 'DiagnosticReport', 'DocumentManifest', 'DocumentReference', 'DomainResource', 'EligibilityRequest', 'EligibilityResponse', 'Encounter', 'EnrollmentRequest', 'EnrollmentResponse', 'EpisodeOfCare', 'ExplanationOfBenefit', 'FamilyMemberHistory', 'Flag', 'Goal', 'Group', 'HealthcareService', 'ImagingObjectSelection', 'ImagingStudy', 'Immunization', 'ImmunizationRecommendation', 'ImplementationGuide', 'List', 'Location', 'Media', 'Medication', 'MedicationAdministration', 'MedicationDispense', 'MedicationOrder', 'MedicationStatement', 'MessageHeader', 'NamingSystem', 'NutritionOrder', 'Observation', 'OperationDefinition', 'OperationOutcome', 'Order', 'OrderResponse', 'Organization', 'Parameters', 'Patient', 'PaymentNotice', 'PaymentReconciliation', 'Person', 'Practitioner', 'Procedure', 'ProcedureRequest', 'ProcessRequest', 'ProcessResponse', 'Provenance', 'Questionnaire', 'QuestionnaireResponse', 'ReferralRequest', 'RelatedPerson', 'Resource', 'RiskAssessment', 'Schedule', 'SearchParameter', 'Slot', 'Specimen', 'StructureDefinition', 'Subscription', 'Substance', 'SupplyDelivery', 'SupplyRequest', 'TestScript', 'ValueSet', 'VisionPrescription']}, 'type'=>'code', 'path'=>'Global.type', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/resource-types'}},
          'profile' => {'type'=>'Reference', 'path'=>'Global.profile', 'min'=>1, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :type              # 1-1 code
        attr_accessor :profile           # 1-1 Reference()
      end

      class Page < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Page.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Page.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Page.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'source' => {'type'=>'uri', 'path'=>'Page.source', 'min'=>1, 'max'=>1},
          'name' => {'type'=>'string', 'path'=>'Page.name', 'min'=>1, 'max'=>1},
          'kind' => {'valid_codes'=>{'http://hl7.org/fhir/guide-page-kind'=>['page', 'example', 'list', 'include', 'directory', 'dictionary', 'toc', 'resource']}, 'type'=>'code', 'path'=>'Page.kind', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/guide-page-kind'}},
          'type' => {'valid_codes'=>{'http://hl7.org/fhir/resource-types'=>['Account', 'AllergyIntolerance', 'Appointment', 'AppointmentResponse', 'AuditEvent', 'Basic', 'Binary', 'BodySite', 'Bundle', 'CarePlan', 'Claim', 'ClaimResponse', 'ClinicalImpression', 'Communication', 'CommunicationRequest', 'Composition', 'ConceptMap', 'Condition', 'Conformance', 'Contract', 'Coverage', 'DataElement', 'DetectedIssue', 'Device', 'DeviceComponent', 'DeviceMetric', 'DeviceUseRequest', 'DeviceUseStatement', 'DiagnosticOrder', 'DiagnosticReport', 'DocumentManifest', 'DocumentReference', 'DomainResource', 'EligibilityRequest', 'EligibilityResponse', 'Encounter', 'EnrollmentRequest', 'EnrollmentResponse', 'EpisodeOfCare', 'ExplanationOfBenefit', 'FamilyMemberHistory', 'Flag', 'Goal', 'Group', 'HealthcareService', 'ImagingObjectSelection', 'ImagingStudy', 'Immunization', 'ImmunizationRecommendation', 'ImplementationGuide', 'List', 'Location', 'Media', 'Medication', 'MedicationAdministration', 'MedicationDispense', 'MedicationOrder', 'MedicationStatement', 'MessageHeader', 'NamingSystem', 'NutritionOrder', 'Observation', 'OperationDefinition', 'OperationOutcome', 'Order', 'OrderResponse', 'Organization', 'Parameters', 'Patient', 'PaymentNotice', 'PaymentReconciliation', 'Person', 'Practitioner', 'Procedure', 'ProcedureRequest', 'ProcessRequest', 'ProcessResponse', 'Provenance', 'Questionnaire', 'QuestionnaireResponse', 'ReferralRequest', 'RelatedPerson', 'Resource', 'RiskAssessment', 'Schedule', 'SearchParameter', 'Slot', 'Specimen', 'StructureDefinition', 'Subscription', 'Substance', 'SupplyDelivery', 'SupplyRequest', 'TestScript', 'ValueSet', 'VisionPrescription']}, 'type'=>'code', 'path'=>'Page.type', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/resource-types'}},
          'package' => {'type'=>'string', 'path'=>'Page.package', 'min'=>0, 'max'=>Float::INFINITY},
          'format' => {'type'=>'code', 'path'=>'Page.format', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://www.rfc-editor.org/bcp/bcp13.txt'}},
          'page' => {'type'=>'ImplementationGuide::Page', 'path'=>'Page.page', 'min'=>0, 'max'=>Float::INFINITY}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :source            # 1-1 uri
        attr_accessor :name              # 1-1 string
        attr_accessor :kind              # 1-1 code
        attr_accessor :type              # 0-* [ code ]
        attr_accessor :package           # 0-* [ string ]
        attr_accessor :format            # 0-1 code
        attr_accessor :page              # 0-* [ ImplementationGuide::Page ]
      end

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :url               # 1-1 uri
      attr_accessor :version           # 0-1 string
      attr_accessor :name              # 1-1 string
      attr_accessor :status            # 1-1 code
      attr_accessor :experimental      # 0-1 boolean
      attr_accessor :publisher         # 0-1 string
      attr_accessor :contact           # 0-* [ ImplementationGuide::Contact ]
      attr_accessor :date              # 0-1 dateTime
      attr_accessor :description       # 0-1 string
      attr_accessor :useContext        # 0-* [ CodeableConcept ]
      attr_accessor :copyright         # 0-1 string
      attr_accessor :fhirVersion       # 0-1 id
      attr_accessor :dependency        # 0-* [ ImplementationGuide::Dependency ]
      attr_accessor :package           # 1-* [ ImplementationGuide::Package ]
      attr_accessor :global            # 0-* [ ImplementationGuide::Global ]
      attr_accessor :binary            # 0-* [ uri ]
      attr_accessor :page              # 1-1 ImplementationGuide::Page

      def resourceType
        'ImplementationGuide'
      end
    end
  end
end
