module FHIR
  module DSTU2
    class Identifier < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS =
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Identifier.id', 'min'=>0, 'max'=>1},
        'extension' => {'type'=>'Extension', 'path'=>'Identifier.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'use' => {'valid_codes'=>{'http://hl7.org/fhir/identifier-use'=>['usual', 'official', 'temp', 'secondary']}, 'type'=>'code', 'path'=>'Identifier.use', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/identifier-use'}},
        'type' => {'valid_codes'=>{'http://hl7.org/fhir/identifier-type'=>['UDI', 'SNO', 'SB', 'PLAC', 'FILL'], 'http://hl7.org/fhir/v2/0203'=>['ACSN', 'AM', 'AMA', 'AN', 'ANC', 'AND', 'ANON', 'ANT', 'APRN', 'ASID', 'An Identifier for a provider a', 'An identifier for a provi', 'An identifier for a provider r', 'BA', 'BC', 'BCT', 'BR', 'BRN', 'BSNR', 'CC', 'CONM', 'CY', 'CZ', 'DDS', 'DEA', 'DFN', 'DI', 'DL', 'DN', 'DO', 'DP', 'DPM', 'DR', 'DS', 'EI', 'EN', 'ESN', 'FI', 'GI', 'GL', 'GN', 'HC', 'IND', 'JHN', 'LACSN', 'LANR', 'LI', 'LN', 'LR', 'MA', 'MB', 'MC', 'MCD', 'MCN', 'MCR', 'MCT', 'MD', 'MI', 'MR', 'MRT', 'MS', 'NBSNR', 'NCT', 'NE', 'NH', 'NI', 'NII', 'NIIP', 'NNxxx', 'NP', 'NPI', 'OD', 'PA', 'PC', 'PCN', 'PE', 'PEN', 'PI', 'PN', 'PNT', 'PPIN', 'PPN', 'PRC', 'PRN', 'PT', 'QA', 'RI', 'RN', 'RPH', 'RR', 'RRI', 'RRP', 'SID', 'SL', 'SN', 'SP', 'SR', 'SS', 'TAX', 'TN', 'TPR', 'U', 'UPIN', 'USID', 'VN', 'VP', 'VS', 'WC', 'WCN', 'WP', 'XX']}, 'type'=>'CodeableConcept', 'path'=>'Identifier.type', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/identifier-type'}},
        'system' => {'type'=>'uri', 'path'=>'Identifier.system', 'min'=>0, 'max'=>1},
        'value' => {'type'=>'string', 'path'=>'Identifier.value', 'min'=>0, 'max'=>1},
        'period' => {'type'=>'Period', 'path'=>'Identifier.period', 'min'=>0, 'max'=>1},
        'assigner' => {'type'=>'Reference', 'path'=>'Identifier.assigner', 'min'=>0, 'max'=>1}
      }

      attr_accessor :id        # 0-1 id
      attr_accessor :extension # 0-* [ Extension ]
      attr_accessor :use       # 0-1 code
      attr_accessor :type      # 0-1 CodeableConcept
      attr_accessor :system    # 0-1 uri
      attr_accessor :value     # 0-1 string
      attr_accessor :period    # 0-1 Period
      attr_accessor :assigner  # 0-1 Reference()
    end
  end
end
