require 'nokogiri'
module FHIR
  module DSTU2
    module Boot
      class Preprocess
        def self.pre_process_bundle(filename)
          # Read the file
          puts "Processing #{File.basename(filename)}..."
          start = File.size(filename)
          json = File.open(filename, 'r:UTF-8', &:read)
          hash = JSON.parse(json)

          # Remove entries that do not interest us: CompartmentDefinitions, OperationDefinitions, Conformance statements
          hash['entry'].select! do |entry|
            %w[StructureDefinition ValueSet CodeSystem SearchParameter].include? entry['resource']['resourceType']
          end

          # Remove unnecessary elements from the hash
          hash['entry'].each do |entry|
            next unless entry['resource']
            pre_process_structuredefinition(entry['resource']) if entry['resource']['resourceType'] == 'StructureDefinition'
            pre_process_valueset(entry['resource']) if entry['resource']['resourceType'] == 'ValueSet'
            pre_process_codesystem(entry['resource']) if entry['resource']['resourceType'] == 'CodeSystem'
            pre_process_searchparam(entry['resource']) if entry['resource']['resourceType'] == 'SearchParameter'
            remove_fhir_comments(entry['resource'])
          end

          # Output the post processed file
          f = File.open(filename, 'w:UTF-8')
          f.write(JSON.pretty_unparse(hash))
          f.close
          finish = File.size(filename)
          puts "  Removed #{(start - finish) / 1024} KB" if start != finish
        end

        def self.pre_process_structuredefinition(hash)
          # Remove large HTML narratives and unused content
          %w[text publisher contact description requirements mapping].each { |key| hash.delete(key) }

          # Remove unused descriptions within the snapshot and differential elements
          %w[snapshot differential].each do |key|
            next unless hash[key]
            hash[key]['element'].each do |element|
              %w[short definition comments requirements alias mapping].each { |subkey| element.delete(subkey) }
            end
          end
        end

        def self.pre_process_valueset(hash)
          # Remove large HTML narratives and unused content
          %w[meta text publisher contact description requirements].each { |key| hash.delete(key) }

          return unless hash['compose']
          %w[include exclude].each do |key|
            next unless hash['compose'][key]
            hash['compose'][key].each do |element|
              next unless element['concept']
              element['concept'].each do |concept|
                concept.delete('designation')
              end
            end
          end
        end

        def self.pre_process_codesystem(hash)
          # Remove large HTML narratives and unused content
          %w[meta text publisher contact description requirements].each { |key| hash.delete(key) }
          return unless hash['concept']
          hash['concept'].each do |concept|
            pre_process_codesystem_concept(concept)
          end
        end

        def self.pre_process_codesystem_concept(hash)
          %w[extension definition designation].each { |key| hash.delete(key) }
          return unless hash['concept']
          hash['concept'].each do |concept|
            pre_process_codesystem_concept(concept)
          end
        end

        def self.pre_process_searchparam(hash)
          # Remove large HTML narratives and unused content
          %w[id url name date publisher contact description xpathUsage].each { |key| hash.delete(key) }
        end

        def self.remove_fhir_comments(hash)
          hash.delete('fhir_comments')
          hash.each do |_key, value|
            if value.is_a?(Hash)
              remove_fhir_comments(value)
            elsif value.is_a?(Array)
              value.each do |v|
                remove_fhir_comments(v) if v.is_a?(Hash)
              end
            end
          end
          hash.keep_if do |_key, value|
            !value.is_a?(Hash) || !value.empty?
          end
        end

        def self.pre_process_schema(filename)
          # Read the file
          puts "Processing #{File.basename(filename)}..."
          start = File.size(filename)
          raw = File.open(filename, 'r:UTF-8', &:read)

          # Remove annotations
          doc = Nokogiri::XML(raw)
          doc.root.add_namespace_definition('xs', 'http://www.w3.org/2001/XMLSchema')
          doc.search('//xs:annotation').each(&:remove)

          # Output the post processed file
          f = File.open(filename, 'w:UTF-8')
          f.write(doc.to_xml)
          f.close
          finish = File.size(filename)
          puts "  Removed #{(start - finish) / 1024} KB" if start != finish
        end
      end
    end
  end
end
