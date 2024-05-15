# Lambdas en Python

## Introducción
Bienvenido al repositorio sobre Lambdas en Python. Aquí encontrarás información detallada sobre cómo utilizar funciones lambda en Python para escribir código más limpio y eficiente.

## Estructura de Directorio
- `/README.md`: Archivo actual.
- `/ejemplo.py`: Archivo python donde se encuentra el codigo de ejemplo.
- `/tests.py`: Archivo python donde se encuentra el codigo de los tests.

## Conceptos Previos
Antes de explorar los ejemplos proporcionados en este repositorio, es esencial entender algunos conceptos clave relacionados con el uso de funciones lambda en Python. Las funciones lambda son pequeñas funciones anónimas definidas con la palabra clave `lambda`. Aquí se detallan varios usos y técnicas que se emplean en el código de ejemplo.py:

- **Funciones Lambda para Operaciones Simples**:
  Las funciones lambda se utilizan frecuentemente para realizar operaciones pequeñas y directas, como sumar dos números. Son una manera concisa de escribir funciones de una sola línea.

- **Uso de Lambda con `map()`**:
  La función `map()` aplica una función a cada elemento de un iterable (como una lista) y devuelve un nuevo iterable. Usar funciones lambda con `map()` permite aplicar operaciones complejas de manera sucinta sin necesidad de definir una función aparte.

- **Uso de Lambda con `filter()`**:
  La función `filter()` construye un iterador a partir de aquellos elementos de un iterable para los que una función devuelve verdadero. Las funciones lambda son útiles aquí para definir rápidamente la función de filtrado sin separar la definición de la función.

- **Funciones Lambda para Condiciones Ternarias**:
  Las funciones lambda también pueden ser utilizadas para ejecutar expresiones condicionales, lo cual permite integrar lógica condicional dentro de una definición funcional breve y directa.

- **Uso de Lambda con `reduce()`**:
  La función `reduce()` de la biblioteca `functools` se utiliza para aplicar una función de dos argumentos acumulativamente a los elementos de una secuencia, de manera que se reduzca la secuencia a un único valor. Las funciones lambda son ideales para definir la función de reducción de forma rápida y en el mismo lugar donde se utiliza.


## Código de Ejemplo
A continuación, se muestra un ejemplo de cómo se pueden utilizar las funciones lambda en Python:
[**Ejemplo.py**](ejemplo.py)

```python
from functools import reduce

def asignacion():
    # Funcion lambda
    add = lambda x, y: x + y
    return add(3, 5)

def ordenSuperior():
    # Lista de números
    numbers = [1, 2, 3, 4, 5]
    return list(map(lambda x: x**2, numbers))

def ordenSuperior2():
    words = ["hello", "world", "python", "lambda", "example"]
    return list(filter(lambda x: len(x) > 5, words))

def condicionesTernarias():
    is_even = lambda x: True if x % 2 == 0 else False
    return is_even(4)

def funcionReduccion():
    numbers = [1, 2, 3, 4, 5]
    return reduce(lambda x, y: x + y, numbers)
```

Métodos usados en el ejemplo:

`asignacion():` 
Utiliza una función lambda para sumar dos números. La lambda lambda x, y: x + y toma dos argumentos y devuelve su suma. Este método muestra el uso básico de una lambda como una pequeña función inline para realizar operaciones aritméticas simples.

`ordenSuperior():` 
Emplea map() junto con una lambda para elevar al cuadrado cada número en una lista. Aquí, lambda x: x**2 es una función que toma un número y devuelve su cuadrado. Este método ilustra cómo las lambdas pueden ser usadas para aplicar una operación a cada elemento de una colección de forma concisa y eficiente.

`ordenSuperior2():` 
Usa filter() con una lambda para seleccionar palabras de una lista que tienen más de cinco letras. La expresión lambda x: len(x) > 5 filtra las palabras basándose en su longitud. Este uso demuestra cómo las lambdas facilitan las operaciones de filtrado sin necesidad de una función nombrada explícita.

`condicionesTernarias():` 
Implementa una lambda para verificar si un número es par, utilizando una condición ternaria dentro de la lambda: lambda x: True if x % 2 == 0 else False. Esta función anónima devuelve True si el número es par, y False en caso contrario, ejemplificando el uso de lambdas para condiciones lógicas simples.

`funcionReduccion():` 
Combina reduce() con una lambda para sumar todos los números en una lista. La función lambda x, y: x + y se aplica repetidamente a los elementos de la lista para acumular un valor total. Este método muestra cómo las lambdas pueden ser empleadas en operaciones de reducción, que condensan una secuencia de elementos en un único resultado.



## Código de tests
Ahora, se muestra unos tests para probar el correcto uso de las funciones lambda en Python:
[**tests.py**](tests.py)

```python
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

```

El framework utilizado en el código de prueba es `unittest`, un módulo de pruebas unitarias incluido en la biblioteca estándar de Python. `unittest` proporciona una manera rica y robusta de construir y ejecutar pruebas, siguiendo el patrón de diseño de pruebas unitarias conocido como xUnit, que se ha implementado en varios lenguajes de programación.

Métodos usados en los test:

`test_asignacion():` 
Prueba la función asignacion() importada del módulo ejemplo. Esta función utiliza una lambda para sumar dos números. La prueba verifica que el resultado de asignacion() sea 8, esperando que la lambda sume correctamente 3 y 5.

`test_ordenSuperior():` 
Verifica la función ordenSuperior(), que utiliza map() junto con una lambda para elevar al cuadrado cada elemento de una lista. La prueba comprueba si la función retorna la lista [1, 4, 9, 16, 25], asegurando que la lambda aplique correctamente la operación de elevar al cuadrado a cada número de la lista original.

`test_ordenSuperior2():` 
Testea ordenSuperior2(), que emplea filter() con una lambda para seleccionar palabras de una lista basándose en su longitud. La prueba confirma que la función devuelve las palabras que tienen más de cinco letras, en este caso ['python', 'lambda', 'example'], validando que la lambda filtre adecuadamente según el criterio dado.

`test_condicionesTernarias():` 
Examina condicionesTernarias(), que usa una lambda con una condición ternaria para determinar si un número es par. Esta prueba asegura que la función devuelve True cuando se evalúa el número 4, corroborando que la lambda esté correctamente configurada para evaluar la paridad del número.

`test_funcionReduccion():` 
Prueba funcionReduccion(), donde se utiliza reduce() con una lambda para sumar todos los elementos de una lista. La prueba verifica que el resultado sea 15, comprobando que la lambda acumule correctamente los valores de la lista.

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
(https://git-scm.com/downloads)

Instala Git y luego ejecuta el siguiente comando para clonar el repositorio:
git clone [URL_DEL_REPOSITORIO](https://github.com/sistemas-sw/impl-24.git)


### 3. Cambiar al Directorio del Repositorio
Una vez clonado el repositorio, navega al directorio donde se encuentra el código:
```bash
cd .temas/lambdas/python
```
### 4. Ejecutar los Tests
Finalmente, puedes ejecutar los tests utilizando `unittest`.
Desde el directorio del proyecto, ejecuta:
```bash
python -m unittest
```
Este comando buscará archivos de test en el directorio, ejecutará los tests y mostrará los resultados en la terminal.
