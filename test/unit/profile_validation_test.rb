require 'fileutils'
require_relative '../test_helper'

class ProfileValidationTest < Test::Unit::TestCase
 
  ERROR_DIR = File.join('tmp','errors','profile','xml')
  ERROR_DIR_JSON = File.join('tmp','errors','profile','json')
  EXAMPLE_ROOT = File.join('..','..','..','..','source')
  EXAMPLE_ROOT_JSON = File.join('..','..','..','..','temp')
  XSD_ROOT = File.join('..','..','..','..','schema')

  # Automatically generate one test method per example file
  example_xml_files = File.join(EXAMPLE_ROOT, '**', '*-example*.xml')
  example_json_files = File.join(EXAMPLE_ROOT_JSON, '**', '*-example*.json')

  # Create a blank folder for the errors
  FileUtils.rm_rf(ERROR_DIR) if File.directory?(ERROR_DIR)
  FileUtils.mkdir_p ERROR_DIR
 
  FileUtils.rm_rf(ERROR_DIR_JSON) if File.directory?(ERROR_DIR_JSON)
  FileUtils.mkdir_p ERROR_DIR_JSON
   
  utils = Class.new.extend(FHIR::Formats::Utilities)

  # Define test methods to validate example JSON
  Dir.glob(example_json_files).each do | json_file |
    
    json_basename = File.basename(json_file,'.json')

    example_json_string = File.open(json_file, 'r:bom|UTF-8', &:read)
    example_json_hash = JSON.parse(example_json_string)

    resourceType = example_json_hash['resourceType']
    puts "Skipping #{json_file} (no resourceType)" if (resourceType.nil? || !utils.is_fhir_class?("FHIR::#{resourceType}"))
    next if (resourceType.nil? || !utils.is_fhir_class?("FHIR::#{resourceType}"))
      
    definition = FHIR::StructureDefinition.get_base_definition(resourceType)
    puts "Skipping #{json_file} (no definition)" if definition.nil?
    next if definition.nil?
    
    define_method("test_#{json_basename}_definition_validation_json") do
      run_json_validate(json_basename,example_json_string,example_json_hash,definition)
    end
  end

  # Define test methods to validate example XML
  Dir.glob(example_xml_files).each do | xml_file |
    
    xml_basename = File.basename(xml_file,'.xml')
    xml_string = File.open(xml_file, 'r:bom|UTF-8', &:read)
    
    # Ignoring examples that aren't FHIR
    root_element = Nokogiri::XML(xml_string).root.try(:name)
    next if (root_element.nil? || !utils.is_fhir_class?("FHIR::#{root_element}"))
      
    definition = FHIR::StructureDefinition.get_base_definition(root_element)
    next if definition.nil?

    define_method("test_#{xml_basename}_definition_validation") do
      run_xml_validate(xml_basename,xml_string,definition)
    end
  end
  
  def run_json_validate(example_name, example_json_string, example_json_hash, definition)
    
    begin
      valid = definition.is_valid?(example_json_hash,'JSON')
      if !valid
        puts definition.errors
        File.open("#{ERROR_DIR_JSON}/#{example_name}.txt", 'w:UTF-8') {|file| file.write(definition.errors)}      
        File.open("#{ERROR_DIR_JSON}/#{example_name}.json", 'w:UTF-8') {|file| file.write(example_json_string)}      
      end
    rescue Exception => e
      puts definition.errors
      puts "Major Error: #{e.message} %n #{e.backtrace.join("\n")}"
      binding.pry
    end 

    assert(valid,"JSON example does not conform to definition: #{definition.name}")
  end

  def run_xml_validate(example_name, example_xml_string, definition)
    
    begin
      valid = definition.is_valid?(example_xml_string,'XML')
      if !valid
        puts definition.errors
        File.open("#{ERROR_DIR}/#{example_name}.txt", 'w:UTF-8') {|file| file.write(definition.errors)}      
        File.open("#{ERROR_DIR}/#{example_name}.xml", 'w:UTF-8') {|file| file.write(example_xml_string)}      
      end
    rescue Exception => e
      puts definition.errors
      puts "Major Error: #{e.message} %n #{e.backtrace.join("\n")}"
      binding.pry
    end 

    assert(valid,"XML example does not conform to definition: #{definition.name}")
  end
    
end