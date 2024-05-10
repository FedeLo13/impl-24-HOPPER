abstract class Robot {
  String nombre;
  String material;
  final List<String> _acciones = [];

  Robot(this.nombre, this.material);

  //Acciones de cualquier robot

  void mover(String direccion) {
    _acciones.add("$nombre moviéndose hacia $direccion");
  }

  void girar(String direccion) {
    _acciones.add("$nombre girando hacia $direccion");
  }

  // Ejecutar las acciones del robot

  void ejecutarAcciones() {
    for (var accion in _acciones) {
      print(accion);
    }
  }

  //Método abstracto
  void objetivo();
}
