module Hablador
  def hablar
    raise NotImplementedError, "Debe implementarse en una clase"
  end

  def saludar
    puts "HOLA!"
  end
end
