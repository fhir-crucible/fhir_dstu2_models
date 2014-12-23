module FHIR 

  class PartialDateTime < ActiveSupport::TimeWithZone

    # Converts an object of this instance into a database friendly value.
    def mongoize
      {'time'=>self, 'precision'=>self.precision}
    end

    class << self

      # Get the object as it was stored in the database, and instantiate
      # this custom class from it.
      def demongoize(object)
        return object if object.nil?
        time = object['time']
        time.precision = object['precision']
        time
      end

      # Takes any possible object and converts it to how it would be
      # stored in the database.
      def mongoize(object)
        return object if object.nil?
        case object
        when String
          # if we only have a partial date use iso8601 since parse won't work
          if (object.length < 10)
            time = DateTime.iso8601(object)
          else
            # if we have a date and time use DateTime.parse to maintain timezone
            time = DateTime.parse(object)
          end
        else 
          time = ActiveSupport::TimeWithZone.mongoize(object)
        end
        {'time'=>time, 'precision'=>time.precision}
      end

      # Converts the object that was supplied to a criteria and converts it
      # into a database friendly form.
      # def evolve(object)
      # end
    end
  end
end