# Ejemplo de Abstracción en C#
En este ejemplo se pretende mostrar la forma en la que C# permite el uso de aspectos en la programación orientada a objetos. 
Un aspecto es una forma de implementar una acción que debe realizarse en el sistema cuando se lleven a cabo otros acontecimientos en el mismo. Los acontecimientos son, fundamentalmente, llamadas a métodos de clases diferentes. Así, cada vez que se llame a un método concreto de la clase
A o a un método concreto de la clase B, se desatará una acción indicada en el aspecto. Esto es de gran ayuda para eliminar la duplicación de código y facilitar que nuestro software sea más mantenible.

## Contexto del ejemplo
El ejemplo trata sobre una supuesta comisaría de policia o agencia federal, en la que se encuentran una serie de archivos policiales disponibles para su consulta. Por ahora, estos archivos policiales pueden ser archivos referentes a investigaciones o a juicios, y los policías pueden consultar sus detalles y pedir una revisión, en caso de que encuentren alguna posible incongruencia. Dado que la información es sensible, se desea tener un registro de todas las acciones que se llevan a cabo por parte de la policía.

## Problema
Para llevar a cabo el registro de todas las interacciones de los policías con los archivos sin usar aspectos, se debería hacer una llamada a un método "registrar" en todos los métodos que supongan una interacción. En principio sólo hay dos tipos de archivos y dos tipos de acciones a realizar con ellos, pero el sistema podría ampliarse en un futuro para admitir archivos sobre detenciones, patrullas, operaciones especiales. controles de tráfico, etc, y las acciones podrían ampliarse para que los policías puedan modificar los archivos, anotar precedentes, tomar notas extra... Hacer las llamadas específicas para cada método de cada archivo sería tedioso y crearía duplicación de código.

## Solución
Los aspectos solucionan el problema por completo. Con ellos se concreta la implementación de todas estas llamadas en una sóla clase, RegistroAspecto, en la que indicamos qué acción se realiza en cada momento, dependiendo del método que sea llamado. Tan sólo tenemos que añadir una etiqueta en los métodos de los archivos para que clase que implementa el aspecto pueda detectar cuando se llama, cuando acaba o cuando lanza una excepción el método correspondiente para realizar una acción un otra. 

En el caso de C#, tenemos que hacer uso de PostSharp para utilizar aspectos y heredar de la clase OnMethodBoundartAspect en la clase donde definimos las acciones que se llevarán a cabo al detectar las llamadas a los métodos elegidos.
