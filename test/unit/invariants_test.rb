require 'fileutils'
require_relative '../test_helper'

class InvariantsValidationTest < Test::Unit::TestCase
 
  ERROR_DIR = File.join('tmp','errors','profile','invariants')
  EXAMPLE_ROOT = File.join('..','..','..','..','source')

  # Automatically generate one test method per example file
  example_xml_files = File.join(EXAMPLE_ROOT, '**', '*-example*.xml')

  # Create a blank folder for the errors
  FileUtils.rm_rf(ERROR_DIR) if File.directory?(ERROR_DIR)
  FileUtils.mkdir_p ERROR_DIR
    
  utils = Class.new.extend(FHIR::Formats::Utilities)

  # regenerate the FHIR invariants... can be time consuming...
  # FHIR::StructureDefinition.generate_invariants_json

  invariant_file = File.open("invariant_validity.csv",'w:UTF-8') # a for append
  invariant_file.puts("resource_type,key,path,valid,expression,description")
  invariant_file.close

  # Define test methods to validate only the invariants of example XML
  # skipping the special 'template-example.xml' file which isn't valid XML
  # but is a template used by the FHIR publishing tools.
  Dir.glob(example_xml_files).select{|f|!f.ends_with?('template-example.xml')}.each do | xml_file |
    
    xml_basename = File.basename(xml_file,'.xml')
    xml_string = File.open(xml_file, 'r:bom|UTF-8', &:read)
    
    define_method("test_#{xml_basename}_invariant_validation") do
      run_xml_invariant_validate(xml_basename,xml_string)
    end
  end

  def run_xml_invariant_validate(example_name, example_xml_string)
    
    begin
      invariants = FHIR::Invariants.new
      invariants.append_to_invariant_csv = true

      valid = invariants.is_valid_xml?(example_xml_string)
      if !valid
        puts invariants.errors
        File.open("#{ERROR_DIR}/#{example_name}.txt", 'w:UTF-8') {|file| file.write(invariants.errors)}      
        File.open("#{ERROR_DIR}/#{example_name}.xml", 'w:UTF-8') {|file| file.write(example_xml_string)}      
      end
    rescue Exception => e
      puts "Major Error: #{e.message} %n #{e.backtrace.join("\n")}"
    end 

    assert(valid,"XML example does not conform to invariant rules.")
  end
    
end