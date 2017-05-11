require_relative '../test_helper'

class ProfileValidationTest < Test::Unit::TestCase
  ERROR_DIR = File.join('tmp', 'errors', 'ProfileValidationTest')
  FIXTURES_DIR = File.join('test', 'fixtures')

  # Cache the US Core IG definitions
  us_core_ig = File.join(FIXTURES_DIR, 'us_core', '*.json')
  PROFILES = {}
  Dir.glob(us_core_ig).each do |definition|
    json = File.read(definition)
    resource = FHIR.from_contents(json)
    PROFILES[resource.url] = resource
  end

  # Create a blank folder for the errors
  FileUtils.rm_rf(ERROR_DIR) if File.directory?(ERROR_DIR)
  FileUtils.mkdir_p ERROR_DIR

  def validate_each_entry(bundle)
    complete_error_list = []
    bundle.entry.each do |entry|
      if entry.resource.meta
        # validate against the declared profile
        profile = PROFILES[entry.resource.meta.profile.first]
        assert profile, "Failed to find profile: #{entry.resource.meta.profile.first}"
        rerrors = profile.validate_resource(entry.resource)
        complete_error_list << rerrors unless rerrors.empty?
      else
        # validate the base resource
        rerrors = entry.resource.validate
        complete_error_list << rerrors unless rerrors.empty?
      end
    end
    complete_error_list.flatten
  end

  def test_profile_validation
    example_name = 'sample-us-core-record.json'
    patient_record = File.join(FIXTURES_DIR, example_name)
    input_json = File.read(patient_record)
    bundle = FHIR::Json.from_json(input_json)
    errors = validate_each_entry(bundle)
    unless errors.empty?
      File.open("#{ERROR_DIR}/#{example_name}.err", 'w:UTF-8') { |file| errors.each { |e| file.write("#{e}\n") } }
      File.open("#{ERROR_DIR}/#{example_name}.json", 'w:UTF-8') { |file| file.write(input_json) }
    end
    assert errors.empty?, 'Record failed to validate.'
    # check memory
    before = check_memory
    resource = nil
    profile = nil
    wait_for_gc
    after = check_memory
    assert_memory(before, after)
  end

  def test_invalid_profile_validation
    example_name = 'invalid-us-core-record.json'
    patient_record = File.join(FIXTURES_DIR, example_name)
    input_json = File.read(patient_record)
    bundle = FHIR::Json.from_json(input_json)
    errors = validate_each_entry(bundle)
    unless errors
      File.open("#{ERROR_DIR}/#{example_name}.json", 'w:UTF-8') { |file| file.write(input_json) }
    end
    assert !errors.empty?, 'Record improperly validated.'
    assert errors.detect{|x| x.start_with?('Patient.identifier.value failed cardinality test')}
    # check memory
    before = check_memory
    resource = nil
    profile = nil
    wait_for_gc
    after = check_memory
    assert_memory(before, after)
  end

  def test_profile_validation_resource
    example_name = 'sample-us-core-record.json'
    patient_record = File.join(FIXTURES_DIR, example_name)
    input_json = File.read(patient_record)
    bundle = FHIR::Json.from_json(input_json)
    definition = FHIR::Definitions.resource_definition('Bundle')
    assert definition.validates_resource?(bundle), 'Bundle StructureDefinition failed to validate Bundle.'
    # check memory
    before = check_memory
    model = nil
    wait_for_gc
    after = check_memory
    assert_memory(before, after)
  end

  def test_profile_validation_rejects_bad_resource
    definition = FHIR::Definitions.resource_definition('Bundle')
    assert !definition.validates_resource?(String.new), 'Bundle StructureDefinition should reject anything that is not a FHIR::Model.'
    # check memory
    before = check_memory
    model = nil
    wait_for_gc
    after = check_memory
    assert_memory(before, after)
  end

  def test_profile_with_multiple_extensions
    structure_definition_file = File.join(FIXTURES_DIR, 'custom_profiles', 'StructureDefinition-us-core-patient-modified.json')
    # use a modified version of the core patient profile, that changes certain extensions like race and ethnicity from 0..1 to 1..1
    structure_definition_json = JSON.parse(File.read(structure_definition_file))
    profile = FHIR::StructureDefinition.new(structure_definition_json)

    example_name = 'sample-us-core-record.json'
    patient_record = File.join(FIXTURES_DIR, example_name)
    input_json = File.read(patient_record)
    bundle = FHIR::Json.from_json(input_json)
    patient_entry = bundle.entry.find { |e| e.resource.is_a?(FHIR::Patient) }

    assert_empty profile.validate_resource(patient_entry.resource), 'Record failed to validate against modified core profile.'
    # check memory
    before = check_memory
    bundle = nil
    patient_entry = nil
    wait_for_gc
    after = check_memory
    assert_memory(before, after)
  end

  def test_language_binding_validation
    binding_strength = FHIR::Resource::METADATA['language']['binding']['strength']
    FHIR::Resource::METADATA['language']['binding']['strength'] = 'required'
    model = FHIR::Resource.new('language' => 'en-US')
    assert model.valid?, 'Language validation failed.'
    FHIR::Resource::METADATA['language']['binding']['strength'] = binding_strength
    # check memory
    before = check_memory
    model = nil
    wait_for_gc
    after = check_memory
    assert_memory(before, after)
  end
end
