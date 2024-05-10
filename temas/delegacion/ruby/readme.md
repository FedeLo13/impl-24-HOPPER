
# Delegación en Ruby
## Ejemplo 

Este proyecto muestra un ejemplo de una orquesta en Ruby, donde se utilizan mecanismos propios del lenguaje como `module` y `proc`.

En Ruby, un `module` es una colección de métodos y constantes. Puedes usarlos para agrupar funcionalidades relacionadas y luego incluir ese módulo en otras clases para extender su funcionalidad. 

Como en este ejemplo:
```ruby
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
```

Por otro lado, un`proc` (procedimiento) es un bloque de código que puede ser almacenado en una variable y luego ser llamado más tarde.

Un ejemplo es  el método `tocar()` y `afinar()` de la siguiente clase:

```ruby
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
```
## Explicación

El proyecto consta de varias clases que representan diferentes elementos de una orquesta:

- `Instrumento`: Un módulo que define métodos comunes para todos los instrumentos, como `afinar` y `tocar`.
- `Orquesta`: Una clase que gestiona los instrumentos, permitiendo agregar, eliminar, afinar y tocar los instrumentos.
- Clases de instrumentos específicos (`Viento`, `Cuerda`, `Percusion`): Cada una de estas clases incluye el módulo `Instrumento` y define un método `to_s` para representar el nombre del instrumento.

```ruby
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
```

## Dinamismo del include
En Ruby, los módulos y clases se pueden cargar dinámicamente en tiempo de ejecución. Esto significa que no es necesario cargar todo el código al principio; puedes agregarlo según sea necesario. 

Por ejemplo, si tienes una aplicación que utiliza plugins o extensiones, puedes cargar esos módulos solo cuando el usuario activa una función específica.

Cuando usas `include` para mezclar un módulo en una clase, estás agregando dinámicamente los métodos y funciones definidos en ese módulo a la clase. Esto permite que las instancias de la clase accedan a esa funcionalidad adicional sin necesidad de heredar de una clase base específica.

## Desplegar Web

Para desplegar la web necesitamos ejecutar el terraform (que despliega el Dockerfile) con estos comandos:


```terraform
terraform init
terraform apply
```
Una vez que Terraform haya completado el despliegue, la web estará disponible en la siguiente dirección: 

`https:localhost/4568`

En caso de querer dejar libre el puerto, es necesario parar y eliminar el contenedor docker.

