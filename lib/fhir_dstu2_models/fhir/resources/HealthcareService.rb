module FHIR
  module DSTU2
    class HealthcareService < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['characteristic', 'identifier', 'location', 'name', 'organization', 'programname', 'servicecategory', 'servicetype']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'HealthcareService.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'HealthcareService.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'HealthcareService.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'HealthcareService.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'HealthcareService.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'HealthcareService.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'HealthcareService.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'HealthcareService.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'HealthcareService.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'providedBy' => {'type'=>'Reference', 'path'=>'HealthcareService.providedBy', 'min'=>0, 'max'=>1},
        'serviceCategory' => {'type'=>'CodeableConcept', 'path'=>'HealthcareService.serviceCategory', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
        'serviceType' => {'type'=>'HealthcareService::ServiceType', 'path'=>'HealthcareService.serviceType', 'min'=>0, 'max'=>Float::INFINITY},
        'location' => {'type'=>'Reference', 'path'=>'HealthcareService.location', 'min'=>1, 'max'=>1},
        'serviceName' => {'type'=>'string', 'path'=>'HealthcareService.serviceName', 'min'=>0, 'max'=>1},
        'comment' => {'type'=>'string', 'path'=>'HealthcareService.comment', 'min'=>0, 'max'=>1},
        'extraDetails' => {'type'=>'string', 'path'=>'HealthcareService.extraDetails', 'min'=>0, 'max'=>1},
        'photo' => {'type'=>'Attachment', 'path'=>'HealthcareService.photo', 'min'=>0, 'max'=>1},
        'telecom' => {'type'=>'ContactPoint', 'path'=>'HealthcareService.telecom', 'min'=>0, 'max'=>Float::INFINITY},
        'coverageArea' => {'type'=>'Reference', 'path'=>'HealthcareService.coverageArea', 'min'=>0, 'max'=>Float::INFINITY},
        'serviceProvisionCode' => {'valid_codes'=>{'http://hl7.org/fhir/service-provision-conditions'=>['free', 'disc', 'cost']}, 'type'=>'CodeableConcept', 'path'=>'HealthcareService.serviceProvisionCode', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/service-provision-conditions'}},
        'eligibility' => {'type'=>'CodeableConcept', 'path'=>'HealthcareService.eligibility', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
        'eligibilityNote' => {'type'=>'string', 'path'=>'HealthcareService.eligibilityNote', 'min'=>0, 'max'=>1},
        'programName' => {'type'=>'string', 'path'=>'HealthcareService.programName', 'min'=>0, 'max'=>Float::INFINITY},
        'characteristic' => {'type'=>'CodeableConcept', 'path'=>'HealthcareService.characteristic', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>nil}},
        'referralMethod' => {'valid_codes'=>{'http://hl7.org/fhir/service-referral-method'=>['fax', 'phone', 'elec', 'semail', 'mail']}, 'type'=>'CodeableConcept', 'path'=>'HealthcareService.referralMethod', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/service-referral-method'}},
        'publicKey' => {'type'=>'string', 'path'=>'HealthcareService.publicKey', 'min'=>0, 'max'=>1},
        'appointmentRequired' => {'type'=>'boolean', 'path'=>'HealthcareService.appointmentRequired', 'min'=>0, 'max'=>1},
        'availableTime' => {'type'=>'HealthcareService::AvailableTime', 'path'=>'HealthcareService.availableTime', 'min'=>0, 'max'=>Float::INFINITY},
        'notAvailable' => {'type'=>'HealthcareService::NotAvailable', 'path'=>'HealthcareService.notAvailable', 'min'=>0, 'max'=>Float::INFINITY},
        'availabilityExceptions' => {'type'=>'string', 'path'=>'HealthcareService.availabilityExceptions', 'min'=>0, 'max'=>1}
      }

      class ServiceType < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'ServiceType.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'ServiceType.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'ServiceType.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'type' => {'valid_codes'=>{'http://snomed.info/sct'=>['408467006', '394577000', '394578005', '421661004', '408462000', '394579002', '394804000', '394580004', '394803006', '408480009', '408454008', '394809005', '394592004', '394600006', '394601005', '394581000', '408478003', '394812008', '408444009', '394582007', '408475000', '410005002', '394583002', '419772000', '394584008', '408443003', '394802001', '394915009', '394814009', '394808002', '394811001', '408446006', '394586005', '394916005', '408472002', '394597005', '394598000', '394807007', '419192003', '408468001', '394593009', '394813003', '410001006', '394589003', '394591006', '394599008', '394649004', '408470005', '394585009', '394821009', '422191005', '394594003', '416304004', '418960008', '394882004', '394806003', '394588006', '408459003', '394607009', '419610006', '418058008', '420208008', '418652005', '418535003', '418862001', '419365004', '418002000', '419983000', '419170002', '419472004', '394539006', '420112009', '409968004', '394587001', '394913002', '408440000', '418112009', '419815003', '394914008', '408455009', '394602003', '408447002', '394810000', '408450004', '408476004', '408469009', '408466002', '408471009', '408464004', '408441001', '408465003', '394605001', '394608004', '408461007', '408460008', '394606000', '408449004', '418018006', '394604002', '394609007', '408474001', '394610002', '394611003', '408477008', '394801008', '408463005', '419321007', '394576009', '394590007', '409967009', '408448007', '419043006', '394612005', '394733009', '394732004']}, 'type'=>'CodeableConcept', 'path'=>'ServiceType.type', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'preferred', 'uri'=>'http://hl7.org/fhir/ValueSet/c80-practice-codes'}},
          'specialty' => {'type'=>'CodeableConcept', 'path'=>'ServiceType.specialty', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>nil}}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :type              # 1-1 CodeableConcept
        attr_accessor :specialty         # 0-* [ CodeableConcept ]
      end

      class AvailableTime < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'AvailableTime.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'AvailableTime.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'AvailableTime.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'daysOfWeek' => {'valid_codes'=>{'http://hl7.org/fhir/days-of-week'=>['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']}, 'type'=>'code', 'path'=>'AvailableTime.daysOfWeek', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/days-of-week'}},
          'allDay' => {'type'=>'boolean', 'path'=>'AvailableTime.allDay', 'min'=>0, 'max'=>1},
          'availableStartTime' => {'type'=>'time', 'path'=>'AvailableTime.availableStartTime', 'min'=>0, 'max'=>1},
          'availableEndTime' => {'type'=>'time', 'path'=>'AvailableTime.availableEndTime', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                 # 0-1 id
        attr_accessor :extension          # 0-* [ Extension ]
        attr_accessor :modifierExtension  # 0-* [ Extension ]
        attr_accessor :daysOfWeek         # 0-* [ code ]
        attr_accessor :allDay             # 0-1 boolean
        attr_accessor :availableStartTime # 0-1 time
        attr_accessor :availableEndTime   # 0-1 time
      end

      class NotAvailable < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'NotAvailable.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'NotAvailable.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'NotAvailable.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'description' => {'type'=>'string', 'path'=>'NotAvailable.description', 'min'=>1, 'max'=>1},
          'during' => {'type'=>'Period', 'path'=>'NotAvailable.during', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :description       # 1-1 string
        attr_accessor :during            # 0-1 Period
      end

      attr_accessor :id                     # 0-1 id
      attr_accessor :meta                   # 0-1 Meta
      attr_accessor :implicitRules          # 0-1 uri
      attr_accessor :language               # 0-1 code
      attr_accessor :text                   # 0-1 Narrative
      attr_accessor :contained              # 0-* [ Resource ]
      attr_accessor :extension              # 0-* [ Extension ]
      attr_accessor :modifierExtension      # 0-* [ Extension ]
      attr_accessor :identifier             # 0-* [ Identifier ]
      attr_accessor :providedBy             # 0-1 Reference()
      attr_accessor :serviceCategory        # 0-1 CodeableConcept
      attr_accessor :serviceType            # 0-* [ HealthcareService::ServiceType ]
      attr_accessor :location               # 1-1 Reference()
      attr_accessor :serviceName            # 0-1 string
      attr_accessor :comment                # 0-1 string
      attr_accessor :extraDetails           # 0-1 string
      attr_accessor :photo                  # 0-1 Attachment
      attr_accessor :telecom                # 0-* [ ContactPoint ]
      attr_accessor :coverageArea           # 0-* [ Reference() ]
      attr_accessor :serviceProvisionCode   # 0-* [ CodeableConcept ]
      attr_accessor :eligibility            # 0-1 CodeableConcept
      attr_accessor :eligibilityNote        # 0-1 string
      attr_accessor :programName            # 0-* [ string ]
      attr_accessor :characteristic         # 0-* [ CodeableConcept ]
      attr_accessor :referralMethod         # 0-* [ CodeableConcept ]
      attr_accessor :publicKey              # 0-1 string
      attr_accessor :appointmentRequired    # 0-1 boolean
      attr_accessor :availableTime          # 0-* [ HealthcareService::AvailableTime ]
      attr_accessor :notAvailable           # 0-* [ HealthcareService::NotAvailable ]
      attr_accessor :availabilityExceptions # 0-1 string

      def resourceType
        'HealthcareService'
      end
    end
  end
end