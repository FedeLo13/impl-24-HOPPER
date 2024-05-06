require_relative 'hablador'

class Robot
    include Hablador

    # Definición de los métodos de acceso a las variables de instancia (con uso de symbols)
    attr_accessor :nombre
    attr_reader :material
    attr_writer :num_laseres

    # Constructor de la clase
    def initialize(nombre, material, num_laseres)
        @nombre = nombre
        @material = material
        @num_laseres = num_laseres
    end

    # Definición del método hablar del mixin Hablador, accesible desde cualquier parte del código
    def hablar
        "HOLA. SOY. UN. ROBOT. MI. NOMBRE. ES. #{@nombre} Y. ESTOY. HECHO. DE. #{@material}."
    end

    # Método de instancia, accesible desde cualquier parte del código
    def disparar_laser
        if @num_laseres > 0
            puts "PEW! "
            @num_laseres -= 1
        else
            puts "NO. TENGO. MAS. LASERES."
            recargar_laseres
        end
    end

    private

    # Método privado, solo accesible desde la clase
    def recargar_laseres
        puts "RECARGANDO. LASERES."
        laseres = rand(1..10)
        @num_laseres += laseres
        puts "RECARGA. COMPLETA. AHORA. TENGO. #{@num_laseres} LASERES."
    end
end