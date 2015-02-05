module FHIR 

  class AnyType
    attr_reader :value

    PRIMITIVES = ["integer","decimal","string","uri","boolean","code","base64binary"]
    DATE_TIMES = ["datetime","date","instant"]

    def initialize(value)
      @value = value
    end

    # Converts an object of this instance into a database friendly value.
    def mongoize
      {'type'=>value.class.name, 'value'=>JSON.parse(value.to_json(except: [:_id, :modifier_id]))}
    end

    class << self

      # Get the object as it was stored in the database, and instantiate
      # this custom class from it.
      def demongoize(object)
        case object
        when Hash
          if object['precision']
            FHIR::PartialDateTime.demongoize(object)
          else
            type = object['type']
            value = object['value']
            type.constantize.create(value)
          end

        else
          object
        end
      end

      # Takes any possible object and converts it to how it would be
      # stored in the database.
      def mongoize(object)
        case object
        when AnyType then object.mongoize
        when Hash 
          v = object[:value]
          case object[:type].downcase
          when 'integer', 'decimal', 'boolean'
            v = YAML.load(v)
          when 'datetime', 'date', 'instant'
            v = PartialDateTime.mongoize(v)
          end
          convertType(v)
        else
          convertType(object)
        end
      end

      def convertType(object)
        if (object.respond_to?(:is_fhir_class?) && object.is_fhir_class?(object.class.name))
          AnyType.new(object).mongoize
        else
          object
        end
      end

      # Converts the object that was supplied to a criteria and converts it
      # into a database friendly form.
      def evolve(object)
        case object
        when AnyType then object.mongoize
        else object
        end
      end

    end
  end
end