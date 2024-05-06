require 'minitest/autorun'
require_relative 'Adventure'

class TestAventura < Minitest::Test

  def setup
    @aventura = Aventura.new
    @heroe = Heroe.new
    @explorador = Explorador.new
    @mago = Mago.new
    @guerrero = Guerrero.new
    @personaje = PersonajeAccion.new
  end

  # 1. Acciones de un héroe
  def test_realizar_acciones_con_heroe

    expected_output = "¡La aventura ha comenzado!\nLuchando amateur\nNadando como un héroe\nVolando como un héroe\n¡La aventura ha terminado!\n"
    assert_output(expected_output) { @aventura.realizar_acciones(@heroe) }
  end

  # 2. Acciones de un explorador
  def test_realizar_acciones_con_explorador

    expected_output = "¡La aventura ha comenzado!\nLuchando como un personaje de acción\nNadando como un explorador\nVolando como un explorador\n¡La aventura ha terminado!\n"
    assert_output(expected_output) { @aventura.realizar_acciones(@explorador) }
  end

  # 3. Acciones de un mago
  def test_realizar_acciones_con_mago

    expected_output = "¡La aventura ha comenzado!\nLuchando como un personaje de acción\nVolando como un mago\n¡La aventura ha terminado!\n"
    assert_output(expected_output) { @aventura.realizar_acciones(@mago) }
  end

  # 4. Acciones de un guerrero
  def test_realizar_acciones_con_guerrero
    expected_output = "¡La aventura ha comenzado!\nLuchando como un guerrero\n¡La aventura ha terminado!\n"
    assert_output(expected_output) { @aventura.realizar_acciones(@guerrero) }
  end

  # 5. Acciones de un personaje sin habilidades

  def test_realizar_acciones_con_personaje_sin_habilidades

    expected_output = "¡La aventura ha comenzado!\nLuchando como un personaje de acción\n¡La aventura ha terminado!\n"
    assert_output(expected_output) { @aventura.realizar_acciones(@personaje) }
  end
end
