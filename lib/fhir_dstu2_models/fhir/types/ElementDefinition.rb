module FHIR
  module DSTU2
    class ElementDefinition < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'defaultValue' => ['boolean', 'integer', 'decimal', 'base64Binary', 'instant', 'string', 'uri', 'date', 'dateTime', 'time', 'code', 'oid', 'id', 'unsignedInt', 'positiveInt', 'markdown', 'Annotation', 'Attachment', 'Identifier', 'CodeableConcept', 'Coding', 'Quantity', 'Range', 'Period', 'Ratio', 'SampledData', 'Signature', 'HumanName', 'Address', 'ContactPoint', 'Timing', 'Reference', 'Meta'],
        'fixed' => ['boolean', 'integer', 'decimal', 'base64Binary', 'instant', 'string', 'uri', 'date', 'dateTime', 'time', 'code', 'oid', 'id', 'unsignedInt', 'positiveInt', 'markdown', 'Annotation', 'Attachment', 'Identifier', 'CodeableConcept', 'Coding', 'Quantity', 'Range', 'Period', 'Ratio', 'SampledData', 'Signature', 'HumanName', 'Address', 'ContactPoint', 'Timing', 'Reference', 'Meta'],
        'pattern' => ['boolean', 'integer', 'decimal', 'base64Binary', 'instant', 'string', 'uri', 'date', 'dateTime', 'time', 'code', 'oid', 'id', 'unsignedInt', 'positiveInt', 'markdown', 'Annotation', 'Attachment', 'Identifier', 'CodeableConcept', 'Coding', 'Quantity', 'Range', 'Period', 'Ratio', 'SampledData', 'Signature', 'HumanName', 'Address', 'ContactPoint', 'Timing', 'Reference', 'Meta'],
        'example' => ['boolean', 'integer', 'decimal', 'base64Binary', 'instant', 'string', 'uri', 'date', 'dateTime', 'time', 'code', 'oid', 'id', 'unsignedInt', 'positiveInt', 'markdown', 'Annotation', 'Attachment', 'Identifier', 'CodeableConcept', 'Coding', 'Quantity', 'Range', 'Period', 'Ratio', 'SampledData', 'Signature', 'HumanName', 'Address', 'ContactPoint', 'Timing', 'Reference', 'Meta'],
        'minValue' => ['boolean', 'integer', 'decimal', 'base64Binary', 'instant', 'string', 'uri', 'date', 'dateTime', 'time', 'code', 'oid', 'id', 'unsignedInt', 'positiveInt', 'markdown', 'Annotation', 'Attachment', 'Identifier', 'CodeableConcept', 'Coding', 'Quantity', 'Range', 'Period', 'Ratio', 'SampledData', 'Signature', 'HumanName', 'Address', 'ContactPoint', 'Timing', 'Reference', 'Meta'],
        'maxValue' => ['boolean', 'integer', 'decimal', 'base64Binary', 'instant', 'string', 'uri', 'date', 'dateTime', 'time', 'code', 'oid', 'id', 'unsignedInt', 'positiveInt', 'markdown', 'Annotation', 'Attachment', 'Identifier', 'CodeableConcept', 'Coding', 'Quantity', 'Range', 'Period', 'Ratio', 'SampledData', 'Signature', 'HumanName', 'Address', 'ContactPoint', 'Timing', 'Reference', 'Meta']
      }
      SEARCH_PARAMS =
        METADATA = {
          'id' => {'type'=>'id', 'path'=>'ElementDefinition.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'ElementDefinition.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'path' => {'type'=>'string', 'path'=>'ElementDefinition.path', 'min'=>1, 'max'=>1},
          'representation' => {'valid_codes'=>{'http://hl7.org/fhir/property-representation'=>['xmlAttr']}, 'type'=>'code', 'path'=>'ElementDefinition.representation', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/property-representation'}},
          'name' => {'type'=>'string', 'path'=>'ElementDefinition.name', 'min'=>0, 'max'=>1},
          'label' => {'type'=>'string', 'path'=>'ElementDefinition.label', 'min'=>0, 'max'=>1},
          'code' => {'valid_codes'=>{'http://loinc.org'=>[]}, 'type'=>'Coding', 'path'=>'ElementDefinition.code', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/observation-codes'}},
          'slicing' => {'type'=>'ElementDefinition::Slicing', 'path'=>'ElementDefinition.slicing', 'min'=>0, 'max'=>1},
          'short' => {'type'=>'string', 'path'=>'ElementDefinition.short', 'min'=>0, 'max'=>1},
          'definition' => {'type'=>'markdown', 'path'=>'ElementDefinition.definition', 'min'=>0, 'max'=>1},
          'comments' => {'type'=>'markdown', 'path'=>'ElementDefinition.comments', 'min'=>0, 'max'=>1},
          'requirements' => {'type'=>'markdown', 'path'=>'ElementDefinition.requirements', 'min'=>0, 'max'=>1},
          'alias' => {'type'=>'string', 'path'=>'ElementDefinition.alias', 'min'=>0, 'max'=>Float::INFINITY},
          'min' => {'type'=>'integer', 'path'=>'ElementDefinition.min', 'min'=>0, 'max'=>1},
          'max' => {'type'=>'string', 'path'=>'ElementDefinition.max', 'min'=>0, 'max'=>1},
          'base' => {'type'=>'ElementDefinition::Base', 'path'=>'ElementDefinition.base', 'min'=>0, 'max'=>1},
          'type' => {'type'=>'ElementDefinition::Type', 'path'=>'ElementDefinition.type', 'min'=>0, 'max'=>Float::INFINITY},
          'nameReference' => {'type'=>'string', 'path'=>'ElementDefinition.nameReference', 'min'=>0, 'max'=>1},
          'defaultValueBoolean' => {'type'=>'boolean', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueInteger' => {'type'=>'integer', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueDecimal' => {'type'=>'decimal', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueBase64Binary' => {'type'=>'base64Binary', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueInstant' => {'type'=>'instant', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueString' => {'type'=>'string', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueUri' => {'type'=>'uri', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueDate' => {'type'=>'date', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueDateTime' => {'type'=>'dateTime', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueTime' => {'type'=>'time', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueCode' => {'type'=>'code', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueOid' => {'type'=>'oid', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueId' => {'type'=>'id', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueUnsignedInt' => {'type'=>'unsignedInt', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValuePositiveInt' => {'type'=>'positiveInt', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueMarkdown' => {'type'=>'markdown', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueAnnotation' => {'type'=>'Annotation', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueAttachment' => {'type'=>'Attachment', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueIdentifier' => {'type'=>'Identifier', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueCoding' => {'type'=>'Coding', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueQuantity' => {'type'=>'Quantity', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueRange' => {'type'=>'Range', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValuePeriod' => {'type'=>'Period', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueRatio' => {'type'=>'Ratio', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueSampledData' => {'type'=>'SampledData', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueSignature' => {'type'=>'Signature', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueHumanName' => {'type'=>'HumanName', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueAddress' => {'type'=>'Address', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueContactPoint' => {'type'=>'ContactPoint', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueTiming' => {'type'=>'Timing', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueReference' => {'type'=>'Reference', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'defaultValueMeta' => {'type'=>'Meta', 'path'=>'ElementDefinition.defaultValue[x]', 'min'=>0, 'max'=>1},
          'meaningWhenMissing' => {'type'=>'markdown', 'path'=>'ElementDefinition.meaningWhenMissing', 'min'=>0, 'max'=>1},
          'fixedBoolean' => {'type'=>'boolean', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedInteger' => {'type'=>'integer', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedDecimal' => {'type'=>'decimal', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedBase64Binary' => {'type'=>'base64Binary', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedInstant' => {'type'=>'instant', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedString' => {'type'=>'string', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedUri' => {'type'=>'uri', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedDate' => {'type'=>'date', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedDateTime' => {'type'=>'dateTime', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedTime' => {'type'=>'time', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedCode' => {'type'=>'code', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedOid' => {'type'=>'oid', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedId' => {'type'=>'id', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedUnsignedInt' => {'type'=>'unsignedInt', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedPositiveInt' => {'type'=>'positiveInt', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedMarkdown' => {'type'=>'markdown', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedAnnotation' => {'type'=>'Annotation', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedAttachment' => {'type'=>'Attachment', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedIdentifier' => {'type'=>'Identifier', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedCoding' => {'type'=>'Coding', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedQuantity' => {'type'=>'Quantity', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedRange' => {'type'=>'Range', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedPeriod' => {'type'=>'Period', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedRatio' => {'type'=>'Ratio', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedSampledData' => {'type'=>'SampledData', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedSignature' => {'type'=>'Signature', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedHumanName' => {'type'=>'HumanName', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedAddress' => {'type'=>'Address', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedContactPoint' => {'type'=>'ContactPoint', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedTiming' => {'type'=>'Timing', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedReference' => {'type'=>'Reference', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'fixedMeta' => {'type'=>'Meta', 'path'=>'ElementDefinition.fixed[x]', 'min'=>0, 'max'=>1},
          'patternBoolean' => {'type'=>'boolean', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternInteger' => {'type'=>'integer', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternDecimal' => {'type'=>'decimal', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternBase64Binary' => {'type'=>'base64Binary', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternInstant' => {'type'=>'instant', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternString' => {'type'=>'string', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternUri' => {'type'=>'uri', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternDate' => {'type'=>'date', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternDateTime' => {'type'=>'dateTime', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternTime' => {'type'=>'time', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternCode' => {'type'=>'code', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternOid' => {'type'=>'oid', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternId' => {'type'=>'id', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternUnsignedInt' => {'type'=>'unsignedInt', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternPositiveInt' => {'type'=>'positiveInt', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternMarkdown' => {'type'=>'markdown', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternAnnotation' => {'type'=>'Annotation', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternAttachment' => {'type'=>'Attachment', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternIdentifier' => {'type'=>'Identifier', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternCoding' => {'type'=>'Coding', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternQuantity' => {'type'=>'Quantity', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternRange' => {'type'=>'Range', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternPeriod' => {'type'=>'Period', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternRatio' => {'type'=>'Ratio', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternSampledData' => {'type'=>'SampledData', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternSignature' => {'type'=>'Signature', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternHumanName' => {'type'=>'HumanName', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternAddress' => {'type'=>'Address', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternContactPoint' => {'type'=>'ContactPoint', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternTiming' => {'type'=>'Timing', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternReference' => {'type'=>'Reference', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'patternMeta' => {'type'=>'Meta', 'path'=>'ElementDefinition.pattern[x]', 'min'=>0, 'max'=>1},
          'exampleBoolean' => {'type'=>'boolean', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleInteger' => {'type'=>'integer', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleDecimal' => {'type'=>'decimal', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleBase64Binary' => {'type'=>'base64Binary', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleInstant' => {'type'=>'instant', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleString' => {'type'=>'string', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleUri' => {'type'=>'uri', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleDate' => {'type'=>'date', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleDateTime' => {'type'=>'dateTime', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleTime' => {'type'=>'time', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleCode' => {'type'=>'code', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleOid' => {'type'=>'oid', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleId' => {'type'=>'id', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleUnsignedInt' => {'type'=>'unsignedInt', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'examplePositiveInt' => {'type'=>'positiveInt', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleMarkdown' => {'type'=>'markdown', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleAnnotation' => {'type'=>'Annotation', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleAttachment' => {'type'=>'Attachment', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleIdentifier' => {'type'=>'Identifier', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleCoding' => {'type'=>'Coding', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleQuantity' => {'type'=>'Quantity', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleRange' => {'type'=>'Range', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'examplePeriod' => {'type'=>'Period', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleRatio' => {'type'=>'Ratio', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleSampledData' => {'type'=>'SampledData', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleSignature' => {'type'=>'Signature', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleHumanName' => {'type'=>'HumanName', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleAddress' => {'type'=>'Address', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleContactPoint' => {'type'=>'ContactPoint', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleTiming' => {'type'=>'Timing', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleReference' => {'type'=>'Reference', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'exampleMeta' => {'type'=>'Meta', 'path'=>'ElementDefinition.example[x]', 'min'=>0, 'max'=>1},
          'minValueBoolean' => {'type'=>'boolean', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueInteger' => {'type'=>'integer', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueDecimal' => {'type'=>'decimal', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueBase64Binary' => {'type'=>'base64Binary', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueInstant' => {'type'=>'instant', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueString' => {'type'=>'string', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueUri' => {'type'=>'uri', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueDate' => {'type'=>'date', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueDateTime' => {'type'=>'dateTime', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueTime' => {'type'=>'time', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueCode' => {'type'=>'code', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueOid' => {'type'=>'oid', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueId' => {'type'=>'id', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueUnsignedInt' => {'type'=>'unsignedInt', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValuePositiveInt' => {'type'=>'positiveInt', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueMarkdown' => {'type'=>'markdown', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueAnnotation' => {'type'=>'Annotation', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueAttachment' => {'type'=>'Attachment', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueIdentifier' => {'type'=>'Identifier', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueCoding' => {'type'=>'Coding', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueQuantity' => {'type'=>'Quantity', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueRange' => {'type'=>'Range', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValuePeriod' => {'type'=>'Period', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueRatio' => {'type'=>'Ratio', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueSampledData' => {'type'=>'SampledData', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueSignature' => {'type'=>'Signature', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueHumanName' => {'type'=>'HumanName', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueAddress' => {'type'=>'Address', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueContactPoint' => {'type'=>'ContactPoint', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueTiming' => {'type'=>'Timing', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueReference' => {'type'=>'Reference', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'minValueMeta' => {'type'=>'Meta', 'path'=>'ElementDefinition.minValue[x]', 'min'=>0, 'max'=>1},
          'maxValueBoolean' => {'type'=>'boolean', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueInteger' => {'type'=>'integer', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueDecimal' => {'type'=>'decimal', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueBase64Binary' => {'type'=>'base64Binary', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueInstant' => {'type'=>'instant', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueString' => {'type'=>'string', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueUri' => {'type'=>'uri', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueDate' => {'type'=>'date', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueDateTime' => {'type'=>'dateTime', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueTime' => {'type'=>'time', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueCode' => {'type'=>'code', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueOid' => {'type'=>'oid', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueId' => {'type'=>'id', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueUnsignedInt' => {'type'=>'unsignedInt', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValuePositiveInt' => {'type'=>'positiveInt', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueMarkdown' => {'type'=>'markdown', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueAnnotation' => {'type'=>'Annotation', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueAttachment' => {'type'=>'Attachment', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueIdentifier' => {'type'=>'Identifier', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueCoding' => {'type'=>'Coding', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueQuantity' => {'type'=>'Quantity', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueRange' => {'type'=>'Range', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValuePeriod' => {'type'=>'Period', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueRatio' => {'type'=>'Ratio', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueSampledData' => {'type'=>'SampledData', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueSignature' => {'type'=>'Signature', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueHumanName' => {'type'=>'HumanName', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueAddress' => {'type'=>'Address', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueContactPoint' => {'type'=>'ContactPoint', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueTiming' => {'type'=>'Timing', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueReference' => {'type'=>'Reference', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxValueMeta' => {'type'=>'Meta', 'path'=>'ElementDefinition.maxValue[x]', 'min'=>0, 'max'=>1},
          'maxLength' => {'type'=>'integer', 'path'=>'ElementDefinition.maxLength', 'min'=>0, 'max'=>1},
          'condition' => {'type'=>'id', 'path'=>'ElementDefinition.condition', 'min'=>0, 'max'=>Float::INFINITY},
          'constraint' => {'type'=>'ElementDefinition::Constraint', 'path'=>'ElementDefinition.constraint', 'min'=>0, 'max'=>Float::INFINITY},
          'mustSupport' => {'type'=>'boolean', 'path'=>'ElementDefinition.mustSupport', 'min'=>0, 'max'=>1},
          'isModifier' => {'type'=>'boolean', 'path'=>'ElementDefinition.isModifier', 'min'=>0, 'max'=>1},
          'isSummary' => {'type'=>'boolean', 'path'=>'ElementDefinition.isSummary', 'min'=>0, 'max'=>1},
          'binding' => {'type'=>'ElementDefinition::Binding', 'path'=>'ElementDefinition.binding', 'min'=>0, 'max'=>1},
          'mapping' => {'type'=>'ElementDefinition::Mapping', 'path'=>'ElementDefinition.mapping', 'min'=>0, 'max'=>Float::INFINITY}
        }

      class Slicing < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Slicing.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Slicing.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'discriminator' => {'type'=>'string', 'path'=>'Slicing.discriminator', 'min'=>0, 'max'=>Float::INFINITY},
          'description' => {'type'=>'string', 'path'=>'Slicing.description', 'min'=>0, 'max'=>1},
          'ordered' => {'type'=>'boolean', 'path'=>'Slicing.ordered', 'min'=>0, 'max'=>1},
          'rules' => {'valid_codes'=>{'http://hl7.org/fhir/resource-slicing-rules'=>['closed', 'open', 'openAtEnd']}, 'type'=>'code', 'path'=>'Slicing.rules', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/resource-slicing-rules'}}
        }

        attr_accessor :id            # 0-1 id
        attr_accessor :extension     # 0-* [ Extension ]
        attr_accessor :discriminator # 0-* [ string ]
        attr_accessor :description   # 0-1 string
        attr_accessor :ordered       # 0-1 boolean
        attr_accessor :rules         # 1-1 code
      end

      class Base < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Base.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Base.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'path' => {'type'=>'string', 'path'=>'Base.path', 'min'=>1, 'max'=>1},
          'min' => {'type'=>'integer', 'path'=>'Base.min', 'min'=>1, 'max'=>1},
          'max' => {'type'=>'string', 'path'=>'Base.max', 'min'=>1, 'max'=>1}
        }

        attr_accessor :id        # 0-1 id
        attr_accessor :extension # 0-* [ Extension ]
        attr_accessor :path      # 1-1 string
        attr_accessor :min       # 1-1 integer
        attr_accessor :max       # 1-1 string
      end

      class Type < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Type.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Type.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'code' => {'valid_codes'=>{'http://hl7.org/fhir/data-types'=>['Address', 'Age', 'Annotation', 'Attachment', 'BackboneElement', 'CodeableConcept', 'Coding', 'ContactPoint', 'Count', 'Distance', 'Duration', 'Element', 'ElementDefinition', 'Extension', 'HumanName', 'Identifier', 'Meta', 'Money', 'Narrative', 'Period', 'Quantity', 'Range', 'Ratio', 'Reference', 'SampledData', 'Signature', 'SimpleQuantity', 'Timing', 'base64Binary', 'boolean', 'code', 'date', 'dateTime', 'decimal', 'id', 'instant', 'integer', 'markdown', 'oid', 'positiveInt', 'string', 'time', 'unsignedInt', 'uri', 'uuid', 'xhtml'], 'http://hl7.org/fhir/resource-types'=>['Account', 'AllergyIntolerance', 'Appointment', 'AppointmentResponse', 'AuditEvent', 'Basic', 'Binary', 'BodySite', 'Bundle', 'CarePlan', 'Claim', 'ClaimResponse', 'ClinicalImpression', 'Communication', 'CommunicationRequest', 'Composition', 'ConceptMap', 'Condition', 'Conformance', 'Contract', 'Coverage', 'DataElement', 'DetectedIssue', 'Device', 'DeviceComponent', 'DeviceMetric', 'DeviceUseRequest', 'DeviceUseStatement', 'DiagnosticOrder', 'DiagnosticReport', 'DocumentManifest', 'DocumentReference', 'DomainResource', 'EligibilityRequest', 'EligibilityResponse', 'Encounter', 'EnrollmentRequest', 'EnrollmentResponse', 'EpisodeOfCare', 'ExplanationOfBenefit', 'FamilyMemberHistory', 'Flag', 'Goal', 'Group', 'HealthcareService', 'ImagingObjectSelection', 'ImagingStudy', 'Immunization', 'ImmunizationRecommendation', 'ImplementationGuide', 'List', 'Location', 'Media', 'Medication', 'MedicationAdministration', 'MedicationDispense', 'MedicationOrder', 'MedicationStatement', 'MessageHeader', 'NamingSystem', 'NutritionOrder', 'Observation', 'OperationDefinition', 'OperationOutcome', 'Order', 'OrderResponse', 'Organization', 'Parameters', 'Patient', 'PaymentNotice', 'PaymentReconciliation', 'Person', 'Practitioner', 'Procedure', 'ProcedureRequest', 'ProcessRequest', 'ProcessResponse', 'Provenance', 'Questionnaire', 'QuestionnaireResponse', 'ReferralRequest', 'RelatedPerson', 'Resource', 'RiskAssessment', 'Schedule', 'SearchParameter', 'Slot', 'Specimen', 'StructureDefinition', 'Subscription', 'Substance', 'SupplyDelivery', 'SupplyRequest', 'TestScript', 'ValueSet', 'VisionPrescription']}, 'type'=>'code', 'path'=>'Type.code', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/defined-types'}},
          'profile' => {'type'=>'uri', 'path'=>'Type.profile', 'min'=>0, 'max'=>Float::INFINITY},
          'aggregation' => {'valid_codes'=>{'http://hl7.org/fhir/resource-aggregation-mode'=>['contained', 'referenced', 'bundled']}, 'type'=>'code', 'path'=>'Type.aggregation', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/resource-aggregation-mode'}}
        }

        attr_accessor :id          # 0-1 id
        attr_accessor :extension   # 0-* [ Extension ]
        attr_accessor :code        # 1-1 code
        attr_accessor :profile     # 0-* [ uri ]
        attr_accessor :aggregation # 0-* [ code ]
      end

      class Constraint < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Constraint.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Constraint.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'key' => {'type'=>'id', 'path'=>'Constraint.key', 'min'=>1, 'max'=>1},
          'requirements' => {'type'=>'string', 'path'=>'Constraint.requirements', 'min'=>0, 'max'=>1},
          'severity' => {'valid_codes'=>{'http://hl7.org/fhir/constraint-severity'=>['error', 'warning']}, 'type'=>'code', 'path'=>'Constraint.severity', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/constraint-severity'}},
          'human' => {'type'=>'string', 'path'=>'Constraint.human', 'min'=>1, 'max'=>1},
          'xpath' => {'type'=>'string', 'path'=>'Constraint.xpath', 'min'=>1, 'max'=>1}
        }

        attr_accessor :id           # 0-1 id
        attr_accessor :extension    # 0-* [ Extension ]
        attr_accessor :key          # 1-1 id
        attr_accessor :requirements # 0-1 string
        attr_accessor :severity     # 1-1 code
        attr_accessor :human        # 1-1 string
        attr_accessor :xpath        # 1-1 string
      end

      class Binding < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'valueSet' => ['uri', 'Reference']
        }
        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Binding.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Binding.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'strength' => {'valid_codes'=>{'http://hl7.org/fhir/binding-strength'=>['required', 'extensible', 'preferred', 'example']}, 'type'=>'code', 'path'=>'Binding.strength', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/binding-strength'}},
          'description' => {'type'=>'string', 'path'=>'Binding.description', 'min'=>0, 'max'=>1},
          'valueSetUri' => {'type'=>'uri', 'path'=>'Binding.valueSet[x]', 'min'=>0, 'max'=>1},
          'valueSetReference' => {'type'=>'Reference', 'path'=>'Binding.valueSet[x]', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :strength          # 1-1 code
        attr_accessor :description       # 0-1 string
        attr_accessor :valueSetUri       # 0-1 uri
        attr_accessor :valueSetReference # 0-1 Reference()
      end

      class Mapping < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Mapping.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Mapping.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'identity' => {'type'=>'id', 'path'=>'Mapping.identity', 'min'=>1, 'max'=>1},
          'language' => {'type'=>'code', 'path'=>'Mapping.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://www.rfc-editor.org/bcp/bcp13.txt'}},
          'map' => {'type'=>'string', 'path'=>'Mapping.map', 'min'=>1, 'max'=>1}
        }

        attr_accessor :id        # 0-1 id
        attr_accessor :extension # 0-* [ Extension ]
        attr_accessor :identity  # 1-1 id
        attr_accessor :language  # 0-1 code
        attr_accessor :map       # 1-1 string
      end

      attr_accessor :id                          # 0-1 id
      attr_accessor :extension                   # 0-* [ Extension ]
      attr_accessor :path                        # 1-1 string
      attr_accessor :representation              # 0-* [ code ]
      attr_accessor :name                        # 0-1 string
      attr_accessor :label                       # 0-1 string
      attr_accessor :code                        # 0-* [ Coding ]
      attr_accessor :slicing                     # 0-1 ElementDefinition::Slicing
      attr_accessor :short                       # 0-1 string
      attr_accessor :definition                  # 0-1 markdown
      attr_accessor :comments                    # 0-1 markdown
      attr_accessor :requirements                # 0-1 markdown
      attr_accessor :alias                       # 0-* [ string ]
      attr_accessor :min                         # 0-1 integer
      attr_accessor :max                         # 0-1 string
      attr_accessor :base                        # 0-1 ElementDefinition::Base
      attr_accessor :type                        # 0-* [ ElementDefinition::Type ]
      attr_accessor :nameReference               # 0-1 string
      attr_accessor :defaultValueBoolean         # 0-1 boolean
      attr_accessor :defaultValueInteger         # 0-1 integer
      attr_accessor :defaultValueDecimal         # 0-1 decimal
      attr_accessor :defaultValueBase64Binary    # 0-1 base64Binary
      attr_accessor :defaultValueInstant         # 0-1 instant
      attr_accessor :defaultValueString          # 0-1 string
      attr_accessor :defaultValueUri             # 0-1 uri
      attr_accessor :defaultValueDate            # 0-1 date
      attr_accessor :defaultValueDateTime        # 0-1 dateTime
      attr_accessor :defaultValueTime            # 0-1 time
      attr_accessor :defaultValueCode            # 0-1 code
      attr_accessor :defaultValueOid             # 0-1 oid
      attr_accessor :defaultValueId              # 0-1 id
      attr_accessor :defaultValueUnsignedInt     # 0-1 unsignedInt
      attr_accessor :defaultValuePositiveInt     # 0-1 positiveInt
      attr_accessor :defaultValueMarkdown        # 0-1 markdown
      attr_accessor :defaultValueAnnotation      # 0-1 Annotation
      attr_accessor :defaultValueAttachment      # 0-1 Attachment
      attr_accessor :defaultValueIdentifier      # 0-1 Identifier
      attr_accessor :defaultValueCodeableConcept # 0-1 CodeableConcept
      attr_accessor :defaultValueCoding          # 0-1 Coding
      attr_accessor :defaultValueQuantity        # 0-1 Quantity
      attr_accessor :defaultValueRange           # 0-1 Range
      attr_accessor :defaultValuePeriod          # 0-1 Period
      attr_accessor :defaultValueRatio           # 0-1 Ratio
      attr_accessor :defaultValueSampledData     # 0-1 SampledData
      attr_accessor :defaultValueSignature       # 0-1 Signature
      attr_accessor :defaultValueHumanName       # 0-1 HumanName
      attr_accessor :defaultValueAddress         # 0-1 Address
      attr_accessor :defaultValueContactPoint    # 0-1 ContactPoint
      attr_accessor :defaultValueTiming          # 0-1 Timing
      attr_accessor :defaultValueReference       # 0-1 Reference()
      attr_accessor :defaultValueMeta            # 0-1 Meta
      attr_accessor :meaningWhenMissing          # 0-1 markdown
      attr_accessor :fixedBoolean                # 0-1 boolean
      attr_accessor :fixedInteger                # 0-1 integer
      attr_accessor :fixedDecimal                # 0-1 decimal
      attr_accessor :fixedBase64Binary           # 0-1 base64Binary
      attr_accessor :fixedInstant                # 0-1 instant
      attr_accessor :fixedString                 # 0-1 string
      attr_accessor :fixedUri                    # 0-1 uri
      attr_accessor :fixedDate                   # 0-1 date
      attr_accessor :fixedDateTime               # 0-1 dateTime
      attr_accessor :fixedTime                   # 0-1 time
      attr_accessor :fixedCode                   # 0-1 code
      attr_accessor :fixedOid                    # 0-1 oid
      attr_accessor :fixedId                     # 0-1 id
      attr_accessor :fixedUnsignedInt            # 0-1 unsignedInt
      attr_accessor :fixedPositiveInt            # 0-1 positiveInt
      attr_accessor :fixedMarkdown               # 0-1 markdown
      attr_accessor :fixedAnnotation             # 0-1 Annotation
      attr_accessor :fixedAttachment             # 0-1 Attachment
      attr_accessor :fixedIdentifier             # 0-1 Identifier
      attr_accessor :fixedCodeableConcept        # 0-1 CodeableConcept
      attr_accessor :fixedCoding                 # 0-1 Coding
      attr_accessor :fixedQuantity               # 0-1 Quantity
      attr_accessor :fixedRange                  # 0-1 Range
      attr_accessor :fixedPeriod                 # 0-1 Period
      attr_accessor :fixedRatio                  # 0-1 Ratio
      attr_accessor :fixedSampledData            # 0-1 SampledData
      attr_accessor :fixedSignature              # 0-1 Signature
      attr_accessor :fixedHumanName              # 0-1 HumanName
      attr_accessor :fixedAddress                # 0-1 Address
      attr_accessor :fixedContactPoint           # 0-1 ContactPoint
      attr_accessor :fixedTiming                 # 0-1 Timing
      attr_accessor :fixedReference              # 0-1 Reference()
      attr_accessor :fixedMeta                   # 0-1 Meta
      attr_accessor :patternBoolean              # 0-1 boolean
      attr_accessor :patternInteger              # 0-1 integer
      attr_accessor :patternDecimal              # 0-1 decimal
      attr_accessor :patternBase64Binary         # 0-1 base64Binary
      attr_accessor :patternInstant              # 0-1 instant
      attr_accessor :patternString               # 0-1 string
      attr_accessor :patternUri                  # 0-1 uri
      attr_accessor :patternDate                 # 0-1 date
      attr_accessor :patternDateTime             # 0-1 dateTime
      attr_accessor :patternTime                 # 0-1 time
      attr_accessor :patternCode                 # 0-1 code
      attr_accessor :patternOid                  # 0-1 oid
      attr_accessor :patternId                   # 0-1 id
      attr_accessor :patternUnsignedInt          # 0-1 unsignedInt
      attr_accessor :patternPositiveInt          # 0-1 positiveInt
      attr_accessor :patternMarkdown             # 0-1 markdown
      attr_accessor :patternAnnotation           # 0-1 Annotation
      attr_accessor :patternAttachment           # 0-1 Attachment
      attr_accessor :patternIdentifier           # 0-1 Identifier
      attr_accessor :patternCodeableConcept      # 0-1 CodeableConcept
      attr_accessor :patternCoding               # 0-1 Coding
      attr_accessor :patternQuantity             # 0-1 Quantity
      attr_accessor :patternRange                # 0-1 Range
      attr_accessor :patternPeriod               # 0-1 Period
      attr_accessor :patternRatio                # 0-1 Ratio
      attr_accessor :patternSampledData          # 0-1 SampledData
      attr_accessor :patternSignature            # 0-1 Signature
      attr_accessor :patternHumanName            # 0-1 HumanName
      attr_accessor :patternAddress              # 0-1 Address
      attr_accessor :patternContactPoint         # 0-1 ContactPoint
      attr_accessor :patternTiming               # 0-1 Timing
      attr_accessor :patternReference            # 0-1 Reference()
      attr_accessor :patternMeta                 # 0-1 Meta
      attr_accessor :exampleBoolean              # 0-1 boolean
      attr_accessor :exampleInteger              # 0-1 integer
      attr_accessor :exampleDecimal              # 0-1 decimal
      attr_accessor :exampleBase64Binary         # 0-1 base64Binary
      attr_accessor :exampleInstant              # 0-1 instant
      attr_accessor :exampleString               # 0-1 string
      attr_accessor :exampleUri                  # 0-1 uri
      attr_accessor :exampleDate                 # 0-1 date
      attr_accessor :exampleDateTime             # 0-1 dateTime
      attr_accessor :exampleTime                 # 0-1 time
      attr_accessor :exampleCode                 # 0-1 code
      attr_accessor :exampleOid                  # 0-1 oid
      attr_accessor :exampleId                   # 0-1 id
      attr_accessor :exampleUnsignedInt          # 0-1 unsignedInt
      attr_accessor :examplePositiveInt          # 0-1 positiveInt
      attr_accessor :exampleMarkdown             # 0-1 markdown
      attr_accessor :exampleAnnotation           # 0-1 Annotation
      attr_accessor :exampleAttachment           # 0-1 Attachment
      attr_accessor :exampleIdentifier           # 0-1 Identifier
      attr_accessor :exampleCodeableConcept      # 0-1 CodeableConcept
      attr_accessor :exampleCoding               # 0-1 Coding
      attr_accessor :exampleQuantity             # 0-1 Quantity
      attr_accessor :exampleRange                # 0-1 Range
      attr_accessor :examplePeriod               # 0-1 Period
      attr_accessor :exampleRatio                # 0-1 Ratio
      attr_accessor :exampleSampledData          # 0-1 SampledData
      attr_accessor :exampleSignature            # 0-1 Signature
      attr_accessor :exampleHumanName            # 0-1 HumanName
      attr_accessor :exampleAddress              # 0-1 Address
      attr_accessor :exampleContactPoint         # 0-1 ContactPoint
      attr_accessor :exampleTiming               # 0-1 Timing
      attr_accessor :exampleReference            # 0-1 Reference()
      attr_accessor :exampleMeta                 # 0-1 Meta
      attr_accessor :minValueBoolean             # 0-1 boolean
      attr_accessor :minValueInteger             # 0-1 integer
      attr_accessor :minValueDecimal             # 0-1 decimal
      attr_accessor :minValueBase64Binary        # 0-1 base64Binary
      attr_accessor :minValueInstant             # 0-1 instant
      attr_accessor :minValueString              # 0-1 string
      attr_accessor :minValueUri                 # 0-1 uri
      attr_accessor :minValueDate                # 0-1 date
      attr_accessor :minValueDateTime            # 0-1 dateTime
      attr_accessor :minValueTime                # 0-1 time
      attr_accessor :minValueCode                # 0-1 code
      attr_accessor :minValueOid                 # 0-1 oid
      attr_accessor :minValueId                  # 0-1 id
      attr_accessor :minValueUnsignedInt         # 0-1 unsignedInt
      attr_accessor :minValuePositiveInt         # 0-1 positiveInt
      attr_accessor :minValueMarkdown            # 0-1 markdown
      attr_accessor :minValueAnnotation          # 0-1 Annotation
      attr_accessor :minValueAttachment          # 0-1 Attachment
      attr_accessor :minValueIdentifier          # 0-1 Identifier
      attr_accessor :minValueCodeableConcept     # 0-1 CodeableConcept
      attr_accessor :minValueCoding              # 0-1 Coding
      attr_accessor :minValueQuantity            # 0-1 Quantity
      attr_accessor :minValueRange               # 0-1 Range
      attr_accessor :minValuePeriod              # 0-1 Period
      attr_accessor :minValueRatio               # 0-1 Ratio
      attr_accessor :minValueSampledData         # 0-1 SampledData
      attr_accessor :minValueSignature           # 0-1 Signature
      attr_accessor :minValueHumanName           # 0-1 HumanName
      attr_accessor :minValueAddress             # 0-1 Address
      attr_accessor :minValueContactPoint        # 0-1 ContactPoint
      attr_accessor :minValueTiming              # 0-1 Timing
      attr_accessor :minValueReference           # 0-1 Reference()
      attr_accessor :minValueMeta                # 0-1 Meta
      attr_accessor :maxValueBoolean             # 0-1 boolean
      attr_accessor :maxValueInteger             # 0-1 integer
      attr_accessor :maxValueDecimal             # 0-1 decimal
      attr_accessor :maxValueBase64Binary        # 0-1 base64Binary
      attr_accessor :maxValueInstant             # 0-1 instant
      attr_accessor :maxValueString              # 0-1 string
      attr_accessor :maxValueUri                 # 0-1 uri
      attr_accessor :maxValueDate                # 0-1 date
      attr_accessor :maxValueDateTime            # 0-1 dateTime
      attr_accessor :maxValueTime                # 0-1 time
      attr_accessor :maxValueCode                # 0-1 code
      attr_accessor :maxValueOid                 # 0-1 oid
      attr_accessor :maxValueId                  # 0-1 id
      attr_accessor :maxValueUnsignedInt         # 0-1 unsignedInt
      attr_accessor :maxValuePositiveInt         # 0-1 positiveInt
      attr_accessor :maxValueMarkdown            # 0-1 markdown
      attr_accessor :maxValueAnnotation          # 0-1 Annotation
      attr_accessor :maxValueAttachment          # 0-1 Attachment
      attr_accessor :maxValueIdentifier          # 0-1 Identifier
      attr_accessor :maxValueCodeableConcept     # 0-1 CodeableConcept
      attr_accessor :maxValueCoding              # 0-1 Coding
      attr_accessor :maxValueQuantity            # 0-1 Quantity
      attr_accessor :maxValueRange               # 0-1 Range
      attr_accessor :maxValuePeriod              # 0-1 Period
      attr_accessor :maxValueRatio               # 0-1 Ratio
      attr_accessor :maxValueSampledData         # 0-1 SampledData
      attr_accessor :maxValueSignature           # 0-1 Signature
      attr_accessor :maxValueHumanName           # 0-1 HumanName
      attr_accessor :maxValueAddress             # 0-1 Address
      attr_accessor :maxValueContactPoint        # 0-1 ContactPoint
      attr_accessor :maxValueTiming              # 0-1 Timing
      attr_accessor :maxValueReference           # 0-1 Reference()
      attr_accessor :maxValueMeta                # 0-1 Meta
      attr_accessor :maxLength                   # 0-1 integer
      attr_accessor :condition                   # 0-* [ id ]
      attr_accessor :constraint                  # 0-* [ ElementDefinition::Constraint ]
      attr_accessor :mustSupport                 # 0-1 boolean
      attr_accessor :isModifier                  # 0-1 boolean
      attr_accessor :isSummary                   # 0-1 boolean
      attr_accessor :binding                     # 0-1 ElementDefinition::Binding
      attr_accessor :mapping                     # 0-* [ ElementDefinition::Mapping ]
    end
  end
end
