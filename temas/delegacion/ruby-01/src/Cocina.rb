require 'delegate'

class Horno
    def calentar(comida)
        puts "Calentando #{comida}"
    end
end

class Cocina
    delegate :calentar, to: :@horno

    def initialize(horno)
        @horno = horno
    end

    def cocinar(comida)
        puts "Preparando ingredientes..."
        calentar(comida)
        puts "El plato está listo"
    end
end