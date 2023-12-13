module FHIR
  module DSTU2
    class QuestionnaireResponse < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['author', 'authored', 'encounter', 'patient', 'questionnaire', 'source', 'status', 'subject']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'QuestionnaireResponse.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'QuestionnaireResponse.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'QuestionnaireResponse.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'QuestionnaireResponse.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'QuestionnaireResponse.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'QuestionnaireResponse.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'QuestionnaireResponse.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'QuestionnaireResponse.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'QuestionnaireResponse.identifier', 'min'=>0, 'max'=>1},
        'questionnaire' => {'type'=>'Reference', 'path'=>'QuestionnaireResponse.questionnaire', 'min'=>0, 'max'=>1},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/questionnaire-answers-status'=>['in-progress', 'completed', 'amended']}, 'type'=>'code', 'path'=>'QuestionnaireResponse.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/questionnaire-answers-status'}},
        'subject' => {'type'=>'Reference', 'path'=>'QuestionnaireResponse.subject', 'min'=>0, 'max'=>1},
        'author' => {'type'=>'Reference', 'path'=>'QuestionnaireResponse.author', 'min'=>0, 'max'=>1},
        'authored' => {'type'=>'dateTime', 'path'=>'QuestionnaireResponse.authored', 'min'=>0, 'max'=>1},
        'source' => {'type'=>'Reference', 'path'=>'QuestionnaireResponse.source', 'min'=>0, 'max'=>1},
        'encounter' => {'type'=>'Reference', 'path'=>'QuestionnaireResponse.encounter', 'min'=>0, 'max'=>1},
        'group' => {'type'=>'QuestionnaireResponse::Group', 'path'=>'QuestionnaireResponse.group', 'min'=>0, 'max'=>1}
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
          'text' => {'type'=>'string', 'path'=>'Group.text', 'min'=>0, 'max'=>1},
          'subject' => {'type'=>'Reference', 'path'=>'Group.subject', 'min'=>0, 'max'=>1},
          'group' => {'type'=>'QuestionnaireResponse::Group', 'path'=>'Group.group', 'min'=>0, 'max'=>Float::INFINITY},
          'question' => {'type'=>'QuestionnaireResponse::Group::Question', 'path'=>'Group.question', 'min'=>0, 'max'=>Float::INFINITY}
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
            'text' => {'type'=>'string', 'path'=>'Question.text', 'min'=>0, 'max'=>1},
            'answer' => {'type'=>'QuestionnaireResponse::Group::Question::Answer', 'path'=>'Question.answer', 'min'=>0, 'max'=>Float::INFINITY}
          }

          class Answer < FHIR::DSTU2::Model
            include FHIR::DSTU2::Hashable
            include FHIR::DSTU2::Json
            include FHIR::DSTU2::Xml

            MULTIPLE_TYPES = {
              'value' => ['boolean', 'decimal', 'integer', 'date', 'dateTime', 'instant', 'time', 'string', 'uri', 'Attachment', 'Coding', 'Quantity', 'Reference']
            }
            METADATA = {
              'id' => {'type'=>'id', 'path'=>'Answer.id', 'min'=>0, 'max'=>1},
              'extension' => {'type'=>'Extension', 'path'=>'Answer.extension', 'min'=>0, 'max'=>Float::INFINITY},
              'modifierExtension' => {'type'=>'Extension', 'path'=>'Answer.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
              'valueBoolean' => {'type'=>'boolean', 'path'=>'Answer.value[x]', 'min'=>0, 'max'=>1},
              'valueDecimal' => {'type'=>'decimal', 'path'=>'Answer.value[x]', 'min'=>0, 'max'=>1},
              'valueInteger' => {'type'=>'integer', 'path'=>'Answer.value[x]', 'min'=>0, 'max'=>1},
              'valueDate' => {'type'=>'date', 'path'=>'Answer.value[x]', 'min'=>0, 'max'=>1},
              'valueDateTime' => {'type'=>'dateTime', 'path'=>'Answer.value[x]', 'min'=>0, 'max'=>1},
              'valueInstant' => {'type'=>'instant', 'path'=>'Answer.value[x]', 'min'=>0, 'max'=>1},
              'valueTime' => {'type'=>'time', 'path'=>'Answer.value[x]', 'min'=>0, 'max'=>1},
              'valueString' => {'type'=>'string', 'path'=>'Answer.value[x]', 'min'=>0, 'max'=>1},
              'valueUri' => {'type'=>'uri', 'path'=>'Answer.value[x]', 'min'=>0, 'max'=>1},
              'valueAttachment' => {'type'=>'Attachment', 'path'=>'Answer.value[x]', 'min'=>0, 'max'=>1},
              'valueCoding' => {'type'=>'Coding', 'path'=>'Answer.value[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
              'valueQuantity' => {'type'=>'Quantity', 'path'=>'Answer.value[x]', 'min'=>0, 'max'=>1},
              'valueReference' => {'type'=>'Reference', 'path'=>'Answer.value[x]', 'min'=>0, 'max'=>1},
              'group' => {'type'=>'QuestionnaireResponse::Group', 'path'=>'Answer.group', 'min'=>0, 'max'=>Float::INFINITY}
            }

            attr_accessor :id                # 0-1 id
            attr_accessor :extension         # 0-* [ Extension ]
            attr_accessor :modifierExtension # 0-* [ Extension ]
            attr_accessor :valueBoolean      # 0-1 boolean
            attr_accessor :valueDecimal      # 0-1 decimal
            attr_accessor :valueInteger      # 0-1 integer
            attr_accessor :valueDate         # 0-1 date
            attr_accessor :valueDateTime     # 0-1 dateTime
            attr_accessor :valueInstant      # 0-1 instant
            attr_accessor :valueTime         # 0-1 time
            attr_accessor :valueString       # 0-1 string
            attr_accessor :valueUri          # 0-1 uri
            attr_accessor :valueAttachment   # 0-1 Attachment
            attr_accessor :valueCoding       # 0-1 Coding
            attr_accessor :valueQuantity     # 0-1 Quantity
            attr_accessor :valueReference    # 0-1 Reference()
            attr_accessor :group             # 0-* [ QuestionnaireResponse::Group ]
          end

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :linkId            # 0-1 string
          attr_accessor :text              # 0-1 string
          attr_accessor :answer            # 0-* [ QuestionnaireResponse::Group::Question::Answer ]
        end

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :linkId            # 0-1 string
        attr_accessor :title             # 0-1 string
        attr_accessor :text              # 0-1 string
        attr_accessor :subject           # 0-1 Reference()
        attr_accessor :group             # 0-* [ QuestionnaireResponse::Group ]
        attr_accessor :question          # 0-* [ QuestionnaireResponse::Group::Question ]
      end

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :identifier        # 0-1 Identifier
      attr_accessor :questionnaire     # 0-1 Reference()
      attr_accessor :status            # 1-1 code
      attr_accessor :subject           # 0-1 Reference()
      attr_accessor :author            # 0-1 Reference()
      attr_accessor :authored          # 0-1 dateTime
      attr_accessor :source            # 0-1 Reference()
      attr_accessor :encounter         # 0-1 Reference()
      attr_accessor :group             # 0-1 QuestionnaireResponse::Group

      def resourceType
        'QuestionnaireResponse'
      end
    end
  end
end
