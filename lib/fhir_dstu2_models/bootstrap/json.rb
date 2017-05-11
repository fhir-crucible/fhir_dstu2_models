module FHIR
  module DSTU2
    module Json
      #
      #  This module includes methods to serialize or deserialize FHIR::DSTU2 resources to and from JSON.
      #

      def to_json
        JSON.pretty_unparse(to_hash)
      end

      def self.from_json(json)
        hash = JSON.parse(json)
        resource = nil
        begin
          resource_type = hash['resourceType']
          klass = Module.const_get("FHIR::DSTU2::#{resource_type}")
          resource = klass.new(hash)
        rescue => e
          FHIR::DSTU2.logger.error("Failed to deserialize JSON:\n#{e.backtrace}")
          FHIR::DSTU2.logger.debug("JSON:\n#{json}")
          resource = nil
        end
        resource
      end
    end
  end
end