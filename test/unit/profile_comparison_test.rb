require 'fileutils'
require 'benchmark'
require_relative '../test_helper'

class ProfileComparisonTest < Test::Unit::TestCase
 
  REPORT_DIR = File.join('tmp','reports','profiles')
  LINE_SEPARATOR = ''
  25.times{ LINE_SEPARATOR << '-' }
  SECTION_SEPARATOR = ''
  80.times{ SECTION_SEPARATOR << '=' }

  # Create a blank folder for the reports
  FileUtils.rm_rf(REPORT_DIR) if File.directory?(REPORT_DIR)
  FileUtils.mkdir_p REPORT_DIR
  File.open("#{REPORT_DIR}/profile_comparison.csv", 'w:UTF-8') do |file| 
    file.puts "Resource,Profile A,Profile B,Path,Attribute,Status,Message,Value A,Value B"
  end

  # Load StructureDefinitions
  puts 'Loading StructureDefinitions...'
  timing = Benchmark.measure{ FHIR::StructureDefinition.load_definitions }
  puts "Completed in #{timing.real} seconds."

  # Get a sorted list of distinct base resources directly from the StructureDefinitions
  base_resources = []
  FHIR::StructureDefinition.base_definitions.entry.each do |entry|
    if entry.resourceType == 'StructureDefinition'
      if !entry.resource.nil?
        base_resources << entry.resource.name
      end
    end
  end
  base_resources.uniq!
  base_resources.sort!

  # Define test methods to compare known profiles
  base_resources.each do |resource_name|
    profiles = FHIR::StructureDefinition.get_profiles_for_resource(resource_name)
    profiles.each_with_index do |p0,index|
      profiles.last(profiles.size-1-index).each do |p1|
        define_method("test_profile_comparison_#{resource_name}__#{p0.xmlId.gsub(/\s+/,'')}__#{p1.xmlId.gsub(/\s+/,'')}") do
          run_comparison(resource_name,p0,p1)
        end
      end
    end
  end


  def run_comparison(resource_name,p0,p1)
    compatible = false
    begin
      compatible = p0.is_compatible?(p1)
      File.open("#{REPORT_DIR}/#{resource_name}.txt", 'a:UTF-8') do |file| 
        file.puts(SECTION_SEPARATOR)
        file.puts("Profile: #{p0.xmlId}")
        file.puts("Profile: #{p1.xmlId}")
        file.puts(LINE_SEPARATOR)
        file.puts("ERRORS (#{p0.errors.size})")
        file.puts(LINE_SEPARATOR)
        p0.errors.each { |e| file.puts e }
        file.puts(LINE_SEPARATOR)          
        file.puts("WARNINGS (#{p0.warnings.size})")          
        file.puts(LINE_SEPARATOR)
        p0.warnings.each { |w| file.puts w }
      end

      File.open("#{REPORT_DIR}/profile_comparison.csv", 'a:UTF-8') do |file| 
        p0.errors.each do |e| 
          file.print(e.to_s)
          file.print("\n")
        end
        p0.warnings.each do |w| 
          file.print(w.to_s)
          file.print("\n")
        end        
      end
    rescue Exception => ex
      puts p0.errors
      puts "Major Error: #{ex.message} \n #{ex.backtrace.join("\n")}"
      binding.pry
    end 
    assert(compatible,"These two #{resource_name} profiles are not compatible.")
  end
    
end