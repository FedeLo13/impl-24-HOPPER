
# delegacion.rb

# Modulo Instrumento

module Instrumento
  def initialize(nombre)
    @nombre = nombre
  end
  def afinar
    puts "Afinando #{@nombre} de #{self.class}"
  end

  def tocar
    puts "Tocando #{@nombre} de #{self.class}"
  end
end

# Clase Orquesta

class Orquesta
  include Enumerable

  def initialize
    @orquesta = []
  end

  def add_instrumento(instrumento)
    @orquesta << instrumento
  end

  def remove_instrumento(instrumento)
    @orquesta.delete(instrumento)
  end

  def each(&block)
    @orquesta.each(&block)
  end

  def tocar
    @orquesta.each { |instrumento| instrumento.tocar }
  end

  def afinar
    @orquesta.each do |instrumento|
      instrumento.afinar
      instrumento.tocar
    end
  end
end

# Clases de instrumentos
class Viento
  include Instrumento
  def initialize(nombre)
    @nombre = nombre
  end
  def to_s
    @nombre
  end
end

class Cuerda
  include Instrumento
  def initialize(nombre)
    @nombre = nombre
  end
  def to_s
    @nombre
  end
end

class Percusion
  include Instrumento
  def initialize(nombre)
    @nombre = nombre
  end
  def to_s
    @nombre
  end
end
