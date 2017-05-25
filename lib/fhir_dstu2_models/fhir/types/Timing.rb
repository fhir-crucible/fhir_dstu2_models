module FHIR
  module DSTU2
    class Timing < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = 
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Timing.id', 'min'=>0, 'max'=>1},
        'extension' => {'type'=>'Extension', 'path'=>'Timing.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'event' => {'type'=>'dateTime', 'path'=>'Timing.event', 'min'=>0, 'max'=>Float::INFINITY},
        'repeat' => {'type'=>'Timing::Repeat', 'path'=>'Timing.repeat', 'min'=>0, 'max'=>1},
        'code' => {'valid_codes'=>{'http://hl7.org/fhir/timing-abbreviation'=>['QD', 'QOD', 'Q4H', 'Q6H'], 'http://hl7.org/fhir/v3/GTSAbbreviation'=>['AM', 'BID', 'JB', 'JE', 'JH', '_GTSAbbreviationHolidaysChristianRoman', 'JHCHREAS', 'JHCHRGFR', 'JHCHRNEW', 'JHCHRPEN', 'JHCHRXME', 'JHCHRXMS', 'JHNNL', 'JHNNLLD', 'JHNNLQD', 'JHNNLSK', 'JHNUS', 'JHNUSCLM', 'JHNUSIND', 'JHNUSIND1', 'JHNUSIND5', 'JHNUSLBR', 'JHNUSMEM', 'JHNUSMEM5', 'JHNUSMEM6', 'JHNUSMLK', 'JHNUSPRE', 'JHNUSTKS', 'JHNUSTKS5', 'JHNUSVET', 'PM', 'QID', 'TID']}, 'type'=>'CodeableConcept', 'path'=>'Timing.code', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'preferred', 'uri'=>'http://hl7.org/fhir/ValueSet/timing-abbreviation'}}
      }

      class Repeat < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'bounds' => ['Quantity', 'Range', 'Period']
        }
        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Repeat.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Repeat.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'boundsQuantity' => {'type'=>'Quantity', 'path'=>'Repeat.bounds[x]', 'min'=>0, 'max'=>1},
          'boundsRange' => {'type'=>'Range', 'path'=>'Repeat.bounds[x]', 'min'=>0, 'max'=>1},
          'boundsPeriod' => {'type'=>'Period', 'path'=>'Repeat.bounds[x]', 'min'=>0, 'max'=>1},
          'count' => {'type'=>'integer', 'path'=>'Repeat.count', 'min'=>0, 'max'=>1},
          'duration' => {'type'=>'decimal', 'path'=>'Repeat.duration', 'min'=>0, 'max'=>1},
          'durationMax' => {'type'=>'decimal', 'path'=>'Repeat.durationMax', 'min'=>0, 'max'=>1},
          'durationUnits' => {'valid_codes'=>{'http://unitsofmeasure.org'=>['s', 'min', 'h', 'd', 'wk', 'mo', 'a']}, 'type'=>'code', 'path'=>'Repeat.durationUnits', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/units-of-time'}},
          'frequency' => {'type'=>'integer', 'path'=>'Repeat.frequency', 'min'=>0, 'max'=>1},
          'frequencyMax' => {'type'=>'integer', 'path'=>'Repeat.frequencyMax', 'min'=>0, 'max'=>1},
          'period' => {'type'=>'decimal', 'path'=>'Repeat.period', 'min'=>0, 'max'=>1},
          'periodMax' => {'type'=>'decimal', 'path'=>'Repeat.periodMax', 'min'=>0, 'max'=>1},
          'periodUnits' => {'valid_codes'=>{'http://unitsofmeasure.org'=>['s', 'min', 'h', 'd', 'wk', 'mo', 'a']}, 'type'=>'code', 'path'=>'Repeat.periodUnits', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/units-of-time'}},
          'when' => {'valid_codes'=>{'http://hl7.org/fhir/v3/TimingEvent'=>['AC', 'ACD', 'ACM', 'ACV', 'C', 'CD', 'CM', 'CV', 'HS', 'IC', 'ICD', 'ICM', 'ICV', 'PC', 'PCD', 'PCM', 'PCV', 'WAKE']}, 'type'=>'code', 'path'=>'Repeat.when', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/event-timing'}}
        }

        attr_accessor :id             # 0-1 id
        attr_accessor :extension      # 0-* [ Extension ]
        attr_accessor :boundsQuantity # 0-1 Quantity
        attr_accessor :boundsRange    # 0-1 Range
        attr_accessor :boundsPeriod   # 0-1 Period
        attr_accessor :count          # 0-1 integer
        attr_accessor :duration       # 0-1 decimal
        attr_accessor :durationMax    # 0-1 decimal
        attr_accessor :durationUnits  # 0-1 code
        attr_accessor :frequency      # 0-1 integer
        attr_accessor :frequencyMax   # 0-1 integer
        attr_accessor :period         # 0-1 decimal
        attr_accessor :periodMax      # 0-1 decimal
        attr_accessor :periodUnits    # 0-1 code
        attr_accessor :when           # 0-1 code
      end

      attr_accessor :id        # 0-1 id
      attr_accessor :extension # 0-* [ Extension ]
      attr_accessor :event     # 0-* [ dateTime ]
      attr_accessor :repeat    # 0-1 Timing::Repeat
      attr_accessor :code      # 0-1 CodeableConcept
    end
  end
end