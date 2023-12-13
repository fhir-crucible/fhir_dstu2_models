module FHIR
  module DSTU2
    class Encounter < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['appointment', 'condition', 'date', 'episodeofcare', 'identifier', 'incomingreferral', 'indication', 'length', 'location', 'location-period', 'part-of', 'participant', 'participant-type', 'patient', 'practitioner', 'procedure', 'reason', 'special-arrangement', 'status', 'type']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Encounter.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'Encounter.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'Encounter.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'Encounter.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'Encounter.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'Encounter.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'Encounter.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Encounter.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'Encounter.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/encounter-state'=>['planned', 'arrived', 'in-progress', 'onleave', 'finished', 'cancelled']}, 'type'=>'code', 'path'=>'Encounter.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/encounter-state'}},
        'statusHistory' => {'type'=>'Encounter::StatusHistory', 'path'=>'Encounter.statusHistory', 'min'=>0, 'max'=>Float::INFINITY},
        'class' => {'local_name'=>'local_class', 'valid_codes'=>{'http://hl7.org/fhir/encounter-class'=>['inpatient', 'outpatient', 'ambulatory', 'emergency', 'home', 'field', 'daytime', 'virtual', 'other']}, 'type'=>'code', 'path'=>'Encounter.class', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/encounter-class'}},
        'type' => {'valid_codes'=>{'http://hl7.org/fhir/encounter-type'=>['ADMS', 'BD/BM-clin', 'CCS60', 'OKI']}, 'type'=>'CodeableConcept', 'path'=>'Encounter.type', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/encounter-type'}},
        'priority' => {'valid_codes'=>{'http://hl7.org/fhir/encounter-priority'=>['imm', 'emg', 'urg', 's-urg', 'no-urg']}, 'type'=>'CodeableConcept', 'path'=>'Encounter.priority', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/encounter-priority'}},
        'patient' => {'type'=>'Reference', 'path'=>'Encounter.patient', 'min'=>0, 'max'=>1},
        'episodeOfCare' => {'type'=>'Reference', 'path'=>'Encounter.episodeOfCare', 'min'=>0, 'max'=>Float::INFINITY},
        'incomingReferral' => {'type'=>'Reference', 'path'=>'Encounter.incomingReferral', 'min'=>0, 'max'=>Float::INFINITY},
        'participant' => {'type'=>'Encounter::Participant', 'path'=>'Encounter.participant', 'min'=>0, 'max'=>Float::INFINITY},
        'appointment' => {'type'=>'Reference', 'path'=>'Encounter.appointment', 'min'=>0, 'max'=>1},
        'period' => {'type'=>'Period', 'path'=>'Encounter.period', 'min'=>0, 'max'=>1},
        'length' => {'type'=>'Quantity', 'path'=>'Encounter.length', 'min'=>0, 'max'=>1},
        'reason' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Encounter.reason', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/encounter-reason'}},
        'indication' => {'type'=>'Reference', 'path'=>'Encounter.indication', 'min'=>0, 'max'=>Float::INFINITY},
        'hospitalization' => {'type'=>'Encounter::Hospitalization', 'path'=>'Encounter.hospitalization', 'min'=>0, 'max'=>1},
        'location' => {'type'=>'Encounter::Location', 'path'=>'Encounter.location', 'min'=>0, 'max'=>Float::INFINITY},
        'serviceProvider' => {'type'=>'Reference', 'path'=>'Encounter.serviceProvider', 'min'=>0, 'max'=>1},
        'partOf' => {'type'=>'Reference', 'path'=>'Encounter.partOf', 'min'=>0, 'max'=>1}
      }

      class StatusHistory < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'StatusHistory.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'StatusHistory.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'StatusHistory.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'status' => {'valid_codes'=>{'http://hl7.org/fhir/encounter-state'=>['planned', 'arrived', 'in-progress', 'onleave', 'finished', 'cancelled']}, 'type'=>'code', 'path'=>'StatusHistory.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/encounter-state'}},
          'period' => {'type'=>'Period', 'path'=>'StatusHistory.period', 'min'=>1, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :status            # 1-1 code
        attr_accessor :period            # 1-1 Period
      end

      class Participant < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Participant.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Participant.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Participant.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'type' => {'valid_codes'=>{'http://hl7.org/fhir/participant-type'=>['translator', 'emergency'], 'http://hl7.org/fhir/v3/ParticipationType'=>['PART', 'ADM', 'ATND', 'CALLBCK', 'CON', 'DIS', 'ESC', 'REF', '_ParticipationInformationGenerator', 'AUT', 'INF', 'TRANS', 'ENT', 'WIT', 'CST', 'DIR', 'ALY', 'BBY', 'CAT', 'CSM', 'TPA', 'DEV', 'NRD', 'RDV', 'DON', 'EXPAGNT', 'EXPART', 'EXPTRGT', 'EXSRC', 'PRD', 'SBJ', 'SPC', 'IND', 'BEN', 'CAGNT', 'COV', 'GUAR', 'HLD', 'RCT', 'RCV', 'IRCP', 'NOT', 'PRCP', 'REFB', 'REFT', 'TRC', 'LOC', 'DST', 'ELOC', 'ORG', 'RML', 'VIA', 'PRF', 'DIST', 'PPRF', 'SPRF', 'RESP', 'VRF', 'AUTHEN', 'LA']}, 'type'=>'CodeableConcept', 'path'=>'Participant.type', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/encounter-participant-type'}},
          'period' => {'type'=>'Period', 'path'=>'Participant.period', 'min'=>0, 'max'=>1},
          'individual' => {'type'=>'Reference', 'path'=>'Participant.individual', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :type              # 0-* [ CodeableConcept ]
        attr_accessor :period            # 0-1 Period
        attr_accessor :individual        # 0-1 Reference()
      end

      class Hospitalization < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Hospitalization.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Hospitalization.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Hospitalization.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'preAdmissionIdentifier' => {'type'=>'Identifier', 'path'=>'Hospitalization.preAdmissionIdentifier', 'min'=>0, 'max'=>1},
          'origin' => {'type'=>'Reference', 'path'=>'Hospitalization.origin', 'min'=>0, 'max'=>1},
          'admitSource' => {'valid_codes'=>{'http://hl7.org/fhir/admit-source'=>['hosp-trans', 'emd', 'outp', 'born', 'gp', 'mp', 'nursing', 'psych', 'rehab', 'other']}, 'type'=>'CodeableConcept', 'path'=>'Hospitalization.admitSource', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'preferred', 'uri'=>'http://hl7.org/fhir/ValueSet/encounter-admit-source'}},
          'admittingDiagnosis' => {'type'=>'Reference', 'path'=>'Hospitalization.admittingDiagnosis', 'min'=>0, 'max'=>Float::INFINITY},
          'reAdmission' => {'type'=>'CodeableConcept', 'path'=>'Hospitalization.reAdmission', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
          'dietPreference' => {'valid_codes'=>{'http://hl7.org/fhir/diet'=>['vegetarian', 'dairy-free', 'nut-free', 'gluten-free', 'vegan', 'halal', 'kosher']}, 'type'=>'CodeableConcept', 'path'=>'Hospitalization.dietPreference', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/encounter-diet'}},
          'specialCourtesy' => {'valid_codes'=>{'http://hl7.org/fhir/v3/EncounterSpecialCourtesy'=>['EXT', 'NRM', 'PRF', 'STF', 'VIP'], 'http://hl7.org/fhir/v3/NullFlavor'=>['NI', 'INV', 'DER', 'OTH', 'NINF', 'PINF', 'UNC', 'MSK', 'NA', 'UNK', 'ASKU', 'NAV', 'NASK', 'QS', 'TRC', 'NP']}, 'type'=>'CodeableConcept', 'path'=>'Hospitalization.specialCourtesy', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'preferred', 'uri'=>'http://hl7.org/fhir/ValueSet/encounter-special-courtesy'}},
          'specialArrangement' => {'valid_codes'=>{'http://hl7.org/fhir/encounter-special-arrangements'=>['wheel', 'stret', 'int', 'att', 'dog']}, 'type'=>'CodeableConcept', 'path'=>'Hospitalization.specialArrangement', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'preferred', 'uri'=>'http://hl7.org/fhir/ValueSet/encounter-special-arrangements'}},
          'destination' => {'type'=>'Reference', 'path'=>'Hospitalization.destination', 'min'=>0, 'max'=>1},
          'dischargeDisposition' => {'valid_codes'=>{'http://hl7.org/fhir/discharge-disposition'=>['home', 'other-hcf', 'hosp', 'long', 'aadvice', 'exp', 'psy', 'rehab', 'oth']}, 'type'=>'CodeableConcept', 'path'=>'Hospitalization.dischargeDisposition', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'preferred', 'uri'=>'http://hl7.org/fhir/ValueSet/encounter-discharge-disposition'}},
          'dischargeDiagnosis' => {'type'=>'Reference', 'path'=>'Hospitalization.dischargeDiagnosis', 'min'=>0, 'max'=>Float::INFINITY}
        }

        attr_accessor :id                     # 0-1 id
        attr_accessor :extension              # 0-* [ Extension ]
        attr_accessor :modifierExtension      # 0-* [ Extension ]
        attr_accessor :preAdmissionIdentifier # 0-1 Identifier
        attr_accessor :origin                 # 0-1 Reference()
        attr_accessor :admitSource            # 0-1 CodeableConcept
        attr_accessor :admittingDiagnosis     # 0-* [ Reference() ]
        attr_accessor :reAdmission            # 0-1 CodeableConcept
        attr_accessor :dietPreference         # 0-* [ CodeableConcept ]
        attr_accessor :specialCourtesy        # 0-* [ CodeableConcept ]
        attr_accessor :specialArrangement     # 0-* [ CodeableConcept ]
        attr_accessor :destination            # 0-1 Reference()
        attr_accessor :dischargeDisposition   # 0-1 CodeableConcept
        attr_accessor :dischargeDiagnosis     # 0-* [ Reference() ]
      end

      class Location < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Location.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Location.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Location.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'location' => {'type'=>'Reference', 'path'=>'Location.location', 'min'=>1, 'max'=>1},
          'status' => {'valid_codes'=>{'http://hl7.org/fhir/encounter-location-status'=>['planned', 'active', 'reserved', 'completed']}, 'type'=>'code', 'path'=>'Location.status', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/encounter-location-status'}},
          'period' => {'type'=>'Period', 'path'=>'Location.period', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :location          # 1-1 Reference()
        attr_accessor :status            # 0-1 code
        attr_accessor :period            # 0-1 Period
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
      attr_accessor :status            # 1-1 code
      attr_accessor :statusHistory     # 0-* [ Encounter::StatusHistory ]
      attr_accessor :local_class       # 0-1 code
      attr_accessor :type              # 0-* [ CodeableConcept ]
      attr_accessor :priority          # 0-1 CodeableConcept
      attr_accessor :patient           # 0-1 Reference()
      attr_accessor :episodeOfCare     # 0-* [ Reference() ]
      attr_accessor :incomingReferral  # 0-* [ Reference() ]
      attr_accessor :participant       # 0-* [ Encounter::Participant ]
      attr_accessor :appointment       # 0-1 Reference()
      attr_accessor :period            # 0-1 Period
      attr_accessor :length            # 0-1 Quantity
      attr_accessor :reason            # 0-* [ CodeableConcept ]
      attr_accessor :indication        # 0-* [ Reference() ]
      attr_accessor :hospitalization   # 0-1 Encounter::Hospitalization
      attr_accessor :location          # 0-* [ Encounter::Location ]
      attr_accessor :serviceProvider   # 0-1 Reference()
      attr_accessor :partOf            # 0-1 Reference()

      def resourceType
        'Encounter'
      end
    end
  end
end
