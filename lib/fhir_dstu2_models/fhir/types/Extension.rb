module FHIR
  module DSTU2
    class Extension < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'value' => ['boolean', 'integer', 'decimal', 'base64Binary', 'instant', 'string', 'uri', 'date', 'dateTime', 'time', 'code', 'oid', 'id', 'unsignedInt', 'positiveInt', 'markdown', 'Annotation', 'Attachment', 'Identifier', 'CodeableConcept', 'Coding', 'Quantity', 'Range', 'Period', 'Ratio', 'SampledData', 'Signature', 'HumanName', 'Address', 'ContactPoint', 'Timing', 'Reference', 'Meta']
      }
      SEARCH_PARAMS =
        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Extension.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Extension.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'url' => {'type'=>'uri', 'path'=>'Extension.url', 'min'=>1, 'max'=>1},
          'valueBoolean' => {'type'=>'boolean', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueInteger' => {'type'=>'integer', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueDecimal' => {'type'=>'decimal', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueBase64Binary' => {'type'=>'base64Binary', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueInstant' => {'type'=>'instant', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueString' => {'type'=>'string', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueUri' => {'type'=>'uri', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueDate' => {'type'=>'date', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueDateTime' => {'type'=>'dateTime', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueTime' => {'type'=>'time', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueCode' => {'type'=>'code', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueOid' => {'type'=>'oid', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueId' => {'type'=>'id', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueUnsignedInt' => {'type'=>'unsignedInt', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valuePositiveInt' => {'type'=>'positiveInt', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueMarkdown' => {'type'=>'markdown', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueAnnotation' => {'type'=>'Annotation', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueAttachment' => {'type'=>'Attachment', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueIdentifier' => {'type'=>'Identifier', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueCoding' => {'type'=>'Coding', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueQuantity' => {'type'=>'Quantity', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueRange' => {'type'=>'Range', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valuePeriod' => {'type'=>'Period', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueRatio' => {'type'=>'Ratio', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueSampledData' => {'type'=>'SampledData', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueSignature' => {'type'=>'Signature', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueHumanName' => {'type'=>'HumanName', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueAddress' => {'type'=>'Address', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueContactPoint' => {'type'=>'ContactPoint', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueTiming' => {'type'=>'Timing', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueReference' => {'type'=>'Reference', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1},
          'valueMeta' => {'type'=>'Meta', 'path'=>'Extension.value[x]', 'min'=>0, 'max'=>1}
        }

      attr_accessor :id                   # 0-1 id
      attr_accessor :extension            # 0-* [ Extension ]
      attr_accessor :url                  # 1-1 uri
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
    end
  end
end
