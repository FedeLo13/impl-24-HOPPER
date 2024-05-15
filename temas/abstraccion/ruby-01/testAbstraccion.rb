require 'minitest/autorun'
require_relative 'abstraccion.rb'

class FiguraTest < Minitest::Test
  def test_rectangulo_area
    rectangulo = Figura::Rectangulo.new(5, 10)
    assert_equal 50, rectangulo.area
  end

  def test_rectangulo_perimetro
    rectangulo = Figura::Rectangulo.new(5, 10)
    assert_equal 30, rectangulo.perimetro
  end

  def test_circulo_area
    circulo = Figura::Circulo.new(3)
    assert_in_delta 28.27, circulo.area, 0.01
  end

  def test_circulo_perimetro
    circulo = Figura::Circulo.new(3)
    assert_in_delta 18.85, circulo.perimetro, 0.01
  end

  def test_triangulo_area
    triangulo = Figura::Triangulo.new(4, 6, 2, 5, 7)
    assert_equal 12, triangulo.area
  end

  def test_triangulo_perimetro
    triangulo = Figura::Triangulo.new(4, 6, 2, 5, 7)
    assert_equal 14, triangulo.perimetro
  end
end
