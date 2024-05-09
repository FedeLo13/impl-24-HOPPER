module Tropa
    def initialize(nombre)
        @nombre = nombre 
    end

    def atacar
        puts "#{self.class} #{@nombre} avanza y ataca al enemigo"
    end

    def defender
        puts "#{self.class} #{@nombre} se retira a defender la base"
    end

    def usar_habilidad
        raise NotImplementedError 'Debe implementarse en una clase'
    end
end

class Clan
    include Enumerable
  
    attr_accessor :tropas_ataque, :tropas_defensa

    def initialize
        @tropas_ataque = []
        @tropas_defensa = []
    end
  
    # Métodos para agregar y remover tropas
    def add_tropa_ataque(tropa)
        @tropas_ataque << tropa
    end
  
    def add_tropa_defensa(tropa)
        @tropas_defensa << tropa
    end
  
    def remove_tropa_ataque(tropa)
        @tropas_ataque.delete(tropa)
    end
  
    def remove_tropa_defensa(tropa)
        @tropas_defensa.delete(tropa)
    end
  
    # Método para iterar sobre las tropas
    def each(&block)
        @tropas_ataque.each(&block)
        @tropas_defensa.each(&block)
    end

    def atacar
        @tropas_ataque.each do |tropa|
            tropa.atacar
            tropa.usar_habilidad
        end
    end

    def defender
        @tropas_defensa.each do |tropa|
            tropa.defender
            tropa.usar_habilidad
        end
    end
end

class Bruja
    include Tropa
    def initialize(nombre)
        @nombre = nombre
    end

    # Implementación del método usar_habilidad del módulo Tropa
    def usar_habilidad
        puts "#{self.class} #{@nombre} lanza una bola de fuego al enemigo"
    end

    def to_s
        @nombre
    end
end

class Arquera
    include Tropa
    def initialize(nombre)
        @nombre = nombre
    end

    # Implementación del método usar_habilidad del módulo Tropa
    def usar_habilidad
        puts "#{self.class} #{@nombre} dispara una flecha envenenada al enemigo"
    end

    def to_s
        @nombre
    end
end

class Gigante
    include Tropa
    def initialize(nombre)
        @nombre = nombre
    end

    # Implementación del método usar_habilidad del módulo Tropa
    def usar_habilidad
        puts "#{self.class} #{@nombre} golpea al enemigo con su maza"
    end

    def to_s
        @nombre
    end
end


