require 'fileutils'
require 'digest'
require_relative '../test_helper'

class ParseExamplesTest < Test::Unit::TestCase
 
  ERROR_DIR = File.join('tmp','errors','parse')
  EXAMPLE_ROOT = File.join('..','..','..','..','source')
  XSD_ROOT = File.join('..','..','..','..','schema')

  # Automatically generate one test method per measure file
  example_files = File.join(EXAMPLE_ROOT, '**', '*-example*.xml')

  # Create a blank folder for the errors
  FileUtils.rm_rf(ERROR_DIR) if File.directory?(ERROR_DIR)
  FileUtils.mkdir_p ERROR_DIR
  
  Dir.glob(example_files).each do | example_file |
    root_element = Nokogiri::XML(File.read(example_file)).root.try(:name)
    next if (root_element.nil? || ['Workbook', 'div'].include?(root_element))

    # TODO: probably want these eventually
    next if EXCLUDED_RESOURCES.include?(root_element)

    example_name = File.basename(example_file, ".xml")
    define_method("test_#{example_name}") do
      run_parse_test(root_element, example_file, example_name)
    end
  end

  def run_parse_test(root_element, example_file, example_name)
    orig_xml = File.read(example_file)
    model = FHIR.const_get(root_element).from_xml orig_xml
    assert !model.nil?

    xml = model.to_xml
    assert xml.length > 0

    xsd = Nokogiri::XML.Schema(File.open(File.join(XSD_ROOT, "#{root_element.downcase}.xsd")))
    errors_orig = xsd.validate(Nokogiri::XML(orig_xml))
    errors = xsd.validate(Nokogiri::XML(xml))

    original_errors = false
    if (errors_orig.present?)
      puts "\t WARNING: errors in example validation"
      if (errors_orig.length == errors.length)
        errors_match = true
        (0...(errors_orig.length)).each {|i| errors_match &&= (errors[i].message == errors_orig[i].message)}
        original_errors = errors_match
      end
    end

    if errors.present? && !original_errors
      File.open("#{ERROR_DIR}/#{example_name}.err", 'w') do | file |
        file.write "#{example_name}: #{errors.length} errors\n\n"
        errors.each do |error|
          file.write(sprintf("%-8d  %s\n", error.line, error.message))
        end

        if errors_orig.present?
          file.write("ORIGINAL ERRORS: ")
          errors_orig.each do |error|
            file.write(sprintf("%-8d  %s\n", error.line, error.message))
          end
        end
      end
      File.open("#{ERROR_DIR}/#{example_name}.xml", 'w') {|file| file.write((Nokogiri.XML(xml) {|x| x.default_xml.noblanks}).to_xml(indent: 2))}
      File.open("#{ERROR_DIR}/#{example_name}_ORIG.xml", 'w') {|file| file.write(orig_xml)}
    end
    assert errors.empty? || original_errors, "Schema Validation errors: \n #{errors.join('\n')}"

  end

end