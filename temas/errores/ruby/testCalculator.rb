
require 'test/unit'
require_relative 'calculator'
require 'optional'


class TestCalculator < Test::Unit::TestCase
  def setup
    @calculator = Calculator.new
  end

  # divide tests
  def test_divide_by_zero
    assert_equal(None, @calculator.divide(1, 0))
  end

  def test_divide_by_non_numeric
    assert_equal(None, @calculator.divide(1, 'a'))
  end

  def test_divide_by_numeric
    assert_equal(Some[0.5], @calculator.divide(1, 2))
  end

  # sum tests

  def test_sum_non_numeric
    assert_equal(None, @calculator.sum(1, 'a'))
  end

  def test_sum_numeric
    assert_equal(Some[3], @calculator.sum(1, 2))
  end

  # subtract tests

  def test_subtract_non_numeric
    assert_equal(None, @calculator.subtract(1, 'a'))
  end

  def test_subtract_numeric
    assert_equal(Some[1], @calculator.subtract(2, 1))
  end

  # multiply tests

  def test_multiply_non_numeric
    assert_equal(None, @calculator.multiply(1, 'a'))
  end

  def test_multiply_numeric
    assert_equal(Some[2], @calculator.multiply(1, 2))
  end

  # power tests

  def test_power_non_numeric
    assert_equal(None, @calculator.power(1, 'a'))
  end

  def test_power_base_zero_exponent_negative
    assert_equal(None, @calculator.power(0, -1))
  end

  def test_power_base_non_zero_exponent_negative
    assert_equal(Some[0.5], @calculator.power(2, -1))
  end

  def test_power_base_zero_exponent_positive
    assert_equal(Some[4], @calculator.power(2, 2))
  end
end
