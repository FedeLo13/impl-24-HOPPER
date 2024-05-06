

require 'minitest/autorun'
require_relative 'Orquesta'

class TestOrquesta < Minitest::Test
  def setup
    @orquesta = Orquesta.new
    @viento = Viento.new("Flauta")
    @cuerda = Cuerda.new("Guitarra")
    @percusion = Percusion.new("Tambor")
  end

  def test_add_instrumento
    assert_empty @orquesta.to_a

    @orquesta.add_instrumento(@viento)
    assert_equal [@viento], @orquesta.to_a

    @orquesta.add_instrumento(@cuerda)
    assert_equal [@viento, @cuerda], @orquesta.to_a
  end

  def test_remove_instrumento
    @orquesta.add_instrumento(@viento)
    @orquesta.add_instrumento(@cuerda)
    assert_equal [@viento, @cuerda], @orquesta.to_a

    @orquesta.remove_instrumento(@viento)
    assert_equal [@cuerda], @orquesta.to_a
  end

  def test_tocar
    @orquesta.add_instrumento(@viento)
    @orquesta.add_instrumento(@cuerda)
    @orquesta.add_instrumento(@percusion)

    output = capture_io { @orquesta.tocar }
    assert_equal "Tocando Flauta de Viento\nTocando Guitarra de Cuerda\nTocando Tambor de Percusion\n", output.join
  end

  def test_afinar
    @orquesta.add_instrumento(@viento)
    @orquesta.add_instrumento(@cuerda)
    @orquesta.add_instrumento(@percusion)

    output = capture_io { @orquesta.afinar }
    assert_equal "Afinando Flauta de Viento\nTocando Flauta de Viento\nAfinando Guitarra de Cuerda\nTocando Guitarra de Cuerda\nAfinando Tambor de Percusion\nTocando Tambor de Percusion\n", output.join
  end
end
