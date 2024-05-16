import 'package:test/test.dart';
import 'package:dart/persona.dart';

void main() {
  group('Persona', () {
    // Crear una persona para los tests
    var persona = Persona('Test', 30);

    test('hablar devuelve el mensaje correcto', () {
      // Ejecutar hablar y capturar el resultado
      var resultado = persona.hablar();

      // Verificar que el resultado sea el esperado
      expect(resultado, 'Hola, mi nombre es Test y tengo 30 años');
    });
  });
}
