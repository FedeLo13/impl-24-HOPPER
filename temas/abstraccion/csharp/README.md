# Ejemplo de Abstracción en C#
En este ejemplo se pretende mostrar la forma en la que C# permite la programación orientada a objetos cumpliendo con el principio de abstracción.
La abstracción consiste, fundamentalmente, en la ocultación de ciertos aspectos entre las clases que intervienen en el programa, y es uno de los principios
báscios en la construcción del software orientado a objetos. Además, ayuda muchísimo a la reducción de dupliación de código y a la mantenibilidad del mismo.
Veremos como C# permite la abstracción en los atributos y en los métodos.

## Contexto del ejemplo
El ejemplo trata sobre un supuesto grupo de comunicación que gestiona publicaciones. En un principio se crea una clase publicación condos atributos básicos (fecha de publicación y
número de ejemplares) y un método, mostrarDetalles. El problema llega cuando el grupo de comunicación crece y comienza a gestionar dos tipos de publicación, libros y
revistas. Los libros tienen unos atributos diferentes a las revistas, y algunos en común. Por supuesto, el método mostrarDetalles debe mostrar información diferente en
el caso de los libros y en el de las revistas.

## Problema
Si no se aplica la abstracción de métodos, mostrarDetalles tendría que gestionar con un if-else la forma en la que se muestran los detalles, dependiendo de si se trata de
un Libro o de una revista. Esto hace que la mantenibilidad del código sea mucho menor, teniendo que acceder a la clase publicación cada vez que el grupo de comunicación
decida gestionar un nuevo tipo de publicación. Además, como no se utiliza en primera instancia la abstracción de atributos, los programadores "usuarios" de la clase
publicación pueden acceder a los atributos de la clase de forma directa (pérdida de encapsulamiento) y por tanto saben exactamente cómo están implementada la clase.

## Solución
Aplicando el principio de abstracción, podemos solucionar estos problemas. Así como en C y en Java, C# ofrece tres etiquetas para marcar la visibilidad de un atributo
en concreto. Las etiquetas son public, private y protected. Con public, la visibilidad del atributo o método es completa para cualquier clase del sistema. Con private,
ningún objeto excepto los de la misma clase pueden acceder al atributo o método. Con protected, los objetos de la clase y los de sus subclases pueden acceder al objeto.
Esto es ideal para aplicar la herencia protegida, que se emplea en el ejemplo. Así, las subclases Libro y Revista pueden acceder a los métodos comunes, pero la clase
externa prueba.cs no puede hacerlo.
En cuanto a la abstracción de métodos, dejamos a las subclases que realicen su propia implementación del método mostrarDetalles. C# permite esto con la sobreescritura
de métodos, en inglés Override. Las subclases pueden sobreescribir el método para que, dado un contenedor de publicaciones, los objetos ejecuten un método u otro en
función a su tipo sin necesidad de saber de qué subtipo es cada objeto. En este caso, se convierte a publicación en una clase abstracta, que no tiene construcción ni implementación del
método mostrarDetalles. 
