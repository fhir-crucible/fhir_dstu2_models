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
      
    profile = FHIR::Profile.get_base_profile(resourceType)
    puts "Skipping #{json_file} (no profile)" if profile.nil?
    next if profile.nil?
    
    define_method("test_#{json_basename}_profile_validation_json") do
      run_json_validate(json_basename,example_json_string,example_json_hash,profile)
    end
  end

  # Define test methods to validate example XML
  Dir.glob(example_xml_files).each do | xml_file |
    
    xml_basename = File.basename(xml_file,'.xml')
    xml_string = File.open(xml_file, 'r:bom|UTF-8', &:read)
    
    # Ignoring examples that aren't FHIR
    root_element = Nokogiri::XML(xml_string).root.try(:name)
    next if (root_element.nil? || !utils.is_fhir_class?("FHIR::#{root_element}"))
      
    profile = FHIR::Profile.get_base_profile(root_element)
    next if profile.nil?

    define_method("test_#{xml_basename}_profile_validation") do
      run_xml_validate(xml_basename,xml_string,profile)
    end
  end
  
  def run_json_validate(example_name, example_json_string, example_json_hash, profile)
    
    valid = profile.is_valid?(example_json_hash,'JSON')
    if !valid
      puts profile.errors
      File.open("#{ERROR_DIR_JSON}/#{example_name}.json", 'w:UTF-8') {|file| file.write(example_json_string)}      
    end

    assert(valid,"JSON example does not conform to profile: #{profile.name}")
  end

  def run_xml_validate(example_name, example_xml_string, profile)
    
    valid = profile.is_valid?(example_xml_string,'XML')
    if !valid
      puts profile.errors
      File.open("#{ERROR_DIR}/#{example_name}.xml", 'w:UTF-8') {|file| file.write(example_xml_string)}      
    end

    assert(valid,"XML example does not conform to profile: #{profile.name}")
  end
    
end