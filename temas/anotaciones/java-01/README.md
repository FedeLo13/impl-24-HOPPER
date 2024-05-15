# Anotaciones en Java

Este directorio contiene ejemplos de cómo usar anotaciones en java.

## Estructura del Directorio

- [`app/`](app/): Contiene el frontend y el backend implementado en JavaScript.
- [`src/main/java`](src/main/java): Contiene el código de ejemplo en java.
- [`src/test/java`](src/test/java): Contiene los test para el código ejemplo en java.
- [`pom.xml`](pom.xml): Para pasar los test, define la configuración del proyecto, incluidos los plugins de Maven y las configuraciones de build específicas necesarias para compilar, testear y ejecutar el código de java.
- [`Dockerfile`](Dockerfile): Configuración para Docker.
- [`APP.tf`](APP.tf): Configuración para Terraform.

## Explicación teórica

Las anotaciones en Java son una poderosa herramienta para agregar metadatos al código. Permiten configurar cómo se deben tratar ciertos elementos en tiempo de ejecución, mejorando la modularidad y la separabilidad del código.

A continuación, se ofrece una explicación detallada de los componentes principales asociados con las anotaciones en Java.

### `@interface`

Una anotación en Java se define utilizando la sintaxis **'@interface'**, que es similar en apariencia a una interfaz pero se utiliza para definir una anotación. Las anotaciones no pueden ser instanciadas como clases normales, sino que sirven como metadatos para elementos del código.

```java
public @interface MyAnnotation {
    String value();
}
```

En este ejemplo, **'MyAnnotation'** es una anotación que puede almacenar un valor de tipo **'String'**. Esta anotación puede ser utilizada para asignar metadatos específicos a los componentes del código.

### `@Target`

El **'@Target'** es una anotación que define dónde puede aplicarse la anotación. Los posibles objetivos incluyen clases, interfaces, métodos, campos, etc.

```java
@Target(ElementType.METHOD)
public @interface MyMethodAnnotation {}
```
Aquí, **'MyMethodAnnotation'** solo puede aplicarse a los métodos de una clase o interfaz.

### `@Retention`

El **'@Retention'** especifica cómo se almacena la anotación: sólo en el código fuente, en el archivo .class, o en tiempo de ejecución, lo que permite que sea accesible mediante reflexión.

```java
@Retention(RetentionPolicy.RUNTIME)
public @interface MyRuntimeAnnotation {}
```
**'MyRuntimeAnnotation'** está disponible en tiempo de ejecución, lo que significa que se puede acceder a ella a través de la API de reflexión de Java.

### `@Inherited`

La anotación **'@Inherited'** indica que una anotación se hereda de la clase base, lo que no es el comportamiento predeterminado de las anotaciones.

```java
@Inherited
public @interface MyInheritedAnnotation {}
```
Si una clase padre lleva esta anotación, entonces las clases hijas heredarán automáticamente **'MyInheritedAnnotation'**.

### `@Repeatable`

La anotación **'@Repeatable'** permite que una anotación se aplique más de una vez al mismo elemento del lenguaje de programación.

```java
@Repeatable(MyAnnotations.class)
public @interface MyRepeatableAnnotation {
    String value();
}
```
Esta anotación se puede repetir, y las instancias se almacenan en una anotación contenedora **'MyAnnotations'**.

## Contenido

### Código ejemplos

Para representar las anotaciones en java, se ha decidido representar la comparación entre pedidos según fecha o cantidad. Para esto se ha

### Anotaciones [**CompareByAmount**](src/main/java/CompareByAmount.java) y [**CompareByDate**](src/main/java/CompareByDate.java)

Las anotaciones [CompareByAmount](src/main/java/CompareByAmount.java) y [CompareByDate](src/main/java/CompareByDate.java) son metadatos personalizados que permiten identificar los campos de una clase que tendrán inyección de dependencias para comparadores específicos. Estas están destinadas a ser utilizadas en campos que representan comparadores dentro de las clases de dominio.

`CompareByAmount.java`

```java
package main.java;

import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface CompareByAmount {
}
```

`CompareByDate.java`

```java
package main.java;

import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface CompareByDate {
}
```

### Clase Order

La clase [Order](src/main/java/Order.java) utiliza las anotaciones CompareByDate y CompareByAmount para inyectar dependencias de comparadores específicos para fecha y cantidad respectivamente.

`Order.java`

```java
package main.java;

import java.time.LocalDate;
import java.util.Comparator;
import java.util.Objects;

public class Order implements Comparable<Order> {
    private int orderId;
    private LocalDate date;
    private double amount;

    @CompareByDate
    private Comparator<Order> comparatorDate;

    @CompareByAmount
    private Comparator<Order> comparatorAmount;

    public Order(int orderId, LocalDate date, double amount) {
        this.orderId = orderId;
        this.date = date;
        this.amount = amount;
    }

    public LocalDate getDate() {
        return date;
    }

    public double getAmount() {
        return amount;
    }

    public int getOrderId() {
        return orderId;
    }

    public Comparator<Order> getComparatorDate() {
        return comparatorDate;
    }

    public Comparator<Order> getComparatorAmount() {
        return comparatorAmount;
    }

    @Override
    public int compareTo(Order other) {
        if (this.comparatorDate == null) {
            throw new IllegalStateException("Comparator not initialized");
        }
        return comparatorDate.compare(this, other);
    }

    public int compareToAmount(Order other) {
        if (this.comparatorAmount == null) {
            throw new IllegalStateException("Comparator not initialized");
        }
        return comparatorAmount.compare(this, other);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Order order = (Order) obj;
        return orderId == order.orderId &&
            Double.compare(order.amount, amount) == 0 &&
            Objects.equals(date, order.date);
    }


}
```

### Comparadores OrderByAmount y OrderByDate

[OrderByAmount](src/main/java/OrderByAmountComparator.java) y [OrderByDate](src/main/java/OrderByDateComparator.java) implementan la interfaz Comparator de Java y definen cómo se deben comparar dos instancias de Order según la cantidad y la fecha, respectivamente.

`OrderByAmountComparator.java`

```java
package main.java;

import java.util.Comparator;

public class OrderByAmountComparator implements Comparator<Order> {
    @Override
    public int compare(Order o1, Order o2) {
        return Double.compare(o1.getAmount(), o2.getAmount());
    }
}
```

`OrderByDateComparator.java`

```java
package main.java;

import java.util.Comparator;

public class OrderByDateComparator implements Comparator<Order> {
    @Override
    public int compare(Order o1, Order o2) {
        return o1.getDate().compareTo(o2.getDate());
    }
}
```

### DependencyInjector

[DependencyInjector](src/main/java/DependencyInjector.java) es responsable de realizar la inyección de dependencias. Utiliza reflexión para inspeccionar las anotaciones en los campos de un objeto y asignar las instancias adecuadas de los comparadores. 

`DependencyInjector.java`

```java
package main.java;

import java.lang.reflect.Field;

public class DependencyInjector {

    public static void inject(Object object) throws IllegalAccessException, InstantiationException {
        Class<?> clazz = object.getClass();
        for (Field field : clazz.getDeclaredFields()) {
            if (field.isAnnotationPresent(CompareByDate.class)) {
                field.setAccessible(true);
                field.set(object, new OrderByDateComparator());
            } else if (field.isAnnotationPresent(CompareByAmount.class)) {
                field.setAccessible(true);
                field.set(object, new OrderByAmountComparator());
            }
        }
    }
}
```

### OrderTest

[OrderTest](src/test/java/OrderTests.java) contiene el código de los test con JUnit para los anteriores códigos presentados. 

```java
package main.java;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import main.java.DependencyInjector;
import main.java.Order;
import main.java.OrderByAmountComparator;
import main.java.OrderByDateComparator;

import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalDate;
import java.util.Comparator;

class OrderTests {
    private Order order1, order2, order3;

    @BeforeEach
    void setUp() throws IllegalAccessException, InstantiationException {
        order1 = new Order(1, LocalDate.of(2022, 1, 1), 100.0);
        order2 = new Order(2, LocalDate.of(2022, 1, 1), 150.0);
        order3 = new Order(3, LocalDate.of(2021, 12, 31), 100.0);

        DependencyInjector.inject(order1);
        DependencyInjector.inject(order2);
        DependencyInjector.inject(order3);
    }

    @Test
    void testCompareByDate() {
        Comparator<Order> comp = order1.getComparatorDate();
        assertEquals(0, comp.compare(order1, order2));
        assertTrue(comp.compare(order1, order3) > 0);
        assertTrue(comp.compare(order3, order1) < 0);
    }

    @Test
    void testCompareByAmount() {
        Comparator<Order> comp = order1.getComparatorAmount();
        assertTrue(comp.compare(order1, order2) < 0);
        assertTrue(comp.compare(order2, order1) > 0);
        assertEquals(0, comp.compare(order1, order3));
    }

    @Test
    void testDependencyInjection() {
        // Verificar si los comparadores están correctamente inyectados
        assertNotNull(order1.getComparatorDate());
        assertNotNull(order1.getComparatorAmount());
        assertNotNull(order2.getComparatorDate());
        assertNotNull(order2.getComparatorAmount());
        assertInstanceOf(OrderByDateComparator.class, order1.getComparatorDate());
        assertInstanceOf(OrderByAmountComparator.class, order1.getComparatorAmount());
    }

    @Test
    void testEquality() {
        assertEquals(new Order(1, LocalDate.of(2022, 1, 1), 100.0), order1);
        assertNotEquals(order1, order2);
        assertNotEquals(order1, order3);
    }

    @Test
    void testUninitializedComparatorThrowsException() {
        // Crear una orden sin inyectar dependencias
        Order order3 = new Order(3, LocalDate.of(2023, 5, 3), 200);
        Exception exception = assertThrows(IllegalStateException.class, () -> order3.compareTo(order2));
        assertEquals("Comparator not initialized", exception.getMessage());
    }
}
```

## Código APP Web

Para la aplicación web se ha usado Node.js y React, los ficheros que conforman la aplicación son los siguientes:

[**package.json**](app/src/package.json)

Es un archivo de configuración esencial en proyectos que utilizan Node.js y React. Define el nombre, versión, punto de entrada principal del código, scripts para operaciones comunes como iniciar, construir, probar y desplegar la aplicación, así como las dependencias necesarias para el funcionamiento del servidor y la interfaz de usuario. 

[**backend.js**](app/src/backend.js)

Es un script del servidor creado con Node.js que utiliza el framework Express para manejar solicitudes HTTP. Define --Completar--

[**App.js**](app/src/App.js)

Es un componente principal en React que gestiona la interfaz de usuario para visualizar y ejecutar código y pruebas de Java mediante llamadas API. El usuario puede introducir nuevos pedidos introduciendo un ID, Fecha y Cantidad. Al seleccionar ejecutar se crea un archivo de java que contiene el main que será ejecutado y lo ejecutará, mostrando el resultado de la ejecución que es los pedidos ordenados por fecha y cantidad.

[**index.js**](app/src/index.js)

Es el punto de entrada para la aplicación React, donde se realiza la renderización del componente principal App en el DOM. Utiliza ReactDOM.render para inyectar el componente App dentro del elemento HTML con id root.

[**index.html**](app/public/index.html)

Este sirve como plantilla base para la aplicación React, definiendo el esqueleto HTML sobre el cual React construirá la interfaz de usuario. Contiene un div con id root, que es el punto de montaje para el componente React principal (App) renderizado por index.js.

## Cómo ejecutar los test

### Requisitos

- JDK 17
- Docker
- Terraform

### -EJECUCIÓN SIMPLE DESDE TERMINAL-

1. Nos movemos al directorio de trabajo en caso de no estar ya en él:
    ```bash
    cd temas/anotaciones/java-01
    ```
2. Ejecutamos los test con mvn:
    ```bash
    mvn test 
    ```
   
Tras seguir los dos pasos anteriores podrás visualizar en la terminal los resultados de los tests.

## Ejecución de ejemplos con app web

1. Construye y corre el contenedor Docker con Terraform:

   ```bash
   cd temas/anotaciones/java-01 # Nos movemos al directorio de trabajo
   terraform init # Iniciamos terraform
   terraform apply # Lanzamos el docker
   ```
2. Accede desde tu navegador a la dirección localhost:3100

3. Introduce tantos pedidos como quieras seleccionando un ID, Fecha y Cantidad.

4. Para introducir más pedidos pulse el botón "Añadir más"

5. Cuando haya terminado de añadir pedidos, pulse "Ejecutar" y tras unos segundos verá el orden de los pedidos.

6. Cuando haya terminado para evitar gasto de recursos innecesarios no olvide ejecutar la siguiente orden en el directorio de trabajo desde terminal:

```bash
terraform destroy
```
Esto eliminará el docker que se levantó.