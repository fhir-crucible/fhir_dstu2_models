require_relative '../../test_helper'

class ConvertToBooleanTest < Test::Unit::TestCase
  def test_true_is_true
    data = true
    result = FluentPath.convert_to_boolean(data)
    assert result == true, 'true should be converted to true.'
  end

  def test_false_is_false
    data = false
    result = FluentPath.convert_to_boolean(data)
    assert result == false, 'false should be converted to false.'
  end

  def test_nil_is_false
    data = nil
    result = FluentPath.convert_to_boolean(data)
    assert result == false, 'nil should be converted to false.'
  end

  def test_empty_hash_is_false
    data = {}
    result = FluentPath.convert_to_boolean(data)
    assert result == false, 'An empty hash should be converted to false.'
  end

  def test_empty_array_is_false
    data = []
    result = FluentPath.convert_to_boolean(data)
    assert result == false, 'An empty array should be converted to false.'
  end

  def test_array_with_contents_is_true
    data = [false, true, false]
    result = FluentPath.convert_to_boolean(data)
    assert result == true, 'An array with contents should be converted to true.'
  end

  def test_hash_with_contents_is_true
    data = { 'foo' => 'bar' }
    result = FluentPath.convert_to_boolean(data)
    assert result == true, 'A hash with contents should be converted to true.'
  end

  def test_string_is_true
    data = 'foo'
    result = FluentPath.convert_to_boolean(data)
    assert result == true, 'A string should be converted to true.'
  end

  def test_empty_string_is_true
    data = ''
    result = FluentPath.convert_to_boolean(data)
    assert result == true, 'An empty string should be converted to true.'
  end
end
