require_relative '../test_helper'

class ProfileValidationTest < Test::Unit::TestCase
  ERROR_DIR = File.join('tmp', 'errors', 'ProfileValidationTest')
  FIXTURES_DIR = File.join('test', 'fixtures')
  PROFILES_DIR = File.join('lib', 'fhir_dstu2_models', 'definitions', 'structures')
  # Cache the US Core IG definitions
  other_profiles = File.join(PROFILES_DIR, 'profiles-others.json')
  PROFILES = {}
  json = File.read(other_profiles)
  resource = FHIR::DSTU2.from_contents(json)
  resource.entry.each do |entry|
    PROFILES[entry.resource.url] = entry.resource
  end

  # Create a blank folder for the errors
  FileUtils.rm_rf(ERROR_DIR) if File.directory?(ERROR_DIR)
  FileUtils.mkdir_p(ERROR_DIR)

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
    # Clear any registered validators
    FHIR::DSTU2::StructureDefinition.clear_all_validates_vs
    FHIR::DSTU2::StructureDefinition.validates_vs "http://hl7.org/fhir/ValueSet/uslab-obs-codes" do |coding|
      true
    end
    FHIR::DSTU2::StructureDefinition.validates_vs "http://hl7.org/fhir/ValueSet/marital-status" do |coding|
      true # always pass
    end
    FHIR::DSTU2::StructureDefinition.validates_vs "http://hl7.org/fhir/v3/MaritalStatus" do |coding|
      false # false, but should never be called so no errors should be present
    end
    example_name = 'sample-daf-record.json'
    patient_record = File.join(FIXTURES_DIR, example_name)
    input_json = File.read(patient_record)
    bundle = FHIR::DSTU2::Json.from_json(input_json)
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

  def test_quantity_validation
    FHIR::DSTU2::StructureDefinition.clear_all_validates_vs
    FHIR::DSTU2::StructureDefinition.validates_vs "http://unitsofmeasure.org" do |coding|
      false
    end

    FHIR::DSTU2::StructureDefinition.validates_vs "http://loinc.org" do |coding|
      false
    end
    profiles = File.read('lib/fhir_dstu2_models/definitions/structures/profiles-resources.json')
    observation_profile = FHIR::DSTU2.from_contents(profiles).entry.find do |entry|
      entry.resource.url == 'http://hl7.org/fhir/StructureDefinition/Observation'
    end
    profile = observation_profile.resource
    assert profile, "Failed to find profile"

    record = File.read('lib/fhir_dstu2_models/examples/json/observation-example-f003-co2.json')
    observation = FHIR::DSTU2::Json.from_json(record)
    errors = profile.validate_resource(observation)
    warnings = profile.warnings
    warnings.reject!{|w| w.empty?}
    # Should
    assert warnings.detect{|x| x.include?('http://loinc.org')}, 'Expected error on validating loinc CodeableConcept'
    assert warnings.detect{|x| x.include?('http://unitsofmeasure.org')}, 'Expected error on validating ucum Quantity'
    assert errors.empty?
  end

  def test_profile_code_system_check
    # Clear any registered validators
    FHIR::DSTU2::StructureDefinition.clear_all_validates_vs
    FHIR::DSTU2::StructureDefinition.validates_vs "http://hl7.org/fhir/ValueSet/marital-status" do |coding|
      false # fails so that the code system validation happens
    end
    FHIR::DSTU2::StructureDefinition.validates_vs "http://hl7.org/fhir/v3/MaritalStatus" do |coding|
      true # no errors related to http://hl7.org/fhir/v3/MaritalStatus should be present
    end

    example_name = 'sample-daf-record.json'
    patient_record = File.join(FIXTURES_DIR, example_name)
    input_json = File.read(patient_record)
    bundle = FHIR::DSTU2::Json.from_json(input_json)
    errors = validate_each_entry(bundle)
    assert !errors.empty?, 'Expected code valueset validation error.'
    assert errors.detect{|x| x.start_with?('Patient.maritalStatus has no codings from http://hl7.org/fhir/ValueSet/marital-status.')}
    assert !errors.detect{|x| x.start_with?('Patient.maritalStatus has no codings from http://hl7.org/fhir/v3/MaritalStatus.')}
    # check memory
    before = check_memory
    resource = nil
    profile = nil
    wait_for_gc
    after = check_memory
    assert_memory(before, after)
  end

  def test_invalid_profile_validation
    example_name = 'invalid-daf-record.json'
    patient_record = File.join(FIXTURES_DIR, example_name)
    input_json = File.read(patient_record)
    bundle = FHIR::DSTU2::Json.from_json(input_json)

    FHIR::DSTU2::StructureDefinition.validates_vs "http://hl7.org/fhir/ValueSet/marital-status"  do |coding|
      "#{coding.system}|#{coding.code}" == "http://hl7.org/fhir/v3/MaritalStatus|S"
    end
    errors = validate_each_entry(bundle)
    FHIR::DSTU2::StructureDefinition.clear_validates_vs "http://hl7.org/fhir/v3/MaritalStatus"

    if errors.empty?
      File.open("#{ERROR_DIR}/#{example_name}.json", 'w:UTF-8') { |file| file.write(input_json) }
    end
    assert !errors.empty?, 'Record improperly validated.'
    assert errors.detect{|x| x.start_with?('Patient.identifier failed cardinality test')}
    assert errors.detect{|x| x.start_with?('Patient.maritalStatus has no codings from')}
    # check memory
    before = check_memory
    resource = nil
    profile = nil
    wait_for_gc
    after = check_memory
    assert_memory(before, after)
  end

  def test_profile_validation_resource
    example_name = 'sample-daf-record.json'
    patient_record = File.join(FIXTURES_DIR, example_name)
    input_json = File.read(patient_record)
    bundle = FHIR::DSTU2::Json.from_json(input_json)
    definition = FHIR::DSTU2::Definitions.resource_definition('Bundle')
    assert definition.validates_resource?(bundle), 'Bundle StructureDefinition failed to validate Bundle.'
    # check memory
    before = check_memory
    model = nil
    wait_for_gc
    after = check_memory
    assert_memory(before, after)
  end

  def test_profile_validation_rejects_bad_resource
    definition = FHIR::DSTU2::Definitions.resource_definition('Bundle')
    assert !definition.validates_resource?(String.new), 'Bundle StructureDefinition should reject anything that is not a FHIR::DSTU2::Model.'
    # check memory
    before = check_memory
    model = nil
    wait_for_gc
    after = check_memory
    assert_memory(before, after)
  end

  def test_profile_with_multiple_extensions
    structure_definition_file = File.join(FIXTURES_DIR, 'custom_profiles', 'StructureDefinition-daf-patient-modified.json')
    # use a modified version of the core patient profile, that changes certain extensions like race and ethnicity from 0..1 to 1..1
    structure_definition_json = JSON.parse(File.read(structure_definition_file))
    profile = FHIR::DSTU2::StructureDefinition.new(structure_definition_json)

    example_name = 'sample-daf-record.json'
    patient_record = File.join(FIXTURES_DIR, example_name)
    input_json = File.read(patient_record)
    bundle = FHIR::DSTU2::Json.from_json(input_json)
    patient_entry = bundle.entry.find { |e| e.resource.is_a?(FHIR::DSTU2::Patient) }

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
    binding_strength = FHIR::DSTU2::Resource::METADATA['language']['binding']['strength']
    FHIR::DSTU2::Resource::METADATA['language']['binding']['strength'] = 'required'
    model = FHIR::DSTU2::Resource.new('language' => 'en-US')
    assert model.valid?, 'Language validation failed.'
    FHIR::DSTU2::Resource::METADATA['language']['binding']['strength'] = binding_strength
    # check memory
    before = check_memory
    model = nil
    wait_for_gc
    after = check_memory
    assert_memory(before, after)
  end
end
