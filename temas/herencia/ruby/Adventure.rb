
# Adventure.rb

# Módulos
module SabeLuchar
  def luchar
    puts "Luchando amateur"
  end
end

module SabeNadar
  def nadar
    puts "Nadando amateur"
  end
end

module SabeVolar
  def volar
    puts "Volando amateur"
  end
end

# Personaje de acción

class PersonajeAccion
  def luchar
    puts "Luchando como un personaje de acción"
  end
end

# Héroe

class Heroe < PersonajeAccion
  include SabeLuchar
  include SabeVolar
  include SabeNadar
  def volar
    puts "Volando como un héroe"
  end
  def nadar
    puts "Nadando como un héroe"
  end
end

# Explorador

class Explorador < PersonajeAccion
  include SabeNadar
  include SabeVolar
  def volar
    puts "Volando como un explorador"
  end
  def nadar
    puts "Nadando como un explorador"
  end
end

# Mago

class Mago < PersonajeAccion
  include SabeVolar
  def volar
    puts "Volando como un mago"
  end
end

# Guerrero

class Guerrero < PersonajeAccion
  include SabeLuchar
  def luchar
    puts "Luchando como un guerrero"
  end
end

# Aventura

class Aventura
  def realizar_acciones(protagonista)
    puts "¡La aventura ha comenzado!"
    protagonista.luchar if protagonista.respond_to?(:luchar)
    protagonista.nadar if protagonista.respond_to?(:nadar)
    protagonista.volar if protagonista.respond_to?(:volar)
    puts "¡La aventura ha terminado!"
  end
end
