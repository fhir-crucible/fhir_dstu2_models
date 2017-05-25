require_relative '../test_helper'

class JsonFormatTest < Test::Unit::TestCase
  ERROR_DIR = File.join('tmp', 'errors', 'JsonFormatTest')
  ERROR_LOSSY_DIR = File.join('tmp', 'errors', 'JsonLossinessTest')
  EXAMPLE_ROOT = File.join('lib', 'fhir_dstu2_models', 'examples', 'json')

  # Automatically generate one test method per example file
  example_files = File.join(EXAMPLE_ROOT, '**', '*.json')
  raise 'No Example Files Found' if Dir[example_files].empty?

  # Create a blank folder for the errors
  FileUtils.rm_rf(ERROR_DIR) if File.directory?(ERROR_DIR)
  FileUtils.mkdir_p ERROR_DIR
  FileUtils.rm_rf(ERROR_LOSSY_DIR) if File.directory?(ERROR_LOSSY_DIR)
  FileUtils.mkdir_p ERROR_LOSSY_DIR

  Dir.glob(example_files).each do |example_file|
    example_name = File.basename(example_file, '.json')
    define_method("test_json_format_#{example_name}") do
      run_json_roundtrip_test(example_file, example_name)
    end
    define_method("test_json_xml_json_lossiness_#{example_name}") do
      run_json_xml_json_lossiness_test(example_file, example_name)
    end
  end

  def run_json_roundtrip_test(example_file, example_name)
    input_json = File.read(example_file)
    resource = FHIR::DSTU2::Json.from_json(input_json)
    output_json = resource.to_json

    input_hash = JSON.parse(input_json)
    output_hash = JSON.parse(output_json)

    errors = compare(input_hash, output_hash)

    unless errors.empty?
      File.open("#{ERROR_DIR}/#{example_name}.err", 'w:UTF-8') { |file| file.write(errors.join("\n")) }
      File.open("#{ERROR_DIR}/#{example_name}_PRODUCED.json", 'w:UTF-8') { |file| file.write(output_json) }
      File.open("#{ERROR_DIR}/#{example_name}_ORIGINAL.json", 'w:UTF-8') { |file| file.write(input_json) }
    end

    assert errors.empty?, 'Differences in generated JSON vs original'
    # check memory
    before = check_memory
    resource = nil
    wait_for_gc
    after = check_memory
    assert_memory(before, after)
  end

  def run_json_xml_json_lossiness_test(example_file, example_name)
    input_json = File.read(example_file)
    resource_from_json = FHIR::DSTU2::Json.from_json(input_json)
    output_xml = resource_from_json.to_xml
    resource_from_xml = FHIR::DSTU2::Xml.from_xml(output_xml)
    output_json = resource_from_xml.to_json

    input_hash = JSON.parse(input_json)
    output_hash = JSON.parse(output_json)

    errors = compare(input_hash, output_hash)

    unless errors.empty?
      File.open("#{ERROR_LOSSY_DIR}/#{example_name}.err", 'w:UTF-8') { |file| file.write(errors.join("\n")) }
      File.open("#{ERROR_LOSSY_DIR}/#{example_name}_PRODUCED.xml", 'w:UTF-8') { |file| file.write(output_xml) }
      File.open("#{ERROR_LOSSY_DIR}/#{example_name}_PRODUCED.json", 'w:UTF-8') { |file| file.write(output_json) }
      File.open("#{ERROR_LOSSY_DIR}/#{example_name}_ORIGINAL.json", 'w:UTF-8') { |file| file.write(input_json) }
    end

    assert errors.empty?, 'Differences in generated JSON vs original'
    # check memory
    before = check_memory
    resource_from_json = nil
    resource_from_xml = nil
    wait_for_gc
    after = check_memory
    assert_memory(before, after)
  end
end
