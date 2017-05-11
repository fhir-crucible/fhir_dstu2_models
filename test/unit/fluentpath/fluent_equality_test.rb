require_relative '../../test_helper'

class FluentEqualityTest < Test::Unit::TestCase
  def test_equals_strings
    data = {
      'a' => 'foo',
      'b' => 'foo'
    }
    result = FluentPath.evaluate('a = b', data)
    assert result == true, 'Failed equals test.'
  end

  def test_equals_numbers
    data = {
      'a' => 1.0,
      'b' => 1.0
    }
    result = FluentPath.evaluate('a = b', data)
    assert result == true, 'Failed equals test.'
  end

  def test_equals_dateTimes
    data = {
      'a' => '2016-06-06T10:55:34+01:00',
      'b' => '2016-06-06T10:55:34+01:00'
    }
    result = FluentPath.evaluate('a = b', data)
    assert result == true, 'Failed equals test.'
  end

  def test_not_equals_strings
    data = {
      'a' => 'foo',
      'b' => 'bar'
    }
    result = FluentPath.evaluate('a != b', data)
    assert result == true, 'Failed not_equals test.'
  end

  def test_not_equals_numbers
    data = {
      'a' => 1.0,
      'b' => 1.5
    }
    result = FluentPath.evaluate('a != b', data)
    assert result == true, 'Failed not_equals test.'
  end

  def test_not_equals_dateTimes
    data = {
      'a' => '2016-06-06T10:55:34+01:00',
      'b' => '2016-06-09T10:55:34+01:00'
    }
    result = FluentPath.evaluate('a != b', data)
    assert result == true, 'Failed not_equals test.'
  end

  def test_less_than_strings
    data = {
      'a' => 'a',
      'b' => 'b'
    }
    result = FluentPath.evaluate('a < b', data)
    assert result == true, 'Failed less_than test.'
  end

  def test_less_than_numbers
    data = {
      'a' => 1.0,
      'b' => 1.5
    }
    result = FluentPath.evaluate('a < b', data)
    assert result == true, 'Failed less_than test.'
  end

  def test_less_than_dateTimes
    data = {
      'a' => '2016-06-06T10:55:34+01:00',
      'b' => '2016-06-09T10:55:34+01:00'
    }
    result = FluentPath.evaluate('a < b', data)
    assert result == true, 'Failed less_than test.'
  end

  def test_greater_than_strings
    data = {
      'a' => 'd',
      'b' => 'b'
    }
    result = FluentPath.evaluate('a > b', data)
    assert result == true, 'Failed greater_than test.'
  end

  def test_greater_than_numbers
    data = {
      'a' => 1.9,
      'b' => 1.5
    }
    result = FluentPath.evaluate('a > b', data)
    assert result == true, 'Failed greater_than test.'
  end

  def test_greater_than_dateTimes
    data = {
      'a' => '2016-06-18T10:55:34+01:00',
      'b' => '2016-06-09T10:55:34+01:00'
    }
    result = FluentPath.evaluate('a > b', data)
    assert result == true, 'Failed greater_than test.'
  end

  def test_greater_than_equals_strings
    data = {
      'a' => 'd',
      'b' => 'b'
    }
    result = FluentPath.evaluate('a >= b', data)
    assert result == true, 'Failed greater_than_equals test.'
  end

  def test_greater_than_equals_numbers
    data = {
      'a' => 1.55,
      'b' => 1.5
    }
    result = FluentPath.evaluate('a >= b', data)
    assert result == true, 'Failed greater_than_equals test.'
  end

  def test_greater_than_equals_dateTimes
    data = {
      'a' => '2016-06-18T10:55:34+01:00',
      'b' => '2016-06-09T10:55:34+01:00'
    }
    result = FluentPath.evaluate('a >= b', data)
    assert result == true, 'Failed greater_than_equals test.'
  end

  # -------------------------------------- negative tests -----------------------------------------

  def test_equals_strings_false
    data = {
      'a' => 'foo',
      'b' => 'bar'
    }
    result = FluentPath.evaluate('a = b', data)
    assert result == false, 'Failed equals test.'
  end

  def test_equals_numbers_false
    data = {
      'a' => 1.0,
      'b' => 1.2
    }
    result = FluentPath.evaluate('a = b', data)
    assert result == false, 'Failed equals test.'
  end

  def test_equals_dateTimes_false
    data = {
      'a' => '2016-06-06T10:55:34+01:00',
      'b' => '2016-03-06T10:55:34+01:00'
    }
    result = FluentPath.evaluate('a = b', data)
    assert result == false, 'Failed equals test.'
  end

  def test_not_equals_strings_false
    data = {
      'a' => 'foo',
      'b' => 'foo'
    }
    result = FluentPath.evaluate('a != b', data)
    assert result == false, 'Failed not_equals test.'
  end

  def test_not_equals_numbers_false
    data = {
      'a' => 1.0,
      'b' => 1.0
    }
    result = FluentPath.evaluate('a != b', data)
    assert result == false, 'Failed not_equals test.'
  end

  def test_not_equals_dateTimes_false
    data = {
      'a' => '2016-06-06T10:55:34+01:00',
      'b' => '2016-06-06T10:55:34+01:00'
    }
    result = FluentPath.evaluate('a != b', data)
    assert result == false, 'Failed not_equals test.'
  end

  def test_less_than_strings_false
    data = {
      'a' => 'b',
      'b' => 'a'
    }
    result = FluentPath.evaluate('a < b', data)
    assert result == false, 'Failed less_than test.'
  end

  def test_less_than_numbers_false
    data = {
      'a' => 1.5,
      'b' => 1.0
    }
    result = FluentPath.evaluate('a < b', data)
    assert result == false, 'Failed less_than test.'
  end

  def test_less_than_dateTimes_false
    data = {
      'a' => '2016-06-09T10:55:34+01:00',
      'b' => '2016-06-06T10:55:34+01:00'
    }
    result = FluentPath.evaluate('a < b', data)
    assert result == false, 'Failed less_than test.'
  end

  def test_greater_than_strings_false
    data = {
      'a' => 'a',
      'b' => 'b'
    }
    result = FluentPath.evaluate('a > b', data)
    assert result == false, 'Failed greater_than test.'
  end

  def test_greater_than_numbers_false
    data = {
      'a' => 0.9,
      'b' => 1.5
    }
    result = FluentPath.evaluate('a > b', data)
    assert result == false, 'Failed greater_than test.'
  end

  def test_greater_than_dateTimes_false
    data = {
      'a' => '2016-06-09T10:55:34+01:00',
      'b' => '2016-06-18T10:55:34+01:00'
    }
    result = FluentPath.evaluate('a > b', data)
    assert result == false, 'Failed greater_than test.'
  end
end
