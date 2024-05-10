require 'minitest/autorun' # Requiere la gema Minitest y carga las asunciones por defecto
require_relative '../src/Cocina' # Requiere el archivo que se va a probar

class CocinaTest < Minitest::Test
    def setup
        @horno = Horno.new
        @cocina = Cocina.new(@horno)
    end

    def test_calentar
        assert_output("Calentando pizza\n") { @cocina.calentar("pizza") }
    end

    def test_cocinar
        assert_output("Preparando ingredientes...\nCalentando pizza\nEl plato está listo\n") { @cocina.cocinar("pizza") }
    end
end