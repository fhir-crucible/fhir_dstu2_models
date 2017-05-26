module FHIR
  module DSTU2
    class ClaimResponse < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['identifier']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'ClaimResponse.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'ClaimResponse.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'ClaimResponse.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'ClaimResponse.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'ClaimResponse.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'ClaimResponse.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'ClaimResponse.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'ClaimResponse.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'identifier' => {'type'=>'Identifier', 'path'=>'ClaimResponse.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'request' => {'type'=>'Reference', 'path'=>'ClaimResponse.request', 'min'=>0, 'max'=>1},
        'ruleset' => {'valid_codes'=>{'http://hl7.org/fhir/ruleset'=>['x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3']}, 'type'=>'Coding', 'path'=>'ClaimResponse.ruleset', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/ruleset'}},
        'originalRuleset' => {'valid_codes'=>{'http://hl7.org/fhir/ruleset'=>['x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3']}, 'type'=>'Coding', 'path'=>'ClaimResponse.originalRuleset', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/ruleset'}},
        'created' => {'type'=>'dateTime', 'path'=>'ClaimResponse.created', 'min'=>0, 'max'=>1},
        'organization' => {'type'=>'Reference', 'path'=>'ClaimResponse.organization', 'min'=>0, 'max'=>1},
        'requestProvider' => {'type'=>'Reference', 'path'=>'ClaimResponse.requestProvider', 'min'=>0, 'max'=>1},
        'requestOrganization' => {'type'=>'Reference', 'path'=>'ClaimResponse.requestOrganization', 'min'=>0, 'max'=>1},
        'outcome' => {'valid_codes'=>{'http://hl7.org/fhir/remittance-outcome'=>['complete', 'error']}, 'type'=>'code', 'path'=>'ClaimResponse.outcome', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/remittance-outcome'}},
        'disposition' => {'type'=>'string', 'path'=>'ClaimResponse.disposition', 'min'=>0, 'max'=>1},
        'payeeType' => {'valid_codes'=>{'http://hl7.org/fhir/payeetype'=>['subscriber', 'provider', 'other']}, 'type'=>'Coding', 'path'=>'ClaimResponse.payeeType', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/payeetype'}},
        'item' => {'type'=>'ClaimResponse::Item', 'path'=>'ClaimResponse.item', 'min'=>0, 'max'=>Float::INFINITY},
        'addItem' => {'type'=>'ClaimResponse::AddItem', 'path'=>'ClaimResponse.addItem', 'min'=>0, 'max'=>Float::INFINITY},
        'error' => {'type'=>'ClaimResponse::Error', 'path'=>'ClaimResponse.error', 'min'=>0, 'max'=>Float::INFINITY},
        'totalCost' => {'type'=>'Quantity', 'path'=>'ClaimResponse.totalCost', 'min'=>0, 'max'=>1},
        'unallocDeductable' => {'type'=>'Quantity', 'path'=>'ClaimResponse.unallocDeductable', 'min'=>0, 'max'=>1},
        'totalBenefit' => {'type'=>'Quantity', 'path'=>'ClaimResponse.totalBenefit', 'min'=>0, 'max'=>1},
        'paymentAdjustment' => {'type'=>'Quantity', 'path'=>'ClaimResponse.paymentAdjustment', 'min'=>0, 'max'=>1},
        'paymentAdjustmentReason' => {'valid_codes'=>{'http://hl7.org/fhir/adjustment-reason'=>['A001', 'A002']}, 'type'=>'Coding', 'path'=>'ClaimResponse.paymentAdjustmentReason', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/adjustment-reason'}},
        'paymentDate' => {'type'=>'date', 'path'=>'ClaimResponse.paymentDate', 'min'=>0, 'max'=>1},
        'paymentAmount' => {'type'=>'Quantity', 'path'=>'ClaimResponse.paymentAmount', 'min'=>0, 'max'=>1},
        'paymentRef' => {'type'=>'Identifier', 'path'=>'ClaimResponse.paymentRef', 'min'=>0, 'max'=>1},
        'reserved' => {'valid_codes'=>{'http://hl7.org/fhir/fundsreserve'=>['patient', 'provider', 'none']}, 'type'=>'Coding', 'path'=>'ClaimResponse.reserved', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/fundsreserve'}},
        'form' => {'valid_codes'=>{'http://hl7.org/fhir/forms-codes'=>['1', '2']}, 'type'=>'Coding', 'path'=>'ClaimResponse.form', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/forms'}},
        'note' => {'type'=>'ClaimResponse::Note', 'path'=>'ClaimResponse.note', 'min'=>0, 'max'=>Float::INFINITY},
        'coverage' => {'type'=>'ClaimResponse::Coverage', 'path'=>'ClaimResponse.coverage', 'min'=>0, 'max'=>Float::INFINITY}
      }

      class Item < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Item.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Item.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Item.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'sequenceLinkId' => {'type'=>'positiveInt', 'path'=>'Item.sequenceLinkId', 'min'=>1, 'max'=>1},
          'noteNumber' => {'type'=>'positiveInt', 'path'=>'Item.noteNumber', 'min'=>0, 'max'=>Float::INFINITY},
          'adjudication' => {'type'=>'ClaimResponse::Item::Adjudication', 'path'=>'Item.adjudication', 'min'=>0, 'max'=>Float::INFINITY},
          'detail' => {'type'=>'ClaimResponse::Item::Detail', 'path'=>'Item.detail', 'min'=>0, 'max'=>Float::INFINITY}
        }

        class Adjudication < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          METADATA = {
            'id' => {'type'=>'id', 'path'=>'Adjudication.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Adjudication.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Adjudication.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'code' => {'valid_codes'=>{'http://hl7.org/fhir/adjudication'=>['total', 'copay', 'eligible', 'deductible', 'eligpercent', 'tax', 'benefit']}, 'type'=>'Coding', 'path'=>'Adjudication.code', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/adjudication'}},
            'amount' => {'type'=>'Quantity', 'path'=>'Adjudication.amount', 'min'=>0, 'max'=>1},
            'value' => {'type'=>'decimal', 'path'=>'Adjudication.value', 'min'=>0, 'max'=>1}
          }

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :code              # 1-1 Coding
          attr_accessor :amount            # 0-1 Quantity
          attr_accessor :value             # 0-1 decimal
        end

        class Detail < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          METADATA = {
            'id' => {'type'=>'id', 'path'=>'Detail.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Detail.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Detail.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'sequenceLinkId' => {'type'=>'positiveInt', 'path'=>'Detail.sequenceLinkId', 'min'=>1, 'max'=>1},
            'adjudication' => {'type'=>'ClaimResponse::Item::Detail::Adjudication', 'path'=>'Detail.adjudication', 'min'=>0, 'max'=>Float::INFINITY},
            'subDetail' => {'type'=>'ClaimResponse::Item::Detail::SubDetail', 'path'=>'Detail.subDetail', 'min'=>0, 'max'=>Float::INFINITY}
          }

          class Adjudication < FHIR::DSTU2::Model
            include FHIR::DSTU2::Hashable
            include FHIR::DSTU2::Json
            include FHIR::DSTU2::Xml

            METADATA = {
              'id' => {'type'=>'id', 'path'=>'Adjudication.id', 'min'=>0, 'max'=>1},
              'extension' => {'type'=>'Extension', 'path'=>'Adjudication.extension', 'min'=>0, 'max'=>Float::INFINITY},
              'modifierExtension' => {'type'=>'Extension', 'path'=>'Adjudication.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
              'code' => {'valid_codes'=>{'http://hl7.org/fhir/adjudication'=>['total', 'copay', 'eligible', 'deductible', 'eligpercent', 'tax', 'benefit']}, 'type'=>'Coding', 'path'=>'Adjudication.code', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/adjudication'}},
              'amount' => {'type'=>'Quantity', 'path'=>'Adjudication.amount', 'min'=>0, 'max'=>1},
              'value' => {'type'=>'decimal', 'path'=>'Adjudication.value', 'min'=>0, 'max'=>1}
            }

            attr_accessor :id                # 0-1 id
            attr_accessor :extension         # 0-* [ Extension ]
            attr_accessor :modifierExtension # 0-* [ Extension ]
            attr_accessor :code              # 1-1 Coding
            attr_accessor :amount            # 0-1 Quantity
            attr_accessor :value             # 0-1 decimal
          end

          class SubDetail < FHIR::DSTU2::Model
            include FHIR::DSTU2::Hashable
            include FHIR::DSTU2::Json
            include FHIR::DSTU2::Xml

            METADATA = {
              'id' => {'type'=>'id', 'path'=>'SubDetail.id', 'min'=>0, 'max'=>1},
              'extension' => {'type'=>'Extension', 'path'=>'SubDetail.extension', 'min'=>0, 'max'=>Float::INFINITY},
              'modifierExtension' => {'type'=>'Extension', 'path'=>'SubDetail.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
              'sequenceLinkId' => {'type'=>'positiveInt', 'path'=>'SubDetail.sequenceLinkId', 'min'=>1, 'max'=>1},
              'adjudication' => {'type'=>'ClaimResponse::Item::Detail::SubDetail::Adjudication', 'path'=>'SubDetail.adjudication', 'min'=>0, 'max'=>Float::INFINITY}
            }

            class Adjudication < FHIR::DSTU2::Model
              include FHIR::DSTU2::Hashable
              include FHIR::DSTU2::Json
              include FHIR::DSTU2::Xml

              METADATA = {
                'id' => {'type'=>'id', 'path'=>'Adjudication.id', 'min'=>0, 'max'=>1},
                'extension' => {'type'=>'Extension', 'path'=>'Adjudication.extension', 'min'=>0, 'max'=>Float::INFINITY},
                'modifierExtension' => {'type'=>'Extension', 'path'=>'Adjudication.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
                'code' => {'valid_codes'=>{'http://hl7.org/fhir/adjudication'=>['total', 'copay', 'eligible', 'deductible', 'eligpercent', 'tax', 'benefit']}, 'type'=>'Coding', 'path'=>'Adjudication.code', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/adjudication'}},
                'amount' => {'type'=>'Quantity', 'path'=>'Adjudication.amount', 'min'=>0, 'max'=>1},
                'value' => {'type'=>'decimal', 'path'=>'Adjudication.value', 'min'=>0, 'max'=>1}
              }

              attr_accessor :id                # 0-1 id
              attr_accessor :extension         # 0-* [ Extension ]
              attr_accessor :modifierExtension # 0-* [ Extension ]
              attr_accessor :code              # 1-1 Coding
              attr_accessor :amount            # 0-1 Quantity
              attr_accessor :value             # 0-1 decimal
            end

            attr_accessor :id                # 0-1 id
            attr_accessor :extension         # 0-* [ Extension ]
            attr_accessor :modifierExtension # 0-* [ Extension ]
            attr_accessor :sequenceLinkId    # 1-1 positiveInt
            attr_accessor :adjudication      # 0-* [ ClaimResponse::Item::Detail::SubDetail::Adjudication ]
          end

          class Subadjudication < FHIR::DSTU2::Model
            include FHIR::DSTU2::Hashable
            include FHIR::DSTU2::Json
            include FHIR::DSTU2::Xml


          end

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :sequenceLinkId    # 1-1 positiveInt
          attr_accessor :adjudication      # 0-* [ ClaimResponse::Item::Detail::Adjudication ]
          attr_accessor :subDetail         # 0-* [ ClaimResponse::Item::Detail::SubDetail ]
        end

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :sequenceLinkId    # 1-1 positiveInt
        attr_accessor :noteNumber        # 0-* [ positiveInt ]
        attr_accessor :adjudication      # 0-* [ ClaimResponse::Item::Adjudication ]
        attr_accessor :detail            # 0-* [ ClaimResponse::Item::Detail ]
      end

      class AddItem < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'AddItem.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'AddItem.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'AddItem.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'sequenceLinkId' => {'type'=>'positiveInt', 'path'=>'AddItem.sequenceLinkId', 'min'=>0, 'max'=>Float::INFINITY},
          'service' => {'valid_codes'=>{'http://hl7.org/fhir/ex-USCLS'=>['1101', '1102', '1103', '1201', '1205', '2101', '2102', '2141', '2601', '11101', '11102', '11103', '11104', '21211', '21212', '27211', '99111', '99333', '99555']}, 'type'=>'Coding', 'path'=>'AddItem.service', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/service-uscls'}},
          'fee' => {'type'=>'Quantity', 'path'=>'AddItem.fee', 'min'=>0, 'max'=>1},
          'noteNumberLinkId' => {'type'=>'positiveInt', 'path'=>'AddItem.noteNumberLinkId', 'min'=>0, 'max'=>Float::INFINITY},
          'adjudication' => {'type'=>'ClaimResponse::AddItem::Adjudication', 'path'=>'AddItem.adjudication', 'min'=>0, 'max'=>Float::INFINITY},
          'detail' => {'type'=>'ClaimResponse::AddItem::Detail', 'path'=>'AddItem.detail', 'min'=>0, 'max'=>Float::INFINITY}
        }

        class Adjudication < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          METADATA = {
            'id' => {'type'=>'id', 'path'=>'Adjudication.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Adjudication.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Adjudication.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'code' => {'valid_codes'=>{'http://hl7.org/fhir/adjudication'=>['total', 'copay', 'eligible', 'deductible', 'eligpercent', 'tax', 'benefit']}, 'type'=>'Coding', 'path'=>'Adjudication.code', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/adjudication'}},
            'amount' => {'type'=>'Quantity', 'path'=>'Adjudication.amount', 'min'=>0, 'max'=>1},
            'value' => {'type'=>'decimal', 'path'=>'Adjudication.value', 'min'=>0, 'max'=>1}
          }

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :code              # 1-1 Coding
          attr_accessor :amount            # 0-1 Quantity
          attr_accessor :value             # 0-1 decimal
        end

        class Detail < FHIR::DSTU2::Model
          include FHIR::DSTU2::Hashable
          include FHIR::DSTU2::Json
          include FHIR::DSTU2::Xml

          METADATA = {
            'id' => {'type'=>'id', 'path'=>'Detail.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Detail.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Detail.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'service' => {'valid_codes'=>{'http://hl7.org/fhir/ex-USCLS'=>['1101', '1102', '1103', '1201', '1205', '2101', '2102', '2141', '2601', '11101', '11102', '11103', '11104', '21211', '21212', '27211', '99111', '99333', '99555']}, 'type'=>'Coding', 'path'=>'Detail.service', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/service-uscls'}},
            'fee' => {'type'=>'Quantity', 'path'=>'Detail.fee', 'min'=>0, 'max'=>1},
            'adjudication' => {'type'=>'ClaimResponse::AddItem::Detail::Adjudication', 'path'=>'Detail.adjudication', 'min'=>0, 'max'=>Float::INFINITY}
          }

          class Adjudication < FHIR::DSTU2::Model
            include FHIR::DSTU2::Hashable
            include FHIR::DSTU2::Json
            include FHIR::DSTU2::Xml

            METADATA = {
              'id' => {'type'=>'id', 'path'=>'Adjudication.id', 'min'=>0, 'max'=>1},
              'extension' => {'type'=>'Extension', 'path'=>'Adjudication.extension', 'min'=>0, 'max'=>Float::INFINITY},
              'modifierExtension' => {'type'=>'Extension', 'path'=>'Adjudication.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
              'code' => {'valid_codes'=>{'http://hl7.org/fhir/adjudication'=>['total', 'copay', 'eligible', 'deductible', 'eligpercent', 'tax', 'benefit']}, 'type'=>'Coding', 'path'=>'Adjudication.code', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/adjudication'}},
              'amount' => {'type'=>'Quantity', 'path'=>'Adjudication.amount', 'min'=>0, 'max'=>1},
              'value' => {'type'=>'decimal', 'path'=>'Adjudication.value', 'min'=>0, 'max'=>1}
            }

            attr_accessor :id                # 0-1 id
            attr_accessor :extension         # 0-* [ Extension ]
            attr_accessor :modifierExtension # 0-* [ Extension ]
            attr_accessor :code              # 1-1 Coding
            attr_accessor :amount            # 0-1 Quantity
            attr_accessor :value             # 0-1 decimal
          end

          attr_accessor :id                # 0-1 id
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :service           # 1-1 Coding
          attr_accessor :fee               # 0-1 Quantity
          attr_accessor :adjudication      # 0-* [ ClaimResponse::AddItem::Detail::Adjudication ]
        end

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :sequenceLinkId    # 0-* [ positiveInt ]
        attr_accessor :service           # 1-1 Coding
        attr_accessor :fee               # 0-1 Quantity
        attr_accessor :noteNumberLinkId  # 0-* [ positiveInt ]
        attr_accessor :adjudication      # 0-* [ ClaimResponse::AddItem::Adjudication ]
        attr_accessor :detail            # 0-* [ ClaimResponse::AddItem::Detail ]
      end

      class Error < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Error.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Error.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Error.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'sequenceLinkId' => {'type'=>'positiveInt', 'path'=>'Error.sequenceLinkId', 'min'=>0, 'max'=>1},
          'detailSequenceLinkId' => {'type'=>'positiveInt', 'path'=>'Error.detailSequenceLinkId', 'min'=>0, 'max'=>1},
          'subdetailSequenceLinkId' => {'type'=>'positiveInt', 'path'=>'Error.subdetailSequenceLinkId', 'min'=>0, 'max'=>1},
          'code' => {'valid_codes'=>{'http://hl7.org/fhir/adjudication-error'=>['A001', 'A002']}, 'type'=>'Coding', 'path'=>'Error.code', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/adjudication-error'}}
        }

        attr_accessor :id                      # 0-1 id
        attr_accessor :extension               # 0-* [ Extension ]
        attr_accessor :modifierExtension       # 0-* [ Extension ]
        attr_accessor :sequenceLinkId          # 0-1 positiveInt
        attr_accessor :detailSequenceLinkId    # 0-1 positiveInt
        attr_accessor :subdetailSequenceLinkId # 0-1 positiveInt
        attr_accessor :code                    # 1-1 Coding
      end

      class Note < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Note.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Note.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Note.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'number' => {'type'=>'positiveInt', 'path'=>'Note.number', 'min'=>0, 'max'=>1},
          'type' => {'valid_codes'=>{'http://hl7.org/fhir/note-type'=>['display', 'print', 'printoper']}, 'type'=>'Coding', 'path'=>'Note.type', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/note-type'}},
          'text' => {'type'=>'string', 'path'=>'Note.text', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :number            # 0-1 positiveInt
        attr_accessor :type              # 0-1 Coding
        attr_accessor :text              # 0-1 string
      end

      class Coverage < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Coverage.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Coverage.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Coverage.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'sequence' => {'type'=>'positiveInt', 'path'=>'Coverage.sequence', 'min'=>1, 'max'=>1},
          'focal' => {'type'=>'boolean', 'path'=>'Coverage.focal', 'min'=>1, 'max'=>1},
          'coverage' => {'type'=>'Reference', 'path'=>'Coverage.coverage', 'min'=>1, 'max'=>1},
          'businessArrangement' => {'type'=>'string', 'path'=>'Coverage.businessArrangement', 'min'=>0, 'max'=>1},
          'relationship' => {'valid_codes'=>{'http://hl7.org/fhir/relationship'=>['1', '2', '3', '4', '5']}, 'type'=>'Coding', 'path'=>'Coverage.relationship', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/relationship'}},
          'preAuthRef' => {'type'=>'string', 'path'=>'Coverage.preAuthRef', 'min'=>0, 'max'=>Float::INFINITY},
          'claimResponse' => {'type'=>'Reference', 'path'=>'Coverage.claimResponse', 'min'=>0, 'max'=>1},
          'originalRuleset' => {'valid_codes'=>{'http://hl7.org/fhir/ruleset'=>['x12-4010', 'x12-5010', 'x12-7010', 'cdanet-v2', 'cdanet-v4', 'cpha-3']}, 'type'=>'Coding', 'path'=>'Coverage.originalRuleset', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/ruleset'}}
        }

        attr_accessor :id                  # 0-1 id
        attr_accessor :extension           # 0-* [ Extension ]
        attr_accessor :modifierExtension   # 0-* [ Extension ]
        attr_accessor :sequence            # 1-1 positiveInt
        attr_accessor :focal               # 1-1 boolean
        attr_accessor :coverage            # 1-1 Reference()
        attr_accessor :businessArrangement # 0-1 string
        attr_accessor :relationship        # 1-1 Coding
        attr_accessor :preAuthRef          # 0-* [ string ]
        attr_accessor :claimResponse       # 0-1 Reference()
        attr_accessor :originalRuleset     # 0-1 Coding
      end

      attr_accessor :id                      # 0-1 id
      attr_accessor :meta                    # 0-1 Meta
      attr_accessor :implicitRules           # 0-1 uri
      attr_accessor :language                # 0-1 code
      attr_accessor :text                    # 0-1 Narrative
      attr_accessor :contained               # 0-* [ Resource ]
      attr_accessor :extension               # 0-* [ Extension ]
      attr_accessor :modifierExtension       # 0-* [ Extension ]
      attr_accessor :identifier              # 0-* [ Identifier ]
      attr_accessor :request                 # 0-1 Reference()
      attr_accessor :ruleset                 # 0-1 Coding
      attr_accessor :originalRuleset         # 0-1 Coding
      attr_accessor :created                 # 0-1 dateTime
      attr_accessor :organization            # 0-1 Reference()
      attr_accessor :requestProvider         # 0-1 Reference()
      attr_accessor :requestOrganization     # 0-1 Reference()
      attr_accessor :outcome                 # 0-1 code
      attr_accessor :disposition             # 0-1 string
      attr_accessor :payeeType               # 0-1 Coding
      attr_accessor :item                    # 0-* [ ClaimResponse::Item ]
      attr_accessor :addItem                 # 0-* [ ClaimResponse::AddItem ]
      attr_accessor :error                   # 0-* [ ClaimResponse::Error ]
      attr_accessor :totalCost               # 0-1 Quantity
      attr_accessor :unallocDeductable       # 0-1 Quantity
      attr_accessor :totalBenefit            # 0-1 Quantity
      attr_accessor :paymentAdjustment       # 0-1 Quantity
      attr_accessor :paymentAdjustmentReason # 0-1 Coding
      attr_accessor :paymentDate             # 0-1 date
      attr_accessor :paymentAmount           # 0-1 Quantity
      attr_accessor :paymentRef              # 0-1 Identifier
      attr_accessor :reserved                # 0-1 Coding
      attr_accessor :form                    # 0-1 Coding
      attr_accessor :note                    # 0-* [ ClaimResponse::Note ]
      attr_accessor :coverage                # 0-* [ ClaimResponse::Coverage ]

      def resourceType
        'ClaimResponse'
      end
    end
  end
end