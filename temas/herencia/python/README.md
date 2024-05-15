# Herencia en Python

## Introducción
Bienvenido al repositorio sobre Herencia en Python. Aquí encontrarás información detallada sobre cómo utilizar la Herencia en Python para escribir código más limpio y eficiente.

## Estructura de Directorio
- `/README.md`: Archivo actual.
- `/ejemplo.py`: Archivo python donde se encuentra el codigo de ejemplo.
- `/tests.py`: Archivo python donde se encuentra el codigo de los tests.


## Conceptos Previos
Antes de explorar los ejemplos proporcionados en este repositorio, es esencial entender algunos conceptos clave relacionados con la herencia y el polimorfismo en Python. Aquí se detallan varios usos y técnicas que se emplean en el código de ejemplo:

- **Herencia Básica**:
  La herencia permite que una clase (subclase) herede atributos y métodos de otra clase (superclase). En el ejemplo, la clase `Animal` actúa como una superclase que proporciona atributos y métodos básicos como `mostrar_nombre`, que son heredados por otras clases.

- **Herencia Múltiple**:
  Python permite que una clase herede de múltiples clases, proporcionando una forma de combinar funcionalidades de múltiples superclases. Esto puede resultar en una situación compleja cuando diferentes clases base tienen métodos con el mismo nombre. Python utiliza el método de resolución de orden de método (MRO) para determinar el orden en el que se buscan los métodos. Este orden está definido por el algoritmo C3 linearization. En el código, `Ave` hereda tanto de `Animal` como de `Volador`, combinando sus atributos y métodos. 

- **Polimorfismo**:
  El polimorfismo permite que métodos con el mismo nombre actúen de manera diferente en diferentes clases. Por ejemplo, el método `mostrar_nombre` se define tanto en `Animal` como en `Volador` y `Nadador`, pero su implementación puede ser diferente en cada clase.

- **Composición de Clases**:
  Además de la herencia, las clases `Volador` y `Nadador` demuestran cómo la composición puede ser utilizada para agregar diferentes capacidades a las clases. Ambas clases introducen nuevos métodos como `volar` y `nadar`, que son específicos para sus respectivas funcionalidades.

- **Inicialización de Superclases en Herencia Múltiple**:
  En herencia múltiple, es importante inicializar correctamente todas las superclases para asegurarse de que todos los atributos de la clase base se configuren adecuadamente. En `Ave`, por ejemplo, se llama explícitamente a los inicializadores de `Animal` y `Volador` para asegurar una inicialización completa.

Este repositorio proporciona ejemplos prácticos de cómo se pueden implementar y utilizar estos conceptos en Python para crear un diseño de software robusto y flexible.


## Código de Ejemplo
A continuación, se muestra un ejemplo de cómo se pueden utilizar la herencia en Python:
[**ejemplo.py**](ejemplo.py)

```python
class Animal:
    def __init__(self, nombre):
        self.nombre = nombre

    def mostrar_nombre(self):
        return self.nombre


class Volador:
    def __init__(self, nombre, raza):
        self.raza = raza
        self.nombre = nombre
    
    def mostrar_nombre(self):
        return self.nombre

    def volar(self):
        return "El animal puede volar"

    def mostrar_raza(self):
        return self.raza


class Nadador:
    def __init__(self, nombre, raza):
        self.raza = raza
        self.nombre = nombre
        
    def mostrar_nombre(self):
        return self.nombre
        
    def nadar(self):
        return "El animal puede nadar"

    def mostrar_raza(self):
        return self.raza


class Ave(Animal, Volador):
    def __init__(self, nombre, raza):
        Animal.__init__(self, nombre)
        Volador.__init__(self, nombre, raza)

    def accion(self):
        return "Soy un ave" + "\n" + Volador.volar(self)


class Pez(Nadador, Animal):
    def __init__(self, nombre, raza):
        Animal.__init__(self, nombre)
        Nadador.__init__(self, nombre, raza)
```

Métodos Usados en el Ejemplo:

### Clase `Animal`:
- `__init__(self, nombre)`: 
Constructor que inicializa el objeto `Animal` con un nombre.
- `mostrar_nombre(self)`: 
Método que devuelve el nombre del animal. Este método muestra cómo se puede proporcionar un comportamiento básico en una superclase que otras clases pueden heredar o sobrescribir.

### Clase `Volador`:
- `__init__(self, nombre, raza)`: 
Constructor que inicializa el objeto `Volador` con un nombre y una raza.
- `mostrar_nombre(self)`: 
Método que devuelve el nombre del animal volador. Demuestra cómo una clase puede tener su propia implementación de un método que también existe en otra superclase.
- `volar(self)`: 
Método que indica la capacidad de volar del animal. Específico para clases que representan animales voladores.
- `mostrar_raza(self)`: 
Método que devuelve la raza del animal volador.

### Clase `Nadador`:
- `__init__(self, nombre, raza)`: 
Constructor que inicializa el objeto `Nadador` con un nombre y una raza.
- `mostrar_nombre(self)`: 
Similar a `Volador`, muestra cómo se puede tener diferentes implementaciones del mismo método en diferentes clases.
- `nadar(self)`: 
Método que indica la capacidad de nadar del animal.
- `mostrar_raza(self)`: 
Método que devuelve la raza del animal nadador.

### Clase `Ave` (Herencia Múltiple de `Animal` y `Volador`):
- `__init__(self, nombre, raza)`: 
Constructor que llama explícitamente a los constructores de las superclases `Animal` y `Volador` para asegurar que todos los atributos necesarios estén correctamente inicializados.
- `accion(self)`: 
Método que devuelve una cadena que identifica al objeto como un ave y llama al método `volar()` de la superclase `Volador`. Este método ilustra cómo una clase puede utilizar métodos de sus superclases a través de la herencia múltiple.

### Clase `Pez` (Herencia Múltiple de `Nadador` y `Animal`):
- `__init__(self, nombre, raza)`: 
Constructor que inicializa ambas superclases, `Nadador` y `Animal`, demostrando el uso adecuado de la herencia múltiple para combinar funcionalidades de ambas superclases.

Este código proporciona un claro ejemplo de cómo la herencia simple y la herencia múltiple pueden ser usadas en Python para crear jerarquías de clases flexibles y reutilizar funcionalidades, permitiendo a las subclases extender o modificar comportamientos de las superclases. La herencia también facilita la implementación de polimorfismo, donde métodos con el mismo nombre pueden tener comportamientos diferentes en diferentes clases.


## Código de tests
Ahora, se muestra unos tests para probar los usos de la herencia en Python:
[**tests.py**](tests.py)

```python
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


```

El framework utilizado en el código de prueba es `unittest`, un módulo de pruebas unitarias incluido en la biblioteca estándar de Python. `unittest` proporciona una manera rica y robusta de construir y ejecutar pruebas, siguiendo el patrón de diseño de pruebas unitarias conocido como xUnit, que se ha implementado en varios lenguajes de programación.

Métodos usados en los tests:

`test_instancias():`
Prueba las instancias de las clases `Ave` y `Pez` para verificar si son instancias de sus respectivas clases y superclases. Se asegura de que:
- `aguila` es instancia de `Ave`, `Animal` y `Volador`.
- `atun` es instancia de `Pez`, `Animal` y `Nadador`.
Estas pruebas validan la correcta implementación de la herencia múltiple y las relaciones entre las clases.

`test_herencia():`
Verifica las relaciones de herencia entre las clases para confirmar que:
- `Ave` es subclase de `Animal` y `Volador`.
- `Pez` es subclase de `Animal` y `Nadador`.
- `Animal` no es subclase de `Volador` ni `Nadador`.
Este método comprueba que la estructura de herencia está definida correctamente según el diseño del sistema.

`test_mostrar_raza():`
Testea el método `mostrar_raza()` para las instancias `aguila` y `atun`. Comprueba que el método devuelve correctamente la raza de cada animal, asegurando que los atributos son accesibles y correctos a través de la herencia múltiple.

`test_mostrar_nombre():`
Examina el método `mostrar_nombre()` en las instancias `aguila` y `atun`. Este test verifica que cada clase retorna el nombre del animal correctamente, lo que indica que los métodos sobreescritos o heredados funcionan como se espera.

`test_metodo_comun():`
Prueba el método `mostrar_nombre()` sobreescrito en diferentes contextos para asegurar que:
- Los métodos de las clases base se invocan correctamente.
- Se pueden acceder a implementaciones específicas de métodos comunes a través de la especificación explícita de la clase, como `Volador.mostrar_nombre(aguila)` y `Animal.mostrar_nombre(atun)`, verificando así el comportamiento esperado del polimorfismo y la resolución de métodos en la herencia múltiple.

`test_accion():`
Comprueba el método `accion()` en la instancia `aguila`. Este método debe devolver una cadena que incluye tanto la identificación como ave como la capacidad de volar, demostrando la integración efectiva de métodos de diferentes superclases en una clase derivada.

Estos tests aseguran que la herencia múltiple, el acceso a métodos y propiedades, y la funcionalidad específica de las clases están implementadas correctamente y funcionan como se espera en el entorno de Python.


## Ejecución desde una Terminal

Para ejecutar el código y los tests en una máquina de fábrica, sigue estos pasos detallados que incluyen la descarga del código, instalación de Python y ejecución de los tests:

### 1. Instalación de Python
Primero, necesitas asegurarte de que Python 3.8 está instalado en tu sistema.
Puedes descargar e instalar Python desde:
(https://www.python.org/downloads/release/python-380/)
Sigue las instrucciones específicas para tu sistema operativo.

Verifica la instalación ejecutando:
```bash
python --version
```
o
```bash
python3 --version
```
Esto debería mostrar la versión de Python 3.8 instalada.

### 2. Clonar el Repositorio
A continuación, necesitas descargar el código del repositorio.
Si el código está disponible en GitHub, puedes clonar el repositorio utilizando Git.
Si aún no tienes Git instalado, puedes descargarlo desde:
(https://git-scm.com/downloads
)
Instala Git y luego ejecuta el siguiente comando para clonar el repositorio:
git clone [URL_DEL_REPOSITORIO](https://github.com/sistemas-sw/impl-24.git)


### 3. Cambiar al Directorio del Repositorio
Una vez clonado el repositorio, navega al directorio donde se encuentra el código:
```bash
cd .temas/herencia/python
```
### 4. Ejecutar los Tests
Finalmente, puedes ejecutar los tests utilizando `unittest`.
Desde el directorio del proyecto, ejecuta:
```bash
python -m unittest
```
Este comando buscará archivos de test en el directorio, ejecutará los tests y mostrará los resultados en la terminal.
