import unittest
from ejemplo import asignacion, ordenSuperior, ordenSuperior2, condicionesTernarias, funcionReduccion

class TestFuncionesLambda(unittest.TestCase):

    def test_asignacion(self):
        self.assertEqual(asignacion(), 8)

    def test_ordenSuperior(self):
        self.assertEqual(ordenSuperior(), [1, 4, 9, 16, 25])

    def test_ordenSuperior2(self):
        self.assertEqual(ordenSuperior2(), ['python', 'lambda', 'example'])

    def test_condicionesTernarias(self):
        self.assertTrue(condicionesTernarias())

    def test_funcionReduccion(self):
        self.assertEqual(funcionReduccion(), 15)

if __name__ == '__main__':
    unittest.main()
