require_relative '../../test_helper'

class MathTest < Test::Unit::TestCase
  DATA = {
    'x' => 7,
    'y' => 3,
    'foo' => 'a',
    'bar' => 'b'
  }

  def test_plus_vars
    result = FluentPath.evaluate('x + y', DATA)
    assert result == 10, 'Failed addition test.'
  end

  def test_plus_nums
    result = FluentPath.evaluate('5 + 5', DATA)
    assert result == 10, 'Failed addition test.'
  end

  def test_plus_vars_strings
    result = FluentPath.evaluate("foo + bar", DATA)
    assert result == 'ab', 'Failed addition test.'
  end

  def test_plus_strings
    result = FluentPath.evaluate("'Joe' + ' ' + 'Smith'", DATA)
    assert result == 'Joe Smith', 'Failed addition test.'
  end

  def test_minus_vars
    result = FluentPath.evaluate('x - y', DATA)
    assert result == 4, 'Failed subtraction test.'
  end

  def test_minus_nums
    result = FluentPath.evaluate('5 - 1', DATA)
    assert result == 4, 'Failed subtraction test.'
  end

  def test_divide_vars
    result = FluentPath.evaluate('x / y', DATA)
    assert result == 2, 'Failed division test.'
  end

  def test_divide_nums
    result = FluentPath.evaluate('6 / 3', DATA)
    assert result == 2, 'Failed division test.'
  end

  def test_multiply_vars
    result = FluentPath.evaluate('x * y', DATA)
    assert result == 21, 'Failed multiplication test.'
  end

  def test_multiply_nums
    result = FluentPath.evaluate('6 * 3', DATA)
    assert result == 18, 'Failed multiplication test.'
  end
end
