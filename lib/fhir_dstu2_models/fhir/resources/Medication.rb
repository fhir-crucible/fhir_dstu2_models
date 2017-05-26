module FHIR
  module DSTU2
    class Medication < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['code', 'destination', 'dispenser', 'identifier', 'medication', 'patient', 'prescription', 'receiver', 'responsibleparty', 'status', 'type', 'whenhandedover', 'whenprepared', 'code', 'effectivedate', 'identifier', 'medication', 'patient', 'source', 'status', 'code', 'container', 'content', 'form', 'ingredient', 'manufacturer', 'code', 'device', 'effectivetime', 'encounter', 'identifier', 'medication', 'notgiven', 'patient', 'practitioner', 'prescription', 'status', 'code', 'datewritten', 'encounter', 'identifier', 'medication', 'patient', 'prescriber', 'status']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Medication.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'Medication.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'Medication.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'Medication.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'Medication.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'Medication.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'Medication.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Medication.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'code' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Medication.code', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/medication-codes'}},
        'isBrand' => {'type'=>'boolean', 'path'=>'Medication.isBrand', 'min'=>0, 'max'=>1},
        'manufacturer' => {'type'=>'Reference', 'path'=>'Medication.manufacturer', 'min'=>0, 'max'=>1},
        'product' => {'type'=>'Medication::Product', 'path'=>'Medication.product', 'min'=>0, 'max'=>1},
        'package' => {'type'=>'Medication::Package', 'path'=>'Medication.package', 'min'=>0, 'max'=>1}
      }

      class Product < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Product.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Product.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Product.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'form' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Product.form', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/medication-form-codes'}},
          'ingredient' => {'type'=>'Medication::Product::Ingredient', 'path'=>'Product.ingredient', 'min'=>0, 'max'=>Float::INFINITY},
          'batch' => {'type'=>'Medication::Product::Batch', 'path'=>'Product.batch', 'min'=>0, 'max'=>Float::INFINITY}
        }

        class Ingredient < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          METADATA = {
            'id' => {'type'=>'id', 'path'=>'Ingredient.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Ingredient.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Ingredient.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'item' => {'type'=>'Reference', 'path'=>'Ingredient.item', 'min'=>1, 'max'=>1},
            'amount' => {'type'=>'Ratio', 'path'=>'Ingredient.amount', 'min'=>0, 'max'=>1}
          }

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :item              # 1-1 Reference()
          attr_accessor :amount            # 0-1 Ratio
        end

        class Batch < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          METADATA = {
            'id' => {'type'=>'id', 'path'=>'Batch.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Batch.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Batch.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'lotNumber' => {'type'=>'string', 'path'=>'Batch.lotNumber', 'min'=>0, 'max'=>1},
            'expirationDate' => {'type'=>'dateTime', 'path'=>'Batch.expirationDate', 'min'=>0, 'max'=>1}
          }

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :lotNumber         # 0-1 string
          attr_accessor :expirationDate    # 0-1 dateTime
        end

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :form              # 0-1 CodeableConcept
        attr_accessor :ingredient        # 0-* [ Medication::Product::Ingredient ]
        attr_accessor :batch             # 0-* [ Medication::Product::Batch ]
      end

      class Package < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Package.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Package.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Package.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'container' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Package.container', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/medication-package-form-codes'}},
          'content' => {'type'=>'Medication::Package::Content', 'path'=>'Package.content', 'min'=>0, 'max'=>Float::INFINITY}
        }

        class Content < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          METADATA = {
            'id' => {'type'=>'id', 'path'=>'Content.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Content.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Content.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'item' => {'type'=>'Reference', 'path'=>'Content.item', 'min'=>1, 'max'=>1},
            'amount' => {'type'=>'Quantity', 'path'=>'Content.amount', 'min'=>0, 'max'=>1}
          }

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :item              # 1-1 Reference()
          attr_accessor :amount            # 0-1 Quantity
        end

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :container         # 0-1 CodeableConcept
        attr_accessor :content           # 0-* [ Medication::Package::Content ]
      end

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :code              # 0-1 CodeableConcept
      attr_accessor :isBrand           # 0-1 boolean
      attr_accessor :manufacturer      # 0-1 Reference()
      attr_accessor :product           # 0-1 Medication::Product
      attr_accessor :package           # 0-1 Medication::Package

      def resourceType
        'Medication'
      end
    end
  end
end