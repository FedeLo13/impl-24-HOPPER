# Abstracción en Ruby #
## Ejemplo ##
Este ejemplo trata sobre un módulo `Figura` que encapsula cada figura geométrica, `Rectángulo`, `Círculo` y `Triángulo`, en clases independientes. Cada clase proporciona métodos para calcular el área y el perímetro de su respectiva figura, ocultando los detalles de implementación y simplificando su uso. El ejemplo se encuentra aquí [abstraccion.rb](abstraccion.rb).


## Explicación ##
El código se compone de un module Figura con tres clases distintas cada una con los métodos de área y perímetro:
- Rectangulo
- Circulo
- Triangulo

La abstracción se logra al encapsular la lógica de cálculo de cada figura geométrica en clases separadas, lo que permite tratar cada figura como una entidad independiente y simplifica su uso en otras partes del código.

El módulo `Figura` sirve como contenedor para organizar las clases relacionadas, lo que facilita la agrupación y el acceso a estas clases dentro del código.

La interfaz pública de cada clase oculta los detalles de implementación lo que permite a otras personas utilizar estas clases sin necesidad de conocer cómo se realizan los cálculos internamente.
```ruby
module Figura
  class Rectangulo
    attr_reader :ancho, :alto

    def initialize(ancho, alto)
      @ancho = ancho
      @alto = alto
    end

    def area
      @ancho * @alto
    end

    def perimetro
      2 * (@ancho + @alto)
    end
  end

  class Circulo
    attr_reader :radio

    def initialize(radio)
      @radio = radio
    end

    def area
      Math::PI * @radio**2
    end

    def perimetro
      2 * Math::PI * @radio
    end
  end

  class Triangulo
    attr_reader :base, :altura, :lado1, :lado2, :lado3

    def initialize(base, altura, lado1, lado2, lado3)
      @base = base
      @altura = altura
      @lado1 = lado1
      @lado2 = lado2
      @lado3 = lado3
    end

    def area
      0.5 * @base * @altura
    end

    def perimetro
      @lado1 + @lado2 + @lado3
    end
  end
end
```

# Construir programa y pruebas #

Para verificar la corrección del ejemplo se han desarrollado unas pruebas, en ruby usamos para ello la gema `minitest` que permite, entre otras cosas, comparar flujos de salida. La prueba la puede ver desde aquí directamente con este enlace: [Tests](testAbstraccion.rb)

Para construir el programa y las pruebas se ha desarrollado un github Action, puede runnearlo manualmente desde el siguiente enlace : [Action](../../../.github/workflows/abstraccion.ruby-01.yml).

## Desplegar Web

Para desplegar la web necesitamos ejecutar el terraform (que despliega el [Dockerfile](Dockerfile)) con estos comandos:


```terraform
terraform init
terraform apply
```

Enlace al archivo [Terraform](Abstraccion.tf).

Una vez que Terraform haya completado el despliegue, la web estará disponible en la siguiente dirección: 

`https:localhost/4568`

En caso de querer dejar libre el puerto, es necesario parar y eliminar el contenedor Docker. Puede utilizar el comando `terraform destroy` para eliminar el contenedor Docker.
