require_relative '../../test_helper'

class PathTest < Test::Unit::TestCase
  NAMES = %w(Bob Robert)
  WTF = %w(Bobert Rob)
  PID1 = 99
  PATIENT = {
    'name' => [{
      'given' => NAMES
    }, {
      'given' => WTF
    }],
    'resourceType' => 'Patient'
  }
  MESSAGE = {
    'Message' => {
      'PID-1' => PID1
    }
  }
  ARRAY = {
    'Array' => %w(A B),
    'index' => 1
  }
  ITEM = { 'base' => 'Patient' }
  LIST = [5, 4, 3, 2, 1]

  def test_path_without_type
    result = FluentPath.evaluate('name.given', PATIENT)
    assert result == NAMES + WTF, 'Failed to navigate path.'
  end

  def test_path_with_type
    result = FluentPath.evaluate('Patient.name.given', PATIENT)
    assert result == NAMES + WTF, 'Failed to navigate path.'
  end

  def test_path_conversion_2args
    result = FluentPath.evaluate('Patient.name.given.select(substring(0,3))', PATIENT)
    assert result == %w(Bob Rob Bob Rob), 'Failed to navigate path.'
  end

  def test_path_conversion_1args
    result = FluentPath.evaluate('Patient.name.given.select(substring(1))', PATIENT)
    assert result == %w(ob obert obert ob), 'Failed to navigate path.'
  end

  def test_path_with_quotes
    result = FluentPath.evaluate('Message."PID-1"', MESSAGE)
    assert result == PID1, 'Failed to navigate path.'
  end

  def test_array_access
    result = FluentPath.evaluate('Array[0]', ARRAY)
    assert result == 'A', 'Failed to navigate path.'
  end

  def test_array_access_with_variable
    result = FluentPath.evaluate('Array[index]', ARRAY)
    assert result == 'B', 'Failed to navigate path.'
  end

  def test_children_first
    expression = "children().element.first()" # .label.empty() and children().element.first().code.empty() and children().element.first().requirements.empty()"
    data = {
      'baseType' => 'Patient',
      'snapshot' => {
        'element' => [ITEM]
      }
    }
    result = FluentPath.evaluate(expression, data)
    assert result == ITEM, 'Failed to navigate children.'
  end

  def test_first
    expression = "list.first"
    data = { 'list' => LIST }
    result = FluentPath.evaluate(expression, data)
    assert result == LIST.first, 'Failed to access first element.'
  end

  def test_last
    expression = "list.last"
    data = { 'list' => LIST }
    result = FluentPath.evaluate(expression, data)
    assert result == LIST.last, 'Failed to access last element.'
  end

  def test_tail
    expression = "list.tail"
    data = { 'list' => LIST }
    result = FluentPath.evaluate(expression, data)
    assert result == LIST.last(LIST.length - 1), 'Failed to access tail elements.'
  end

  def test_count
    expression = "list.count"
    data = { 'list' => LIST }
    result = FluentPath.evaluate(expression, data)
    assert result == LIST.length, 'Failed to count elements.'
  end

  def test_parent
    expression = "$parent.type='integer' or $parent.type='decimal'"
    data = {}
    parent = { 'type' => 'integer' }
    result = FluentPath.evaluate(expression, data, parent)
    assert result == true, 'Failed to access parent.'
  end

  def test_parent_nil
    expression = "$parent.type='integer' or $parent.type='decimal'"
    data = {}
    result = FluentPath.evaluate(expression, data)
    assert result == false, 'Failed to gracefully handle no $parent.'
  end
end
