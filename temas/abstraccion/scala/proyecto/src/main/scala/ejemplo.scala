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
