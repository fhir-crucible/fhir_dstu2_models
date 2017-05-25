require 'tempfile'
module FHIR
  module DSTU2
    class Definitions
      extend FHIR::DSTU2::Deprecate
      @@defns = File.expand_path '../definitions', File.dirname(File.absolute_path(__FILE__))
      @@types = nil
      @@resources = nil
      @@profiles = nil
      @@extensions = nil
      @@valuesets = nil
      @@search_params = nil

      @@cache = {}

      # ----------------------------------------------------------------
      #  Types
      # ----------------------------------------------------------------

      def self.types
        @@types ||= begin
          # load the types
          filename = File.join(@@defns, 'structures', 'profiles-types.json')
          raw = File.open(filename, 'r:UTF-8', &:read)
          JSON.parse(raw)['entry'].map { |e| e['resource'] }
        end
      end
      deprecate :load_types, :types
      private_class_method :types

      def self.primitive_types
        # primitive data types start with a lowercase letter
        @primitive_types ||= types.select { |t| t['id'].start_with?(*('a'..'z').to_a) }
      end
      deprecate :get_primitive_types, :primitive_types

      def self.complex_types
        # complex data types start with an uppercase letter
        # and we'll filter out profiles on types (for example, Age is a profile on Quantity)
        @complex_types ||= types.select { |t| t['id'].start_with?(*('A'..'Z').to_a) && (t['id'] == t['snapshot']['element'].first['path']) }
      end
      deprecate :get_complex_types, :complex_types

      def self.type_definition(type_name)
        return nil if type_name.nil?
        return @@cache[type_name] if @@cache[type_name]
        definition = types.find { |x| x['xmlId'] == type_name || x['name'] == type_name || x['url'] == type_name }
        @@cache[type_name] = FHIR::DSTU2::StructureDefinition.new(definition) if definition
        @@cache[type_name]
      end
      deprecate :get_type_definition, :type_definition

      # ----------------------------------------------------------------
      #  Resources, Profiles, Extensions
      # ----------------------------------------------------------------

      def self.resources
        @@resources ||= begin
          # load the resources
          filename = File.join(@@defns, 'structures', 'profiles-resources.json')
          raw = File.open(filename, 'r:UTF-8', &:read)
          JSON.parse(raw)['entry'].map { |e| e['resource'] }
        end
      end
      deprecate :load_resources, :resources
      private_class_method :resources

      def self.resource_definitions
        resources.select { |r| r['kind'] == 'resource' }
      end
      deprecate :get_resource_definitions, :resource_definitions

      def self.resource_definition(resource_name)
        return nil if resource_name.nil?
        return @@cache[resource_name] if @@cache[resource_name]
        definition = resources.find { |x| x['xmlId'] == resource_name || x['name'] == resource_name || x['url'] == resource_name }
        @@cache[resource_name] = FHIR::DSTU2::StructureDefinition.new(definition) if definition
        @@cache[resource_name]
      end
      deprecate :get_resource_definition, :resource_definition

      def self.profiles
        @@profiles ||= begin
          # load the built-in profiles
          filename = File.join(@@defns, 'structures', 'profiles-others.json')
          raw = File.open(filename, 'r:UTF-8', &:read)
          JSON.parse(raw)['entry'].map { |e| e['resource'] }
        end
      end
      deprecate :load_profiles, :profiles
      private_class_method :profiles

      def self.extensions
        @@extensions ||= begin
          # load the built-in extensions
          filename = File.join(@@defns, 'structures', 'extension-definitions.json')
          raw = File.open(filename, 'r:UTF-8', &:read)
          JSON.parse(raw)['entry'].map { |e| e['resource'] }
        end
      end
      deprecate :load_extensions, :extensions
      private_class_method :extensions

      def self.extension_definition(extension_name)
        return nil if extension_name.nil?
        extension = extensions.find { |x| x['xmlId'] == extension_name || x['name'] == extension_name || x['url'] == extension_name }
        return nil if extension.nil?
        FHIR::DSTU2::StructureDefinition.new(extension)
      end
      deprecate :get_extension_definition, :extension_definition

      # Get the basetype (String) for a given profile or extension.
      def self.basetype(uri)
        return nil if uri.nil?
        defn = profiles.detect { |x| x['url'] == uri } || extensions.detect { |x| x['url'] == uri }
        return nil if defn.nil?
        defn['baseType']
      end
      deprecate :get_basetype, :basetype

      # Get the StructureDefinition for a given profile.
      def self.profile(uri)
        return nil if uri.nil?
        defn = profiles.detect { |x| x['url'] == uri } || extensions.detect { |x| x['url'] == uri }
        return nil if defn.nil?
        FHIR::DSTU2::StructureDefinition.new(defn)
      end
      deprecate :get_profile, :profile

      def self.profiles_for_resource(resource_name)
        return nil if resource_name.nil?
        profiles.select { |x| x['baseType'] == resource_name }.map { |x| FHIR::DSTU2::StructureDefinition.new(x) }
      end
      deprecate :get_profiles_for_resource, :profile_for_resource

      # Get a dynamically generated class for a given profile.
      def self.get_profile_class(uri)
        return nil if uri.nil?
        load_profiles
        load_extensions

        defn = @@profiles.select { |x| x['url'] == uri }.first
        defn = @@extensions.select { |x| x['url'] == uri }.first if defn.nil?

        klass = nil
        unless defn.nil?
          generator = FHIR::DSTU2::Boot::Generator.new(false)
          type = defn['baseType']
          id = defn['id'].gsub(/-|_/, '').capitalize
          defn['id'] = type # override profile id with baseType name for generator
          template = generator.generate_class([type], defn)
          f = Tempfile.new(["profile-#{id}", '.rb'])
          f.write("module FHIR::DSTU2\n")
          f.write("module Profile\n")
          f.write("module #{id}\n")
          f.write(template.to_s)
          3.times { f.write("\nend") }
          f.close
          begin
            # load the profiled class
            load f
            # set the return class type
            klass = Object.const_get("FHIR::DSTU2::Profile::#{id}::#{type}")
          rescue
            FHIR::DSTU2.logger.error "Failed to generate class for profile #{uri}"
          end
          # unlink the file so it can be garbage collected
          f.unlink
        end
        klass
      end

      # ----------------------------------------------------------------
      #  ValueSet Code Expansions
      # ----------------------------------------------------------------

      def self.valuesets
        @@valuesets ||= begin
          # load the valuesets
          filename = File.join(@@defns, 'valuesets', 'valuesets.json')
          raw = File.open(filename, 'r:UTF-8', &:read)
          vs = JSON.parse(raw)['entry'].map { |e| e['resource'] }

          filename = File.join(@@defns, 'valuesets', 'v3-codesystems.json')
          raw = File.open(filename, 'r:UTF-8', &:read)
          v3 = JSON.parse(raw)['entry'].map { |e| e['resource'] }

          filename = File.join(@@defns, 'valuesets', 'v2-tables.json')
          raw = File.open(filename, 'r:UTF-8', &:read)
          v2 = JSON.parse(raw)['entry'].map { |e| e['resource'] }

          vs + v3 + v2
        end
      end

      # Get codes (Array of Strings) for a given expansion.
      def self.get_codes(uri, parent_code = nil)
        return nil if uri.nil?
        return @@cache[uri] if @@cache[uri]
        FHIR::DSTU2.logger.debug "Looking up codes for #{uri}"
        valueset = valuesets.select { |x| x['url'] == uri }.first
        if valueset.nil?
          # if we can't identify the valueset by id/uri, see if we can match the codeSystem
          FHIR::DSTU2.logger.debug "Could not find valueset, looking for codeSystem #{uri}"
          valueset = valuesets.select { |v| !v['codeSystem'].nil? && v['codeSystem']['system'] == uri }.first
        end
        unless valueset.nil?
          FHIR::DSTU2.logger.debug "Found valueset #{valueset['url']}"
          @@cache[uri] = {}
          if !valueset['codeSystem'].nil? && !valueset['codeSystem']['system'].nil?
            FHIR::DSTU2.logger.debug "Looking at codeSystem..."
            @@cache[uri][valueset['codeSystem']['system']] = []
            valueset['codeSystem']['concept'].each do |concept|
              @@cache[uri][valueset['codeSystem']['system']] += get_codes_from_concept(concept, parent_code)
            end
          end
          if !valueset['expansion'].nil? && !valueset['expansion']['contains'].nil?
            FHIR::DSTU2.logger.debug "Looking at expansion..."
            keys = valueset['expansion']['contains'].map { |x| x['system'] }.uniq
            keys.each { |x| @@cache[uri][x] = [] }
            valueset['expansion']['contains'].each { |x| @@cache[uri][x['system']] << x['code'] }
          end
          if !valueset['compose'].nil? && !valueset['compose']['include'].nil?
            FHIR::DSTU2.logger.debug "Looking at compose.include..."
            valueset['compose']['include'].each do |x|
              system = x['system']
              unless @@cache[uri].keys.include?(system)
                included_codes = get_codes(system)
                if included_codes
                  @@cache[uri][system] = included_codes[system]
                else
                  @@cache[uri][system] = []
                end
              end
              x['concept'].each { |y| @@cache[uri][system] += get_codes_from_concept(y, parent_code) } if x['concept']
              if x['filter']
                x['filter'].each do |filter|
                  if filter['property']=='concept' && filter['op']=='is-a'
                    codes = get_codes(system, filter['value'])
                    @@cache[uri][system] += codes[system] if codes && codes[system]
                  end
                end
              end
            end
            if !valueset['compose']['exclude'].nil?
              FHIR::DSTU2.logger.debug "Looking at compose.exclude..."
              valueset['compose']['exclude'].each do |x|
                system = x['system']
                unless @@cache[uri].keys.include?(system)
                  included_codes = get_codes(system)[system]
                  if included_codes
                    @@cache[uri][system] = included_codes[system]
                  else
                    @@cache[uri][system] = []
                  end
                end
                x['concept'].each { |y| @@cache[uri][system].delete(y['code']) } if x['concept']
              end
            end
          end
          if !valueset['compose'].nil? && !valueset['compose']['import'].nil?
            FHIR::DSTU2.logger.debug "Looking at compose.import..."
            imported_systems = valueset['compose']['import']
            FHIR::DSTU2.logger.debug "Searching #{imported_systems}..."
            imported_systems.each do |importsys|
              # @@cache[uri][system] = [] unless @@cache[uri].keys.include?(system)
              FHIR::DSTU2.logger.debug "Looking at compose.import #{importsys}..."
              results = get_codes(importsys)
              results.each do |sys, codes|
                if codes.empty?
                  lookup = get_codes(sys)
                  codes = lookup[sys] if lookup
                end
                codes.each do |code|
                  @@cache[uri][sys] = [] unless @@cache[uri].keys.include?(sys)
                  @@cache[uri][sys] << code
                end if codes
              end
            end
          end
          @@cache[uri].each { |_system, codes| codes.uniq! }
        else
          FHIR::DSTU2.logger.debug "Could not find valueset or code system."
        end
        FHIR::DSTU2.logger.debug "Done caching codes for #{uri}"
        @@cache[uri]
      end

      def self.get_codes_from_concept(concept, filter_code = nil)
        begin
          codes = [ ]
          codes << concept['code'] if concept['code'] == filter_code || filter_code.nil?
          if concept['concept']
            filter_code = nil if concept['code'] == filter_code
            concept['concept'].each do |item|
              codes += get_codes_from_concept(item, filter_code)
            end
          end
          codes
        rescue => e
          FHIR::DSTU2.logger.debug "Unable to extract codes from concept #{concept}: #{e.message}"
        end
      end

      # # Get the "display" (human-readable title) for a given code in a code system (uri)
      # # If one can't be found, return nil
      # def self.get_display(uri, code)
      #   return nil if uri.nil? || code.nil?
      #   valuesets_uri = valuesets.select { |vs| vs['url'] == uri }
      #   code_hash = nil
      #   valuesets_uri.each do |valueset|
      #     if valueset['expansion'] && valueset['expansion']['contains']
      #       # This currently only matches 'expansions', not 'valuesets'
      #       code_hash = valueset['expansion']['contains'].detect { |contained| contained['system'] == uri && contained['code'] == code }
      #     elsif valueset['compose'] && valueset['compose']['include']
      #       # This seems to only match 'valuesets'
      #       valueset['compose']['include'].each do |code_system|
      #         code_hash = code_system['concept'].detect { |con| con['code'] == code } if code_system['concept']
      #         break if code_hash
      #       end
      #     elsif valueset['concept']
      #       # This currently only matches 'valuesets', not 'expansions'
      #       code_hash = valueset['concept'].detect { |vs| vs['code'] == code }
      #     end
      #     break if code_hash
      #   end
      #   code_hash['display'] if code_hash
      # end

      # ----------------------------------------------------------------
      #  Search Params
      # ----------------------------------------------------------------

      def self.search_params
        @@search_params ||= begin
          # load the search parameters
          filename = File.join(@@defns, 'structures', 'search-parameters.json')
          raw = File.open(filename, 'r:UTF-8', &:read)
          JSON.parse(raw)['entry'].map { |e| e['resource'] }
        end
      end
      deprecate :load_search_params, :search_params
      private_class_method :search_params

      def self.search_parameters(type_name)
        return nil if type_name.nil?
        search_params.select { |p| p['base'].include?(type_name) && p['xpath'] && !p['xpath'].include?('extension') }.map { |p| p['code'] }
      end
      deprecate :get_search_parameters, :search_parameters
    end
  end
end
