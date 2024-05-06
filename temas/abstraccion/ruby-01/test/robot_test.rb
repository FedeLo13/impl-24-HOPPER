require 'minitest/autorun'
require_relative '../src/robot'

class RobotTest < Minitest::Test
    def setup
        @robot = Robot.new("R2D2", "METAL", 5)
    end

    def test_hablar
        assert_output(/HOLA. SOY. UN. ROBOT. MI. NOMBRE. ES. R2D2 Y. ESTOY. HECHO. DE. METAL./) { @robot.hablar }
    end

    def test_saludar
        assert_output(/HOLA!/) { @robot.saludar }
    end

    def test_disparar_laser
        assert_output(/PEW! /) { @robot.disparar_laser }
        assert_equal 4, @robot.num_laseres
    end

    def test_recargar_laseres
        @robot.disparar_laser until @robot.num_laseres.zero?  # Dispara todos los láseres
        # Llamar a disparar_laser cuando no hay láseres debería recargar al menos 1
        assert_output(/RECARGANDO. LASERES.\nRECARGA. COMPLETA. AHORA. TENGO. \d+ LASERES./) { @robot.disparar_laser }
        assert_operator @robot.num_laseres, :>, 0
    end
end