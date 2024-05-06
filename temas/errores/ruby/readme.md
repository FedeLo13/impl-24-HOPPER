# Manejo de errores en Ruby

## Calculator.rb

Este archivo contiene una clase `Calculator` que proporciona métodos para realizar operaciones matemáticas básicas como suma, resta, multiplicación, división y potencia. Utiliza la biblioteca Sinatra para crear una aplicación web mínima que expone estas operaciones a través de una interfaz web.

### Métodos de la clase Calculator

- `divide(dividend, divisor)`: Divide el `dividend` por el `divisor` y devuelve el resultado. Maneja el caso en que el `divisor` es cero devolviendo `nil`.
- `sum(a, b)`: Suma `a` y `b` y devuelve el resultado.
- `subtract(a, b)`: Resta `b` de `a` y devuelve el resultado.
- `multiply(a, b)`: Multiplica `a` por `b` y devuelve el resultado.
- `power(base, exponent)`: Calcula la potencia de `base` elevado a `exponent`. Maneja el caso en que `exponent` es negativo y `base` es cero devolviendo `nil`.

### Manejo de Errores en Ruby

El código maneja errores utilizando declaraciones condicionales para verificar si los argumentos proporcionados a los métodos son numéricos. Si no lo son, devuelve `nil`. Además, en el método `divide` y `power`, se verifica si se está intentando dividir por cero o elevar cero a un exponente negativo, respectivamente, y devuelve `nil` en esos casos.

El manejo de errores en Ruby se realiza principalmente mediante el uso de declaraciones condicionales para verificar los tipos de datos de entrada y cualquier otro escenario que pueda causar errores en la ejecución del programa. Esto ayuda a evitar que el programa falle inesperadamente y permite controlar el flujo de ejecución en caso de errores.

## Uso de Optionals en Ruby

El concepto de Optionals no está presente de forma nativa en Ruby como lo está en algunos otros lenguajes de programación, como Swift o Kotlin. Sin embargo, se puede usar una gema de ruby llamada `optional` que realiza funciones similares. 

El uso de Optionals no es tan común en Ruby como en otros lenguajes debido a su estilo de programación más orientado a objetos y dinámico.

## Como desplegar la web de la calculadora

Para ello necesitamos ejecutar el terraform de la carpeta usando
```terraform
terraform init 
terraform apply
```
Ahora, una vez veamos que se ha desplegado accedemos a https:localhost:4567 
