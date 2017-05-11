require_relative '../../test_helper'

class ExistenceTest < Test::Unit::TestCase
  NAMES = %w(Bob Robert)
  PATIENT = {
    'name' => {
      'given' => NAMES
    },
    'deceasedBoolean' => false,
    'aliveBoolean' => true,
    'all_true' => [true, true, true],
    'some_true' => [false, true, false],
    'codes' => %w(A A B),
    'numbers' => [0.1, 0.1, 1, -2],
    'resourceType' => 'Patient'
  }

  # ------------------------- empty() -------------------------------------
  def test_empty_false
    result = FluentPath.evaluate('Patient.name.given.empty()', PATIENT)
    assert result == false, 'Failed empty test.'
  end

  def test_empty_true
    result = FluentPath.evaluate('Patient.name.family.empty()', PATIENT)
    assert result == true, 'Failed empty test.'
  end

  # ------------------------- not() -------------------------------------
  def test_not_true
    result = FluentPath.evaluate('Patient.deceasedBoolean.not()', PATIENT)
    assert result == true, 'Failed not test.'
  end

  def test_not_false
    result = FluentPath.evaluate('Patient.aliveBoolean.not()', PATIENT)
    assert result == false, 'Failed not test.'
  end

  def test_not_empty
    result = FluentPath.evaluate('Patient.doesNotExist.not()', PATIENT)
    assert result == true, 'Failed not test.'
  end

  def test_not_notempty
    result = FluentPath.evaluate('Patient.name.given.not()', PATIENT)
    assert result == false, 'Failed not test.'
  end

  # ------------------------- exists() -------------------------------------
  def test_exists_true
    result = FluentPath.evaluate('Patient.name.given.exists()', PATIENT)
    assert result == true, 'Failed exists test.'
  end

  def test_exists_false
    result = FluentPath.evaluate('Patient.name.family.exists()', PATIENT)
    assert result == false, 'Failed exists test.'
  end

  # ------------------------- all() -------------------------------------
  def test_all_true
    result = FluentPath.evaluate('Patient.all_true.all()', PATIENT)
    assert result == true, 'Failed all test.'
  end

  def test_all_false
    result = FluentPath.evaluate('Patient.some_true.all()', PATIENT)
    assert result == false, 'Failed all test.'
  end

  # ------------------------- subsetOf([]) -------------------------------------
  # ------------------------- supersetOf([]) -------------------------------------
  # ------------------------- isDistinct() -------------------------------------
  # ------------------------- distinct() -------------------------------------
  def test_distinct_strings
    result = FluentPath.evaluate('Patient.codes.distinct()', PATIENT)
    assert result == %w(A B), 'Failed distinct test.'
  end

  def test_distinct_numbers
    result = FluentPath.evaluate('Patient.numbers.distinct()', PATIENT)
    assert result == [0.1, 1, -2], 'Failed distinct test.'
  end

  def test_distinct_booleans
    result = FluentPath.evaluate('Patient.some_true.distinct()', PATIENT)
    assert result == [false, true], 'Failed distinct test.'
  end

  # ------------------------- count() -------------------------------------
  # ------------------------- in -------------------------------------
  def test_in_numbers
    data = {
      'foo' => 2,
      'set' => [1, 2, 3]
    }
    result = FluentPath.evaluate('foo in set', data)
    assert result == true, 'Failed in_numbers test.'
  end

  def test_in_strings
    data = {
      'foo' => 'B',
      'set' => %w(A B C)
    }
    result = FluentPath.evaluate('foo in set', data)
    assert result == true, 'Failed in_strings test.'
  end

  def test_in_booleans
    data = {
      'foo' => true,
      'set' => [false, true, false]
    }
    result = FluentPath.evaluate('foo in set', data)
    assert result == true, 'Failed in_booleans test.'
  end

  def test_in_numbers_false
    data = {
      'foo' => 5,
      'set' => [1, 2, 3]
    }
    result = FluentPath.evaluate('foo in set', data)
    assert result == false, 'Failed in_numbers_false test.'
  end

  def test_in_strings_false
    data = {
      'foo' => 'D',
      'set' => %w(A B C)
    }
    result = FluentPath.evaluate('foo in set', data)
    assert result == false, 'Failed in_strings_false test.'
  end

  def test_in_booleans_false
    data = {
      'foo' => true,
      'set' => [false, false]
    }
    result = FluentPath.evaluate('foo in set', data)
    assert result == false, 'Failed in_booleans_false test.'
  end

  # ------------------- set creation ------------------------
  def test_set_creation
    data = {}
    result = FluentPath.evaluate("('A'|'B'|'C')", data)
    assert result == %w(A B C), 'Failed set creation.'
  end
end
