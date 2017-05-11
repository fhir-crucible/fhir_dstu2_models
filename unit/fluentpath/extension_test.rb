require_relative '../../test_helper'

class ExtensionTest < Test::Unit::TestCase
  CONCEPT = {
    'coding' => [{
      'system' => 'http://hl7.org/fhir/v3/Race',
      'code' => '1096-7'
    }]
  }
  EXT = {
    'url' => 'http://hl7.org/fhir/StructureDefinition/us-core-race',
    'valueCodeableConcept' => CONCEPT
  }
  EXT_ARRAY = [EXT]
  PATIENT = {
    'name' => {
      'given' => ['Foo']
    },
    'extension' => EXT_ARRAY,
    'resourceType' => 'Patient'
  }

  def test_extension
    result = FluentPath.evaluate('Patient.extension', PATIENT)
    assert result == EXT_ARRAY, 'Failed to resolve extension.'
  end

  def test_extension_with_block
    result = FluentPath.evaluate("Patient.extension('http://hl7.org/fhir/StructureDefinition/us-core-race')", PATIENT)
    assert result == EXT, 'Failed to resolve extension by name.'
  end

  def test_extension_item
    result = FluentPath.evaluate('Patient.extension[0]', PATIENT)
    assert result == EXT, 'Failed to resolve extension by index.'
  end

  def test_extension_value
    result = FluentPath.evaluate('Patient.extension[0].value', PATIENT)
    assert result == CONCEPT, 'Failed to resolve extension value.'
  end

  def test_extension_with_block_value
    result = FluentPath.evaluate("Patient.extension('http://hl7.org/fhir/StructureDefinition/us-core-race').value", PATIENT)
    assert result == CONCEPT, 'Failed to resolve named extension value.'
  end

  def test_extension_missing
    result = FluentPath.evaluate("Patient.extension('http://hl7.org/fhir/StructureDefinition/us-core-ethnicity')", PATIENT)
    assert result.nil?, 'Failed to resolve missing extension.'
  end
end
