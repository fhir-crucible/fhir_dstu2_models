module FHIR
  module DSTU2
    class DeviceMetric < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['category', 'identifier', 'parent', 'source', 'type']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'DeviceMetric.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'DeviceMetric.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'DeviceMetric.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'DeviceMetric.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'DeviceMetric.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'DeviceMetric.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'DeviceMetric.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'DeviceMetric.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'type' => {'type'=>'CodeableConcept', 'path'=>'DeviceMetric.type', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'preferred', 'uri'=>'https://rtmms.nist.gov/rtmms/index.htm#!hrosetta'}},
        'identifier' => {'type'=>'Identifier', 'path'=>'DeviceMetric.identifier', 'min'=>1, 'max'=>1},
        'unit' => {'type'=>'CodeableConcept', 'path'=>'DeviceMetric.unit', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'preferred', 'uri'=>'https://rtmms.nist.gov/rtmms/index.htm#!units'}},
        'source' => {'type'=>'Reference', 'path'=>'DeviceMetric.source', 'min'=>0, 'max'=>1},
        'parent' => {'type'=>'Reference', 'path'=>'DeviceMetric.parent', 'min'=>0, 'max'=>1},
        'operationalStatus' => {'valid_codes'=>{'http://hl7.org/fhir/metric-operational-status'=>['on', 'off', 'standby']}, 'type'=>'code', 'path'=>'DeviceMetric.operationalStatus', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/metric-operational-status'}},
        'color' => {'valid_codes'=>{'http://hl7.org/fhir/metric-color'=>['black', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white']}, 'type'=>'code', 'path'=>'DeviceMetric.color', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/metric-color'}},
        'category' => {'valid_codes'=>{'http://hl7.org/fhir/metric-category'=>['measurement', 'setting', 'calculation', 'unspecified']}, 'type'=>'code', 'path'=>'DeviceMetric.category', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/metric-category'}},
        'measurementPeriod' => {'type'=>'Timing', 'path'=>'DeviceMetric.measurementPeriod', 'min'=>0, 'max'=>1},
        'calibration' => {'type'=>'DeviceMetric::Calibration', 'path'=>'DeviceMetric.calibration', 'min'=>0, 'max'=>Float::INFINITY}
      }

      class Calibration < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Calibration.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Calibration.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Calibration.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'type' => {'valid_codes'=>{'http://hl7.org/fhir/metric-calibration-type'=>['unspecified', 'offset', 'gain', 'two-point']}, 'type'=>'code', 'path'=>'Calibration.type', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/metric-calibration-type'}},
          'state' => {'valid_codes'=>{'http://hl7.org/fhir/metric-calibration-state'=>['not-calibrated', 'calibration-required', 'calibrated', 'unspecified']}, 'type'=>'code', 'path'=>'Calibration.state', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/metric-calibration-state'}},
          'time' => {'type'=>'instant', 'path'=>'Calibration.time', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :type              # 0-1 code
        attr_accessor :state             # 0-1 code
        attr_accessor :time              # 0-1 instant
      end

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :type              # 1-1 CodeableConcept
      attr_accessor :identifier        # 1-1 Identifier
      attr_accessor :unit              # 0-1 CodeableConcept
      attr_accessor :source            # 0-1 Reference()
      attr_accessor :parent            # 0-1 Reference()
      attr_accessor :operationalStatus # 0-1 code
      attr_accessor :color             # 0-1 code
      attr_accessor :category          # 1-1 code
      attr_accessor :measurementPeriod # 0-1 Timing
      attr_accessor :calibration       # 0-* [ DeviceMetric::Calibration ]

      def resourceType
        'DeviceMetric'
      end
    end
  end
end