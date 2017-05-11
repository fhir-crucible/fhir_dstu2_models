require_relative '../../test_helper'

class StringTest < Test::Unit::TestCase
  DATA = {
    'name' => 'John Doe',
    'reference' => '#uri',
    'uri' => 'http://snomed.ct'
  }

  # ------------------------- startsWith() -------------------------------------
  def test_startsWith_true
    result = FluentPath.evaluate("name.startsWith('John')", DATA)
    assert result == true, 'Failed startsWith test.'
  end

  def test_startsWith_anchor
    result = FluentPath.evaluate("reference.startsWith('#')", DATA)
    assert result == true, 'Failed startsWith test.'
  end

  def test_startsWith_false
    result = FluentPath.evaluate("name.startsWith('Zoo')", DATA)
    assert result == false, 'Failed startsWith test.'
  end

  # ------------------------- contains() -------------------------------------
  def test_contains_true
    result = FluentPath.evaluate("name.contains('hn')", DATA)
    assert result == true, 'Failed contains test.'
  end

  def test_contains_false
    result = FluentPath.evaluate("name.contains('.')", DATA)
    assert result == false, 'Failed contains test.'
  end
end
