class Robot
    attr_accessor :nombre
    attr_reader :material

    def initialize(nombre, material)
        @nombre = nombre
        @material = material
        @acciones = []
    end
        
    def mover(direccion)
        @acciones << "Moviendo hacia #{direccion}"
    end

    def girar(direccion)
        @acciones << "Girando hacia #{direccion}"
    end

    def ejecutar_acciones
        @acciones.each do |accion|
            puts accion
        end
    end

    def objetivo
        raise NotImplementedError, "Debe implementar el método objetivo en la subclase"
    end
end