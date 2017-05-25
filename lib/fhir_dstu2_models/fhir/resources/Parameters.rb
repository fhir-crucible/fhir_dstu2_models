module FHIR
  module DSTU2
    class Parameters < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = 
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Parameters.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'Parameters.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'Parameters.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'Parameters.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'parameter' => {'type'=>'Parameters::Parameter', 'path'=>'Parameters.parameter', 'min'=>0, 'max'=>Float::INFINITY}
      }

      class Parameter < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'value' => ['boolean', 'integer', 'decimal', 'base64Binary', 'instant', 'string', 'uri', 'date', 'dateTime', 'time', 'code', 'oid', 'id', 'unsignedInt', 'positiveInt', 'markdown', 'Annotation', 'Attachment', 'Identifier', 'CodeableConcept', 'Coding', 'Quantity', 'Range', 'Period', 'Ratio', 'SampledData', 'Signature', 'HumanName', 'Address', 'ContactPoint', 'Timing', 'Reference', 'Meta']
        }
        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Parameter.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Parameter.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Parameter.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'name' => {'type'=>'string', 'path'=>'Parameter.name', 'min'=>1, 'max'=>1},
          'valueBoolean' => {'type'=>'boolean', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueInteger' => {'type'=>'integer', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueDecimal' => {'type'=>'decimal', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueBase64Binary' => {'type'=>'base64Binary', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueInstant' => {'type'=>'instant', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueString' => {'type'=>'string', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueUri' => {'type'=>'uri', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueDate' => {'type'=>'date', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueDateTime' => {'type'=>'dateTime', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueTime' => {'type'=>'time', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueCode' => {'type'=>'code', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueOid' => {'type'=>'oid', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueId' => {'type'=>'id', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueUnsignedInt' => {'type'=>'unsignedInt', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valuePositiveInt' => {'type'=>'positiveInt', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueMarkdown' => {'type'=>'markdown', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueAnnotation' => {'type'=>'Annotation', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueAttachment' => {'type'=>'Attachment', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueIdentifier' => {'type'=>'Identifier', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueCoding' => {'type'=>'Coding', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueQuantity' => {'type'=>'Quantity', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueRange' => {'type'=>'Range', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valuePeriod' => {'type'=>'Period', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueRatio' => {'type'=>'Ratio', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueSampledData' => {'type'=>'SampledData', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueSignature' => {'type'=>'Signature', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueHumanName' => {'type'=>'HumanName', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueAddress' => {'type'=>'Address', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueContactPoint' => {'type'=>'ContactPoint', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueTiming' => {'type'=>'Timing', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueReference' => {'type'=>'Reference', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'valueMeta' => {'type'=>'Meta', 'path'=>'Parameter.value[x]', 'min'=>0, 'max'=>1},
          'resource' => {'type'=>'Resource', 'path'=>'Parameter.resource', 'min'=>0, 'max'=>1},
          'part' => {'type'=>'Parameters::Parameter', 'path'=>'Parameter.part', 'min'=>0, 'max'=>Float::INFINITY}
        }

        attr_accessor :id                   # 0-1 id
        attr_accessor :extension            # 0-* [ Extension ]
        attr_accessor :modifierExtension    # 0-* [ Extension ]
        attr_accessor :name                 # 1-1 string
        attr_accessor :valueBoolean         # 0-1 boolean
        attr_accessor :valueInteger         # 0-1 integer
        attr_accessor :valueDecimal         # 0-1 decimal
        attr_accessor :valueBase64Binary    # 0-1 base64Binary
        attr_accessor :valueInstant         # 0-1 instant
        attr_accessor :valueString          # 0-1 string
        attr_accessor :valueUri             # 0-1 uri
        attr_accessor :valueDate            # 0-1 date
        attr_accessor :valueDateTime        # 0-1 dateTime
        attr_accessor :valueTime            # 0-1 time
        attr_accessor :valueCode            # 0-1 code
        attr_accessor :valueOid             # 0-1 oid
        attr_accessor :valueId              # 0-1 id
        attr_accessor :valueUnsignedInt     # 0-1 unsignedInt
        attr_accessor :valuePositiveInt     # 0-1 positiveInt
        attr_accessor :valueMarkdown        # 0-1 markdown
        attr_accessor :valueAnnotation      # 0-1 Annotation
        attr_accessor :valueAttachment      # 0-1 Attachment
        attr_accessor :valueIdentifier      # 0-1 Identifier
        attr_accessor :valueCodeableConcept # 0-1 CodeableConcept
        attr_accessor :valueCoding          # 0-1 Coding
        attr_accessor :valueQuantity        # 0-1 Quantity
        attr_accessor :valueRange           # 0-1 Range
        attr_accessor :valuePeriod          # 0-1 Period
        attr_accessor :valueRatio           # 0-1 Ratio
        attr_accessor :valueSampledData     # 0-1 SampledData
        attr_accessor :valueSignature       # 0-1 Signature
        attr_accessor :valueHumanName       # 0-1 HumanName
        attr_accessor :valueAddress         # 0-1 Address
        attr_accessor :valueContactPoint    # 0-1 ContactPoint
        attr_accessor :valueTiming          # 0-1 Timing
        attr_accessor :valueReference       # 0-1 Reference()
        attr_accessor :valueMeta            # 0-1 Meta
        attr_accessor :resource             # 0-1 Resource
        attr_accessor :part                 # 0-* [ Parameters::Parameter ]
      end

      attr_accessor :id            # 0-1 id
      attr_accessor :meta          # 0-1 Meta
      attr_accessor :implicitRules # 0-1 uri
      attr_accessor :language      # 0-1 code
      attr_accessor :parameter     # 0-* [ Parameters::Parameter ]

      def resourceType
        'Parameters'
      end
    end
  end
end