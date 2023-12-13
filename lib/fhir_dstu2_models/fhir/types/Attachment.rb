module FHIR
  module DSTU2
    class Attachment < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS =
        METADATA = {
          'id' => {'type'=>'id', 'path'=>'Attachment.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Attachment.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'contentType' => {'type'=>'code', 'path'=>'Attachment.contentType', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://www.rfc-editor.org/bcp/bcp13.txt'}},
          'language' => {'type'=>'code', 'path'=>'Attachment.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
          'data' => {'type'=>'base64Binary', 'path'=>'Attachment.data', 'min'=>0, 'max'=>1},
          'url' => {'type'=>'uri', 'path'=>'Attachment.url', 'min'=>0, 'max'=>1},
          'size' => {'type'=>'unsignedInt', 'path'=>'Attachment.size', 'min'=>0, 'max'=>1},
          'hash' => {'type'=>'base64Binary', 'path'=>'Attachment.hash', 'min'=>0, 'max'=>1},
          'title' => {'type'=>'string', 'path'=>'Attachment.title', 'min'=>0, 'max'=>1},
          'creation' => {'type'=>'dateTime', 'path'=>'Attachment.creation', 'min'=>0, 'max'=>1}
        }

      attr_accessor :id          # 0-1 id
      attr_accessor :extension   # 0-* [ Extension ]
      attr_accessor :contentType # 0-1 code
      attr_accessor :language    # 0-1 code
      attr_accessor :data        # 0-1 base64Binary
      attr_accessor :url         # 0-1 uri
      attr_accessor :size        # 0-1 unsignedInt
      attr_accessor :hash        # 0-1 base64Binary
      attr_accessor :title       # 0-1 string
      attr_accessor :creation    # 0-1 dateTime
    end
  end
end
