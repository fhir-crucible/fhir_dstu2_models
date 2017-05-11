require_relative '../../test_helper'

class AndOrNotTest < Test::Unit::TestCase
  def test_and_or_not
    data = {
      'name' => {
        'given' => %w(Joe John)
      },
      'gender' => 'male',
      'deceased' => false
    }
    result = FluentPath.evaluate('deceased.not() and ((name.given or name.family) and gender) and deceased.not()', data)
    assert result == true, 'Failed and_or_not test.'
  end

  def test_xor_tt
    data = {
      'a' => true,
      'b' => true
    }
    result = FluentPath.evaluate('a xor b', data)
    assert result == false, 'Failed xor test.'
  end

  def test_xor_tf
    data = {
      'a' => true,
      'b' => false
    }
    result = FluentPath.evaluate('a xor b', data)
    assert result == true, 'Failed xor test.'
  end

  def test_xor_ft
    data = {
      'a' => false,
      'b' => true
    }
    result = FluentPath.evaluate('a xor b', data)
    assert result == true, 'Failed xor test.'
  end

  def test_xor_ff
    data = {
      'a' => false,
      'b' => false
    }
    result = FluentPath.evaluate('a xor b', data)
    assert result == false, 'Failed xor test.'
  end

  def test_xor_tnil
    data = {
      'a' => true
    }
    result = FluentPath.evaluate('a xor b', data)
    assert result == true, 'Failed xor test.'
  end

  def test_xor_nilstring
    data = {
      'b' => 'foo'
    }
    result = FluentPath.evaluate('a xor b', data)
    assert result == true, 'Failed xor test.'
  end
end
