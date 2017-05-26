module FHIR
  module DSTU2
    class Questionnaire < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['code', 'date', 'identifier', 'publisher', 'status', 'title', 'version', 'author', 'authored', 'encounter', 'patient', 'questionnaire', 'source', 'status', 'subject']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Questionnaire.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'Questionnaire.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'Questionnaire.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'Questionnaire.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'Questionnaire.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'Questionnaire.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'Questionnaire.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Questionnaire.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'Questionnaire.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'version' => {'type'=>'string', 'path'=>'Questionnaire.version', 'min'=>0, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/questionnaire-status'=>['draft', 'published', 'retired']}, 'type'=>'code', 'path'=>'Questionnaire.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/questionnaire-status'}},
        'date' => {'type'=>'dateTime', 'path'=>'Questionnaire.date', 'min'=>0, 'max'=>1},
        'publisher' => {'type'=>'string', 'path'=>'Questionnaire.publisher', 'min'=>0, 'max'=>1},
        'telecom' => {'type'=>'ContactPoint', 'path'=>'Questionnaire.telecom', 'min'=>0, 'max'=>Float::INFINITY},
        'subjectType' => {'valid_codes'=>{'http://hl7.org/fhir/resource-types'=>['Account', 'AllergyIntolerance', 'Appointment', 'AppointmentResponse', 'AuditEvent', 'Basic', 'Binary', 'BodySite', 'Bundle', 'CarePlan', 'Claim', 'ClaimResponse', 'ClinicalImpression', 'Communication', 'CommunicationRequest', 'Composition', 'ConceptMap', 'Condition', 'Conformance', 'Contract', 'Coverage', 'DataElement', 'DetectedIssue', 'Device', 'DeviceComponent', 'DeviceMetric', 'DeviceUseRequest', 'DeviceUseStatement', 'DiagnosticOrder', 'DiagnosticReport', 'DocumentManifest', 'DocumentReference', 'DomainResource', 'EligibilityRequest', 'EligibilityResponse', 'Encounter', 'EnrollmentRequest', 'EnrollmentResponse', 'EpisodeOfCare', 'ExplanationOfBenefit', 'FamilyMemberHistory', 'Flag', 'Goal', 'Group', 'HealthcareService', 'ImagingObjectSelection', 'ImagingStudy', 'Immunization', 'ImmunizationRecommendation', 'ImplementationGuide', 'List', 'Location', 'Media', 'Medication', 'MedicationAdministration', 'MedicationDispense', 'MedicationOrder', 'MedicationStatement', 'MessageHeader', 'NamingSystem', 'NutritionOrder', 'Observation', 'OperationDefinition', 'OperationOutcome', 'Order', 'OrderResponse', 'Organization', 'Parameters', 'Patient', 'PaymentNotice', 'PaymentReconciliation', 'Person', 'Practitioner', 'Procedure', 'ProcedureRequest', 'ProcessRequest', 'ProcessResponse', 'Provenance', 'Questionnaire', 'QuestionnaireResponse', 'ReferralRequest', 'RelatedPerson', 'Resource', 'RiskAssessment', 'Schedule', 'SearchParameter', 'Slot', 'Specimen', 'StructureDefinition', 'Subscription', 'Substance', 'SupplyDelivery', 'SupplyRequest', 'TestScript', 'ValueSet', 'VisionPrescription']}, 'type'=>'code', 'path'=>'Questionnaire.subjectType', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/resource-types'}},
        'group' => {'type'=>'Questionnaire::Group', 'path'=>'Questionnaire.group', 'min'=>1, 'max'=>1}
      }

      class Group < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Group.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Group.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Group.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'linkId' => {'type'=>'string', 'path'=>'Group.linkId', 'min'=>0, 'max'=>1},
          'title' => {'type'=>'string', 'path'=>'Group.title', 'min'=>0, 'max'=>1},
          'concept' => {'valid_codes'=>{'http://loinc.org'=>[]}, 'type'=>'Coding', 'path'=>'Group.concept', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/questionnaire-questions'}},
          'text' => {'type'=>'string', 'path'=>'Group.text', 'min'=>0, 'max'=>1},
          'required' => {'type'=>'boolean', 'path'=>'Group.required', 'min'=>0, 'max'=>1},
          'repeats' => {'type'=>'boolean', 'path'=>'Group.repeats', 'min'=>0, 'max'=>1},
          'group' => {'type'=>'Questionnaire::Group', 'path'=>'Group.group', 'min'=>0, 'max'=>Float::INFINITY},
          'question' => {'type'=>'Questionnaire::Group::Question', 'path'=>'Group.question', 'min'=>0, 'max'=>Float::INFINITY}
        }

        class Question < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          METADATA = {
            'id' => {'type'=>'id', 'path'=>'Question.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Question.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Question.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'linkId' => {'type'=>'string', 'path'=>'Question.linkId', 'min'=>0, 'max'=>1},
            'concept' => {'valid_codes'=>{'http://loinc.org'=>[]}, 'type'=>'Coding', 'path'=>'Question.concept', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/questionnaire-questions'}},
            'text' => {'type'=>'string', 'path'=>'Question.text', 'min'=>0, 'max'=>1},
            'type' => {'valid_codes'=>{'http://hl7.org/fhir/answer-format'=>['boolean', 'decimal', 'integer', 'date', 'dateTime', 'instant', 'time', 'string', 'text', 'url', 'choice', 'open-choice', 'attachment', 'reference', 'quantity']}, 'type'=>'code', 'path'=>'Question.type', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/answer-format'}},
            'required' => {'type'=>'boolean', 'path'=>'Question.required', 'min'=>0, 'max'=>1},
            'repeats' => {'type'=>'boolean', 'path'=>'Question.repeats', 'min'=>0, 'max'=>1},
            'options' => {'type'=>'Reference', 'path'=>'Question.options', 'min'=>0, 'max'=>1},
            'option' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'Coding', 'path'=>'Question.option', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/questionnaire-answers'}},
            'group' => {'type'=>'Questionnaire::Group', 'path'=>'Question.group', 'min'=>0, 'max'=>Float::INFINITY}
          }

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :linkId            # 0-1 string
          attr_accessor :concept           # 0-* [ Coding ]
          attr_accessor :text              # 0-1 string
          attr_accessor :type              # 0-1 code
          attr_accessor :required          # 0-1 boolean
          attr_accessor :repeats           # 0-1 boolean
          attr_accessor :options           # 0-1 Reference()
          attr_accessor :option            # 0-* [ Coding ]
          attr_accessor :group             # 0-* [ Questionnaire::Group ]
        end

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :linkId            # 0-1 string
        attr_accessor :title             # 0-1 string
        attr_accessor :concept           # 0-* [ Coding ]
        attr_accessor :text              # 0-1 string
        attr_accessor :required          # 0-1 boolean
        attr_accessor :repeats           # 0-1 boolean
        attr_accessor :group             # 0-* [ Questionnaire::Group ]
        attr_accessor :question          # 0-* [ Questionnaire::Group::Question ]
      end

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :identifier        # 0-* [ Identifier ]
      attr_accessor :version           # 0-1 string
      attr_accessor :status            # 1-1 code
      attr_accessor :date              # 0-1 dateTime
      attr_accessor :publisher         # 0-1 string
      attr_accessor :telecom           # 0-* [ ContactPoint ]
      attr_accessor :subjectType       # 0-* [ code ]
      attr_accessor :group             # 1-1 Questionnaire::Group

      def resourceType
        'Questionnaire'
      end
    end
  end
end