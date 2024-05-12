import 'dart:async';

import 'package:test/test.dart';
import 'package:dart/persona.dart';

void main() {
  group('Persona', () {
    // Crear una persona para los tests
    var persona = Persona('Test', 30);

    test('hablar imprime el mensaje correcto', () {
      // Capturar la salida de print
      var printLog = [];
      var zone = Zone.current.fork(
        specification: ZoneSpecification(
          print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
            printLog.add(line);
          },
        ),
      );

      // Ejecutar hablar en la zona
      zone.run(() => persona.hablar());

      // Verificar la salida de print
      expect(printLog, ['Hola, mi nombre es Test y tengo 30 años']);
    });
  });
}