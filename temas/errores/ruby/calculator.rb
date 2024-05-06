
# Calculator.rb

class Calculator

    def divide(dividend, divisor)
        return nil unless dividend.is_a?(Numeric) && divisor.is_a?(Numeric)
        return nil if divisor == 0
        dividend.to_f / divisor
    end

    def sum(a, b)
        return nil unless a.is_a?(Numeric) && b.is_a?(Numeric)
        a + b
    end

    def subtract(a, b)
        return nil unless a.is_a?(Numeric) && b.is_a?(Numeric)
        a - b
    end

    def multiply(a, b)
        return nil unless a.is_a?(Numeric) && b.is_a?(Numeric)
        a * b
    end

    def power(base, exponent)
        return nil unless base.is_a?(Numeric) && exponent.is_a?(Numeric)
        return nil if exponent < 0 && base == 0
        base ** exponent
    end
end
