import 'hablador.dart';

class Persona with Hablador {
  String nombre;
  int edad; 

  Persona(this.nombre, this.edad);

  @override
  String hablar() {
    return "Hola, mi nombre es $nombre y tengo $edad años";
  }
}