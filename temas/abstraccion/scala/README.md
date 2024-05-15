# Abstraccion en Scala

## Introducción
Bienvenido al repositorio sobre Abstraccion en Scala. Aquí encontrarás información detallada sobre cómo utilizar la Abstraccion en Scala para escribir código más limpio y eficiente.

## Estructura de Directorio
- `/README.md`: Archivo actual.
- `/proyecto`: Directorio que representa la raiz de nuestro proyecto.
- `/proyecto/build.sbt`: Archivo sbt donde añadiremos las dependencias y versiones de nuestro proyecto
- `/proyecto/src/main/scala/ejemplo.scala`: Archivo scala donde se encuentra el codigo de nuestro ejemplo.
- `/proyecto/src/main/scala/tests.scala`: Archivo scala donde se encuentra los tests de nuestro ejemplo.


## Conceptos Previos
Antes de explorar los ejemplos proporcionados en este repositorio, es fundamental entender algunos conceptos clave de abstracción en Scala, un lenguaje que combina programación orientada a objetos y funcional. Scala utiliza varios mecanismos para implementar abstracción, incluyendo `traits`, `abstract classes`, y `mixin composition`. Aquí se detallan varios usos y técnicas que se emplean en el código de ejemplo:

- **Traits**:
  Scala utiliza `traits` como una herramienta principal para la abstracción. Un trait en Scala puede contener tanto métodos abstractos sin implementación como métodos implementados:
  - **Volador**: Define un método abstracto `fecha()` que las clases deben implementar, permitiendo abstraer la especificación de la fecha. También proporciona un método concreto `volar()`, mostrando cómo los traits pueden incluir implementación.
  - **Nadador y Caminante**: Ambos traits proporcionan implementaciones concretas de métodos que pueden ser incorporados en cualquier clase que los adopte, demostrando cómo Scala permite reutilizar funcionalidad de forma flexible.

- **Clases Abstractas**:
  Aunque no se utilizan directamente en el ejemplo proporcionado, las clases abstractas en Scala son otra herramienta clave para la abstracción. Permiten definir tanto métodos que deben ser implementados por las subclases como proporcionar implementación completa de otros métodos. Son útiles cuando se necesita una base sólida que requiera que algunas funcionalidades sean personalizadas por las clases derivadas.

- **Mixin Composition**:
  Scala destaca en su capacidad para componer comportamientos a través de la mezcla de múltiples traits en una sola clase, conocido como mixin composition. Esto permite a los desarrolladores combinar múltiples traits para construir una clase con comportamientos específicos de manera dinámica y flexible:
  
- **Polimorfismo y Overriding**:
  En Scala, el polimorfismo se maneja a través de la sobrecarga de métodos (`overriding`). Las clases o traits pueden sobreescribir métodos heredados para proporcionar comportamientos especializados manteniendo una interfaz consistente.
  
- **Implementación Deferida**:
  Los traits y las clases abstractas en Scala permiten la implementación diferida de métodos, donde la implementación de algunos métodos se puede dejar indefinida hasta que otra clase o trait proporcione detalles concretos.

Este repositorio ilustra cómo se pueden emplear los conceptos de abstracción en Scala para crear sistemas robustos y flexibles que separan eficazmente las responsabilidades y facilitan la extensión y modificación del comportamiento de software sin alterar la arquitectura subyacente.


## Código de Ejemplo
A continuación, se muestra el ejemplo de cómo se pueden usar la abstracción en Scala:
[**ejemplo.java**](ejemplo.java)

```scala
package ejemplo

// Definición de los traits
trait Volador {
  def fecha(): String
  def volar(): String = "¡Estoy volando!"
  //def saludo(): String = "Hola, sé volar"
}

trait Nadador {
  def nadar(): String = "¡Estoy nadando!"
  //def saludo(): String = "Hola, sé nadar"
}

trait Caminante {
  def caminar(): String = "¡Estoy caminando!"
  def saludo(): String = "Hola, sé andar"

}

// Clase que hereda de los tres traits
class Animal extends Volador with Nadador with Caminante {
  override def fecha(): String = "¡Hoy es jueves!"
}

class Mamifero {
  def reproduccion(): String = "Soy mamifero!"
}

// Objeto singleton Main
object Main {
  def main(args: Array[String]): Unit = {
    val animal = new Animal
    val ballena = new Mamifero with Nadador

    println(animal.volar())    // El animal puede volar
    println(animal.nadar())    // El animal puede nadar
    println(animal.caminar())  // El animal puede caminar
    println(animal.fecha())

    println(ballena.nadar())
    println(ballena.reproduccion())
  }
}

```
## Métodos Usados en el Ejemplo

Este ejemplo demuestra cómo Scala utiliza `traits` para implementar la programación orientada a aspectos de manera que permite una composición flexible y modular de comportamientos. A continuación, se detallan los métodos y `traits` utilizados:

`trait Volador`:
- **`fecha()`**: Método abstracto que las clases que implementan este `trait` deben definir. Proporciona una manera de especificar la fecha actual o relevante para la instancia.
- **`volar()`**: Método implementado que retorna un string indicando que el sujeto está volando. Este método es un ejemplo de cómo un `trait` puede proporcionar implementación que todas las clases que lo implementan heredarán.

`trait Nadador`:
- **`nadar()`**: Método implementado que proporciona la capacidad de nadar. Retorna un string que describe la acción de nadar, mostrando la simplicidad con la que los `traits` pueden añadir funcionalidades concretas a las clases.

`trait Caminante`:
- **`caminar()`**: Método que permite a la clase caminar, devolviendo un string descriptivo.
- **`saludo()`**: Método que retorna un saludo genérico, "Hola, sé andar", ilustrando cómo los `traits` pueden también incluir comportamientos interactivos.

`class Animal`:
- **Herencia de `Volador`, `Nadador`, `Caminante`**: Esta clase muestra cómo Scala permite la combinación de múltiples `traits` para formar una clase polifacética que puede volar, nadar y caminar.
- **`fecha()`**: Sobrescritura del método `fecha()` para devolver una fecha específica, demostrando cómo las clases pueden personalizar comportamientos abstractos definidos en `traits`.

`class Mamifero` con `Nadador`:
- **`reproduccion()`**: Método específico de los mamíferos que indica su característica reproductiva.
- **Mixin con `Nadador` en tiempo de ejecución**: Ejemplo de cómo Scala permite la mezcla dinámica de `traits`, demostrando flexibilidad en la composición de clases. La instancia `ballena` de `Mamifero` adquiere la capacidad de nadar mediante este mixin.

Objeto `Main`:
- Utiliza instancias de `Animal` y `Mamifero` para demostrar los comportamientos adquiridos a través de `traits`.
- Muestra cómo las instancias interactúan con los métodos definidos y heredados de los `traits`, ofreciendo una vista práctica de la polivalencia y la reutilización de código.

Este código ejemplifica el poder de los `traits` de Scala para facilitar la programación modular y reutilizable, permitiendo la construcción de entidades complejas a partir de componentes simples y reutilizables. Esta flexibilidad es central para la abstracción en Scala, permitiendo a los desarrolladores construir sistemas extensibles con facilidades para el mantenimiento y la evolución.

## Código de tests
Ahora, se muestra los tests para probar la corrección del ejemplo:
[**tests.scala**](tests.scala)

```scala
package ejemplo

import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers

// Importa las clases que quieres probar
import ejemplo.{Animal, Mamifero, Volador, Caminante, Nadador}

class AnimalSpec extends AnyFlatSpec with Matchers {

  "An Animal" should "fly" in {
    val animal = new Animal with Volador
    animal.volar() shouldBe "¡Estoy volando!" 
  }

  it should "swim" in {
    val animal = new Animal with Nadador
    animal.nadar() shouldBe "¡Estoy nadando!"
  }

  it should "walk" in {
    val animal = new Animal with Caminante
    animal.caminar() shouldBe "¡Estoy caminando!"
  }

  it should "have today's date" in {
    val animal = new Animal
    animal.fecha() shouldBe "¡Hoy es jueves!" 
  }

  "A Mamifero" should "swim" in {
    val ballena = new Mamifero with Nadador
    ballena.nadar() shouldBe "¡Estoy nadando!"
  }

  it should "reproduce" in {
    val ballena = new Mamifero
    ballena.reproduccion() shouldBe "Soy mamifero!"
  }
}
```
El sistema de gestión de proyectos utilizado en el código es **SBT (Simple Build Tool)**, una herramienta de software para la gestión y construcción de proyectos Scala y Java. SBT simplifica el proceso de construcción del proyecto, incluyendo la compilación del código, la ejecución de pruebas y el empaquetado del resultado final en formatos distribuibles como JARs. Utiliza un archivo de configuración `build.sbt` junto con archivos en el directorio `project/` para gestionar dependencias de bibliotecas, configuraciones de compilación y plugins, incluidos los necesarios para ejecutar pruebas unitarias.

SBT integra soporte para ejecutar pruebas automáticamente durante el proceso de construcción utilizando frameworks de pruebas como ScalaTest o specs2 para proyectos Scala, o JUnit para proyectos Java. Al definir las dependencias y configurar los ajustes adecuados en el archivo `build.sbt`, SBT puede compilar el proyecto y ejecutar todas las pruebas unitarias definidas, garantizando que el software cumpla con los requisitos especificados antes de cualquier despliegue o entrega. Esto asegura una integración continua eficiente y efectiva, y es esencial para mantener la calidad del código en desarrollos colaborativos y dinámicos.

Aquí vemos el archivo `build.sbt`:
[**build.sbt**](build.sbt)
```sbt
name := "proyecto"

version := "0.1"

scalaVersion := "3.4.1"

// Agregar dependencias del proyecto
libraryDependencies ++= Seq(
  "org.typelevel" %% "cats-core" % "2.7.0",
  "org.scalatest" %% "scalatest" % "3.2.10" % Test
)
``` 

Configuración del Proyecto Sbt en `build.sbt`:
El archivo `build.sbt` define la estructura y configuración de gestión del proyecto Scala, utilizando SBT (Simple Build Tool) para manejar dependencias, compilar el proyecto y ejecutar pruebas. Aquí se detallan los aspectos clave del archivo:

- **Información del Proyecto**:
  - `name`: Especifica el nombre del proyecto, en este caso, `proyecto`.
  - `version`: Define la versión del artefacto que SBT construirá, aquí es `0.1`.
  - `scalaVersion`: Establece la versión de Scala utilizada en el proyecto, en este caso, `3.4.1`, asegurando que el código fuente sea compatible con esta versión específica del lenguaje.

- **Dependencias**:
  - **Cats-core**: Se incluye como dependencia del proyecto para proporcionar una biblioteca de abstracciones funcionales que facilitan la programación funcional en Scala. La versión especificada es `2.7.0`.
  - **ScalaTest**: Se utiliza para escribir y ejecutar pruebas unitarias en el proyecto Scala, especificado con el modificador `Test`, indicando que esta biblioteca se utiliza solo durante la fase de testeo. La versión utilizada es `3.2.10`.

- **Configuración de Dependencias**:
  - `libraryDependencies`: Este bloque configura todas las bibliotecas externas requeridas por el proyecto, asegurando que se resuelvan y descarguen automáticamente durante el proceso de compilación y prueba.

Este archivo `build.sbt` es fundamental para el manejo eficiente del ciclo de vida del proyecto Scala, desde la compilación hasta la ejecución de pruebas, garantizando que todos los componentes se integren adecuadamente bajo la configuración especificada. SBT facilita la gestión de proyectos Scala al automatizar la configuración del entorno de desarrollo y producción, simplificando la compilación y la integración de bibliotecas externas.

## Ejecución desde una Terminal

Para ejecutar el código y los tests en un proyecto Scala utilizando SBT desde una terminal, sigue estos pasos detallados que incluyen la descarga del código, instalación de Java JDK, Scala, y SBT, y ejecución de los tests:

### 1. Instalación de Java JDK 17
#### Primero, asegúrate de que Java JDK 17 está instalado en tu sistema.
#### Puedes descargar e instalar Java JDK desde:
#### https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html
#### Sigue las instrucciones específicas para tu sistema operativo.
```bash
java -version
```
#### Esto debería mostrar la versión de Java JDK 17 instalada.

### 2. Instalación de Scala
#### Asegúrate de que tienes Scala instalado, necesario para correr y compilar proyectos Scala.
#### Puedes descargar Scala desde:
#### https://www.scala-lang.org/download/
#### Sigue las instrucciones para configurar Scala en tu sistema.
```bash
scala -version
```
#### Esto mostrará la versión de Scala y confirmará que está correctamente instalado.

### 3. Instalación de SBT
#### Necesitas tener SBT para gestionar el proyecto y ejecutar los tests.
#### Puedes descargar SBT desde:
#### https://www.scala-sbt.org/download.html
#### Sigue las instrucciones de instalación en:
#### https://www.scala-sbt.org/1.x/docs/Setup.html
```bash
sbt sbtVersion
```
# Esto mostrará la versión de SBT y confirmará que está correctamente instalado.

### 4. Clonar el Repositorio
#### Si el código está disponible en GitHub, puedes clonar el repositorio utilizando Git.
#### Si aún no tienes Git instalado, puedes descargarlo desde:
#### https://git-scm.com/downloads
```bash
git clone https://github.com/sistemas-sw/impl-24.git
```

### 5. Cambiar al Directorio del Repositorio
#### Una vez clonado el repositorio, navega al directorio donde se encuentra el código:
```bash
cd impl-24/temas/aspectos/scala/proyecto
```

### 6. Ejecutar los Tests con SBT
#### Finalmente, puedes ejecutar los tests utilizando SBT.
```bash
sbt clean
```
```bash
sbt test
```
#### Estos comandos limpiarán cualquier compilación anterior y ejecutarán todos los tests definidos, mostrando los resultados en la terminal.
