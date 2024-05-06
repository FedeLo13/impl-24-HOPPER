require_relative 'robot'
require_relative 'hablador'

class RobotInteligente < Robot
    include Hablador
    def initialize(nombre, material)
        super(nombre, material)
    end

    def objetivo
        puts "El objetivo del robot inteligente es comunicarse con los humanos y realizar cáculos complejos"
    end

    def hablar
        puts "HOLA. SOY. UN. ROBOT. INTELIGENTE. Y. PUEDO. HABLAR. CON. LOS. HUMANOS. MI. NOMBRE. ES. #{@nombre}"
    end

    def sumar(a, b)
        a + b
    end

    def restar(a, b)
        a - b
    end

    def multiplicar(a, b)
        a * b
    end

    def dividir(a, b)
        raise ZeroDivisionError, "NO. PUEDO. DIVIDIR. POR. CERO" if b.zero?
        a / b
    end
end