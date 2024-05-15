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
