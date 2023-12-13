module FHIR
  module DSTU2
    class StructureDefinition < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['abstract', 'base', 'base-path', 'code', 'context', 'context-type', 'date', 'description', 'display', 'experimental', 'ext-context', 'identifier', 'kind', 'name', 'path', 'publisher', 'status', 'type', 'url', 'valueset', 'version']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'StructureDefinition.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'StructureDefinition.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'StructureDefinition.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'StructureDefinition.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'StructureDefinition.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'StructureDefinition.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'StructureDefinition.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'StructureDefinition.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'url' => {'type'=>'uri', 'path'=>'StructureDefinition.url', 'min'=>1, 'max'=>1},
        'identifier' => {'type'=>'Identifier', 'path'=>'StructureDefinition.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'version' => {'type'=>'string', 'path'=>'StructureDefinition.version', 'min'=>0, 'max'=>1},
        'name' => {'type'=>'string', 'path'=>'StructureDefinition.name', 'min'=>1, 'max'=>1},
        'display' => {'type'=>'string', 'path'=>'StructureDefinition.display', 'min'=>0, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/conformance-resource-status'=>['draft', 'active', 'retired']}, 'type'=>'code', 'path'=>'StructureDefinition.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/conformance-resource-status'}},
        'experimental' => {'type'=>'boolean', 'path'=>'StructureDefinition.experimental', 'min'=>0, 'max'=>1},
        'publisher' => {'type'=>'string', 'path'=>'StructureDefinition.publisher', 'min'=>0, 'max'=>1},
        'contact' => {'type'=>'StructureDefinition::Contact', 'path'=>'StructureDefinition.contact', 'min'=>0, 'max'=>Float::INFINITY},
        'date' => {'type'=>'dateTime', 'path'=>'StructureDefinition.date', 'min'=>0, 'max'=>1},
        'description' => {'type'=>'string', 'path'=>'StructureDefinition.description', 'min'=>0, 'max'=>1},
        'useContext' => {'valid_codes'=>{'urn:iso:std:iso:3166'=>[], 'http://unstats.un.org/unsd/methods/m49/m49.htm'=>[], 'https://www.usps.com/'=>['AK', 'AL', 'AR', 'AS', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'FM', 'GA', 'GU', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MH', 'MI', 'MN', 'MO', 'MP', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'PR', 'PW', 'RI', 'SC', 'SD', 'TN', 'TX', 'UM', 'UT', 'VA', 'VI', 'VT', 'WA', 'WI', 'WV', 'WY'], 'http://hl7.org/fhir/practitioner-specialty'=>['cardio', 'dent', 'dietary', 'midw', 'sysarch']}, 'type'=>'CodeableConcept', 'path'=>'StructureDefinition.useContext', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/use-context'}},
        'requirements' => {'type'=>'string', 'path'=>'StructureDefinition.requirements', 'min'=>0, 'max'=>1},
        'copyright' => {'type'=>'string', 'path'=>'StructureDefinition.copyright', 'min'=>0, 'max'=>1},
        'code' => {'valid_codes'=>{'http://snomed.info/sct'=>[], 'http://loinc.org'=>[]}, 'type'=>'Coding', 'path'=>'StructureDefinition.code', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/profile-code'}},
        'fhirVersion' => {'type'=>'id', 'path'=>'StructureDefinition.fhirVersion', 'min'=>0, 'max'=>1},
        'mapping' => {'type'=>'StructureDefinition::Mapping', 'path'=>'StructureDefinition.mapping', 'min'=>0, 'max'=>Float::INFINITY},
        'kind' => {'valid_codes'=>{'http://hl7.org/fhir/structure-definition-kind'=>['datatype', 'resource', 'logical']}, 'type'=>'code', 'path'=>'StructureDefinition.kind', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/structure-definition-kind'}},
        'constrainedType' => {'valid_codes'=>{'http://hl7.org/fhir/data-types'=>['Address', 'Age', 'Annotation', 'Attachment', 'BackboneElement', 'CodeableConcept', 'Coding', 'ContactPoint', 'Count', 'Distance', 'Duration', 'Element', 'ElementDefinition', 'Extension', 'HumanName', 'Identifier', 'Meta', 'Money', 'Narrative', 'Period', 'Quantity', 'Range', 'Ratio', 'Reference', 'SampledData', 'Signature', 'SimpleQuantity', 'Timing', 'base64Binary', 'boolean', 'code', 'date', 'dateTime', 'decimal', 'id', 'instant', 'integer', 'markdown', 'oid', 'positiveInt', 'string', 'time', 'unsignedInt', 'uri', 'uuid', 'xhtml'], 'http://hl7.org/fhir/resource-types'=>['Account', 'AllergyIntolerance', 'Appointment', 'AppointmentResponse', 'AuditEvent', 'Basic', 'Binary', 'BodySite', 'Bundle', 'CarePlan', 'Claim', 'ClaimResponse', 'ClinicalImpression', 'Communication', 'CommunicationRequest', 'Composition', 'ConceptMap', 'Condition', 'Conformance', 'Contract', 'Coverage', 'DataElement', 'DetectedIssue', 'Device', 'DeviceComponent', 'DeviceMetric', 'DeviceUseRequest', 'DeviceUseStatement', 'DiagnosticOrder', 'DiagnosticReport', 'DocumentManifest', 'DocumentReference', 'DomainResource', 'EligibilityRequest', 'EligibilityResponse', 'Encounter', 'EnrollmentRequest', 'EnrollmentResponse', 'EpisodeOfCare', 'ExplanationOfBenefit', 'FamilyMemberHistory', 'Flag', 'Goal', 'Group', 'HealthcareService', 'ImagingObjectSelection', 'ImagingStudy', 'Immunization', 'ImmunizationRecommendation', 'ImplementationGuide', 'List', 'Location', 'Media', 'Medication', 'MedicationAdministration', 'MedicationDispense', 'MedicationOrder', 'MedicationStatement', 'MessageHeader', 'NamingSystem', 'NutritionOrder', 'Observation', 'OperationDefinition', 'OperationOutcome', 'Order', 'OrderResponse', 'Organization', 'Parameters', 'Patient', 'PaymentNotice', 'PaymentReconciliation', 'Person', 'Practitioner', 'Procedure', 'ProcedureRequest', 'ProcessRequest', 'ProcessResponse', 'Provenance', 'Questionnaire', 'QuestionnaireResponse', 'ReferralRequest', 'RelatedPerson', 'Resource', 'RiskAssessment', 'Schedule', 'SearchParameter', 'Slot', 'Specimen', 'StructureDefinition', 'Subscription', 'Substance', 'SupplyDelivery', 'SupplyRequest', 'TestScript', 'ValueSet', 'VisionPrescription']}, 'type'=>'code', 'path'=>'StructureDefinition.constrainedType', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/defined-types'}},
        'abstract' => {'type'=>'boolean', 'path'=>'StructureDefinition.abstract', 'min'=>1, 'max'=>1},
        'contextType' => {'valid_codes'=>{'http://hl7.org/fhir/extension-context'=>['resource', 'datatype', 'mapping', 'extension']}, 'type'=>'code', 'path'=>'StructureDefinition.contextType', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/extension-context'}},
        'context' => {'type'=>'string', 'path'=>'StructureDefinition.context', 'min'=>0, 'max'=>Float::INFINITY},
        'base' => {'type'=>'uri', 'path'=>'StructureDefinition.base', 'min'=>0, 'max'=>1},
        'snapshot' => {'type'=>'StructureDefinition::Snapshot', 'path'=>'StructureDefinition.snapshot', 'min'=>0, 'max'=>1},
        'differential' => {'type'=>'StructureDefinition::Differential', 'path'=>'StructureDefinition.differential', 'min'=>0, 'max'=>1}
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

      class Mapping < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Mapping.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Mapping.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Mapping.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'identity' => {'type'=>'id', 'path'=>'Mapping.identity', 'min'=>1, 'max'=>1},
          'uri' => {'type'=>'uri', 'path'=>'Mapping.uri', 'min'=>0, 'max'=>1},
          'name' => {'type'=>'string', 'path'=>'Mapping.name', 'min'=>0, 'max'=>1},
          'comments' => {'type'=>'string', 'path'=>'Mapping.comments', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :identity          # 1-1 id
        attr_accessor :uri               # 0-1 uri
        attr_accessor :name              # 0-1 string
        attr_accessor :comments          # 0-1 string
      end

      class Snapshot < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Snapshot.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Snapshot.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Snapshot.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'element' => {'type'=>'ElementDefinition', 'path'=>'Snapshot.element', 'min'=>1, 'max'=>Float::INFINITY}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :element           # 1-* [ ElementDefinition ]
      end

      class Differential < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Differential.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Differential.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Differential.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'element' => {'type'=>'ElementDefinition', 'path'=>'Differential.element', 'min'=>1, 'max'=>Float::INFINITY}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :element           # 1-* [ ElementDefinition ]
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
      attr_accessor :identifier        # 0-* [ Identifier ]
      attr_accessor :version           # 0-1 string
      attr_accessor :name              # 1-1 string
      attr_accessor :display           # 0-1 string
      attr_accessor :status            # 1-1 code
      attr_accessor :experimental      # 0-1 boolean
      attr_accessor :publisher         # 0-1 string
      attr_accessor :contact           # 0-* [ StructureDefinition::Contact ]
      attr_accessor :date              # 0-1 dateTime
      attr_accessor :description       # 0-1 string
      attr_accessor :useContext        # 0-* [ CodeableConcept ]
      attr_accessor :requirements      # 0-1 string
      attr_accessor :copyright         # 0-1 string
      attr_accessor :code              # 0-* [ Coding ]
      attr_accessor :fhirVersion       # 0-1 id
      attr_accessor :mapping           # 0-* [ StructureDefinition::Mapping ]
      attr_accessor :kind              # 1-1 code
      attr_accessor :constrainedType   # 0-1 code
      attr_accessor :abstract          # 1-1 boolean
      attr_accessor :contextType       # 0-1 code
      attr_accessor :context           # 0-* [ string ]
      attr_accessor :base              # 0-1 uri
      attr_accessor :snapshot          # 0-1 StructureDefinition::Snapshot
      attr_accessor :differential      # 0-1 StructureDefinition::Differential

      def resourceType
        'StructureDefinition'
      end
    end
  end
end
