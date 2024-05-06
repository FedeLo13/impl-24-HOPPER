module Hablador
  def hablar
    raise NotImplementedError, "Debe implementarse en una clase"
  end
end

def hacer_hablar(Hablador)
  Hablador.hablar
end
