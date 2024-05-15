import unittest
from ejemplo import *

class TestAnimales(unittest.TestCase):
    def test_instancias(self):
        aguila = Ave("Aguila", "Real")
        atun = Pez("Atun", "Blanco")

        self.assertIsInstance(aguila, Ave)
        self.assertIsInstance(aguila, Animal)
        self.assertIsInstance(aguila, Volador)

        self.assertIsInstance(atun, Pez)
        self.assertIsInstance(atun, Animal)
        self.assertIsInstance(atun, Nadador)

    def test_herencia(self):
        self.assertTrue(issubclass(Ave, Animal))
        self.assertTrue(issubclass(Ave, Volador))
        self.assertFalse(issubclass(Animal, Volador))

        self.assertTrue(issubclass(Pez, Animal))
        self.assertTrue(issubclass(Pez, Nadador))
        self.assertFalse(issubclass(Animal, Nadador))

    def test_mostrar_raza(self):
        aguila = Ave("Aguila", "Real")
        atun = Pez("Atun", "Blanco")

        self.assertEqual(aguila.mostrar_raza(), "Real")
        self.assertEqual(atun.mostrar_raza(), "Blanco")

    def test_mostrar_nombre(self):
        aguila = Ave("Aguila", "Real")
        atun = Pez("Atun", "Blanco")

        self.assertEqual(aguila.mostrar_nombre(), "Aguila")
        self.assertEqual(atun.mostrar_nombre(), "Atun")

    def test_metodo_comun(self):
        aguila = Ave("Aguila", "Real")
        atun = Pez("Atun", "Blanco")

        # Comprobamos si se elige el método de la primera clase base
        self.assertEqual(aguila.mostrar_nombre(), "Aguila")
        self.assertEqual(atun.mostrar_nombre(), "Atun")

        # Si no queremos el método de la primera
        self.assertEqual(Volador.mostrar_nombre(aguila), "Aguila")
        self.assertEqual(Animal.mostrar_nombre(atun), "Atun")

    def test_accion(self):
        aguila = Ave("Aguila", "Real")
        self.assertEqual(aguila.accion(), "Soy un ave\nEl animal puede volar")


if __name__ == '__main__':
    unittest.main()
