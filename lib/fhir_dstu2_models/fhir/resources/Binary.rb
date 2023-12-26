module FHIR
  module DSTU2
    class Binary < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['contenttype']
      METADATA = {
        'id' => { 'type' => 'id', 'path' => 'Binary.id', 'min' => 0, 'max' => 1 },
        'meta' => { 'type' => 'Meta', 'path' => 'Binary.meta', 'min' => 0, 'max' => 1 },
        'implicitRules' => { 'type' => 'uri', 'path' => 'Binary.implicitRules', 'min' => 0, 'max' => 1 },
        'language' => { 'type' => 'code', 'path' => 'Binary.language', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://tools.ietf.org/html/bcp47' } },
        'contentType' => { 'type' => 'code', 'path' => 'Binary.contentType', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://www.rfc-editor.org/bcp/bcp13.txt' } },
        'content' => { 'type' => 'base64Binary', 'path' => 'Binary.content', 'min' => 1, 'max' => 1 }
      }

      attr_accessor :id            # 0-1 id
      attr_accessor :meta          # 0-1 Meta
      attr_accessor :implicitRules # 0-1 uri
      attr_accessor :language      # 0-1 code
      attr_accessor :contentType   # 1-1 code
      attr_accessor :content       # 1-1 base64Binary

      def resourceType
        'Binary'
      end
    end
  end
end
