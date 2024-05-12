# Manejo de errores en Ruby

## [Calculator.rb](calculator.rb)

Este archivo contiene una clase `Calculator` que proporciona métodos para realizar operaciones matemáticas básicas como suma, resta, multiplicación, división y potencia. Utiliza la biblioteca Sinatra para crear una aplicación web mínima que expone estas operaciones a través de una interfaz web.

### Métodos de la clase Calculator


- `divide(dividend, divisor)`: Divide el `dividend` por el `divisor` y devuelve el resultado. Maneja el caso en que el `divisor` es cero devolviendo `nil`.
- `sum(a, b)`: Suma `a` y `b` y devuelve el resultado.
- `subtract(a, b)`: Resta `b` de `a` y devuelve el resultado.
- `multiply(a, b)`: Multiplica `a` por `b` y devuelve el resultado.
- `power(base, exponent)`: Calcula la potencia de `base` elevado a `exponent`. Maneja el caso en que `exponent` es negativo y `base` es cero devolviendo `nil`.

### Manejo de Errores en Ruby
El código maneja errores usando la librería Optional en Ruby, esta librería te proporciona una alternativa al uso del `nil` como manera de indicar que ha ocurrido un error en alguna parte del programa. 

Esta librería usa los métodos `Some` que indica que no ha ocurrido ningún error y `None` en el caso contrario, de esta manera es el usuario el que mediante `some?` o `none?` quien decide que hacer en los casos donde ha ocurrido un error.

Un ejemplo a esto último se puede observar en el fichero : [`streams.rb`](streams.rb)

Para ejecutarlo nos debemos situar en el directorio donde se encuentra el archivo y poner el siguiente comando:

```
ruby streams.rb
```
A continuación se podrá ver las salidas de todas las divisiones válidas que ejecuta y el resultado del array final sólo con las diviones válidas.

# Construir programa y pruebas
Para verificar la corrección del ejemplo se han desarrollado unas pruebas, en ruby usamos para ello la gema `test/unit` que permite hacer test simples y precisos de nuestro código.
La prueba la puede ver desde aquí directamente con este enlace: [Tests](testCalculator.rb)

Para construir el programa y las pruebas se ha desarrollado un github Action, puede runnearlo manualmente desde
el siguiente enlace : [Action](../../../.github/workflows/errores.ruby.yml)


## Como desplegar la web de la calculadora

Para ello necesitamos ejecutar el terraform (que despliega un Dockerfile) de la carpeta usando

```terraform
terraform init 
terraform apply
```
Ahora, una vez veamos que se ha desplegado accedemos a `https:localhost:4567 ``

Cuando se requiera dejar el puerto libre, se deberá eliminar el contenedor de docker que ejecuta la imagen con el comando
`docker container stop <nombre-contenedor>`
`docker container rm <nombre-contenedor>`

