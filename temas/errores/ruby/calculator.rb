
# Calculator.rb

require 'optional'

class Calculator

    def divide(dividend, divisor)
        return None unless dividend.is_a?(Numeric) && divisor.is_a?(Numeric)
        return None if divisor == 0.0
        Some[dividend.to_f / divisor]
    end

    def sum(a, b)
        return None unless a.is_a?(Numeric) && b.is_a?(Numeric)
        Some[a + b]
    end

    def subtract(a, b)
        return None unless a.is_a?(Numeric) && b.is_a?(Numeric)
        Some[a - b]
    end

    def multiply(a, b)
        return None unless a.is_a?(Numeric) && b.is_a?(Numeric)
        Some[a * b]
    end

    def power(base, exponent)
        return None unless base.is_a?(Numeric) && exponent.is_a?(Numeric)
        return None if exponent < 0 && base == 0.0
        Some[base**exponent]
    end
end
