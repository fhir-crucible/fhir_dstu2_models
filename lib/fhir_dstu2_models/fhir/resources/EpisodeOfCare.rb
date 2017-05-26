module FHIR
  module DSTU2
    class EpisodeOfCare < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['care-manager', 'condition', 'date', 'identifier', 'incomingreferral', 'organization', 'patient', 'status', 'team-member', 'type']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'EpisodeOfCare.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'EpisodeOfCare.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'EpisodeOfCare.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'EpisodeOfCare.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'EpisodeOfCare.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'EpisodeOfCare.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'EpisodeOfCare.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'EpisodeOfCare.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'EpisodeOfCare.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'status' => {'valid_codes'=>{'http://hl7.org/fhir/episode-of-care-status'=>['planned', 'waitlist', 'active', 'onhold', 'finished', 'cancelled']}, 'type'=>'code', 'path'=>'EpisodeOfCare.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/episode-of-care-status'}},
        'statusHistory' => {'type'=>'EpisodeOfCare::StatusHistory', 'path'=>'EpisodeOfCare.statusHistory', 'min'=>0, 'max'=>Float::INFINITY},
        'type' => {'type'=>'CodeableConcept', 'path'=>'EpisodeOfCare.type', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
        'condition' => {'type'=>'Reference', 'path'=>'EpisodeOfCare.condition', 'min'=>0, 'max'=>Float::INFINITY},
        'patient' => {'type'=>'Reference', 'path'=>'EpisodeOfCare.patient', 'min'=>1, 'max'=>1},
        'managingOrganization' => {'type'=>'Reference', 'path'=>'EpisodeOfCare.managingOrganization', 'min'=>0, 'max'=>1},
        'period' => {'type'=>'Period', 'path'=>'EpisodeOfCare.period', 'min'=>0, 'max'=>1},
        'referralRequest' => {'type'=>'Reference', 'path'=>'EpisodeOfCare.referralRequest', 'min'=>0, 'max'=>Float::INFINITY},
        'careManager' => {'type'=>'Reference', 'path'=>'EpisodeOfCare.careManager', 'min'=>0, 'max'=>1},
        'careTeam' => {'type'=>'EpisodeOfCare::CareTeam', 'path'=>'EpisodeOfCare.careTeam', 'min'=>0, 'max'=>Float::INFINITY}
      }

      class StatusHistory < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'StatusHistory.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'StatusHistory.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'StatusHistory.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'status' => {'valid_codes'=>{'http://hl7.org/fhir/episode-of-care-status'=>['planned', 'waitlist', 'active', 'onhold', 'finished', 'cancelled']}, 'type'=>'code', 'path'=>'StatusHistory.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/episode-of-care-status'}},
          'period' => {'type'=>'Period', 'path'=>'StatusHistory.period', 'min'=>1, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :status            # 1-1 code
        attr_accessor :period            # 1-1 Period
      end

      class CareTeam < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'CareTeam.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'CareTeam.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'CareTeam.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'role' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'CareTeam.role', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/participant-role'}},
          'period' => {'type'=>'Period', 'path'=>'CareTeam.period', 'min'=>0, 'max'=>1},
          'member' => {'type'=>'Reference', 'path'=>'CareTeam.member', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :role              # 0-* [ CodeableConcept ]
        attr_accessor :period            # 0-1 Period
        attr_accessor :member            # 0-1 Reference()
      end

      attr_accessor :id                   # 0-1 id
      attr_accessor :meta                 # 0-1 Meta
      attr_accessor :implicitRules        # 0-1 uri
      attr_accessor :language             # 0-1 code
      attr_accessor :text                 # 0-1 Narrative
      attr_accessor :contained            # 0-* [ Resource ]
      attr_accessor :extension            # 0-* [ Extension ]
      attr_accessor :modifierExtension    # 0-* [ Extension ]
      attr_accessor :identifier           # 0-* [ Identifier ]
      attr_accessor :status               # 1-1 code
      attr_accessor :statusHistory        # 0-* [ EpisodeOfCare::StatusHistory ]
      attr_accessor :type                 # 0-* [ CodeableConcept ]
      attr_accessor :condition            # 0-* [ Reference() ]
      attr_accessor :patient              # 1-1 Reference()
      attr_accessor :managingOrganization # 0-1 Reference()
      attr_accessor :period               # 0-1 Period
      attr_accessor :referralRequest      # 0-* [ Reference() ]
      attr_accessor :careManager          # 0-1 Reference()
      attr_accessor :careTeam             # 0-* [ EpisodeOfCare::CareTeam ]

      def resourceType
        'EpisodeOfCare'
      end
    end
  end
end