require_relative 'hablador'

class Persona
    include Hablador
    attr_accessor :nombre, :edad
    def initialize(nombre, edad)
        @nombre = nombre
        @edad = edad
    end

    def hablar
        puts "Hola, mi nombre es #{@nombre} y tengo #{@edad} años"
    end
end
