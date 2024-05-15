# Aspectos en Java

## Introducción
Bienvenido al repositorio sobre Aspectos en Java. Aquí encontrarás información detallada sobre cómo utilizar los aspectos en java para escribir código más limpio y eficiente.

## Estructura de Directorio
- `/README.md`: Archivo actual.
- `/proyecto`: Directorio que representa la raiz de nuestro proyecto.
- `/proyecto/pom.xml`: Archivo XML donde añadiremos las dependencias de nuestro proyecto
- `/proyecto/src/main/java/com/example/myexample`: Directorio donde encontraremos los codigos de nuestro ejemplo.
- `/proyecto/src/main/java/com/example/myexample/LoggingAspect.java`: Archivo java donde se encuentra la definción de nuestro aspecto que servirá para el uso de logs.
- `/proyecto/src/main/java/com/example/myexample/User.java`: Archivo java donde se encuentra la definición de la clase User.
- `/proyecto/src/main/java/com/example/myexample/UserManager.java`: Archivo java donde se encuentra el codigo del manejo de usuarios sin el uso de aspectos.
- `/proyecto/src/main/java/com/example/myexample/UserManager,java`: Archivo java donde se encuentra el codigo del manejo de usuarios con el uso de aspectos.
- `/proyecto/src/test/java/com/example/myexample`: Archivo python donde se encuentra el codigo de los tests.
- `/proyecto/src/test/java/com/example/myexample/tests,java`: Directorio donde encontraremos los tests de nuestro ejemplo.

## Conceptos Previos
Antes de explorar los ejemplos proporcionados en este repositorio, es esencial entender algunos conceptos clave relacionados con Aspect Oriented Programming (AOP) en Java. AOP nos permite separar las preocupaciones transversales de la lógica del negocio principal. Aquí se detallan varios usos y técnicas que se emplean en el código de ejemplo:

- **Pointcut**:
  Un pointcut define en qué punto del código se aplicará un aspecto, como métodos específicos donde se desea interceptar la ejecución. Por ejemplo, `accessUser()` es un pointcut que captura la ejecución de `UserManager.getCurrentUser()`.

- **Advice**:
  Los advices son acciones tomadas por un aspecto en un punto de ejecución específico:
  - **Before Advice**: Se ejecuta antes de que el método interceptado se ejecute. En nuestro proyecto, `beforeAccessUser()` se utiliza para loguear antes de acceder a los datos del usuario.
  - **After Advice**: Se ejecuta después de que el método interceptado se complete. `afterModifyUser()` se utiliza para loguear después de que la información del usuario haya sido modificada, advirtiendo sobre posibles cambios en datos sensibles.
  - **Around Advice**: Envuelve completamente la ejecución del método interceptado, permitiendo controlar el comportamiento antes y después de la llamada al método, e incluso alterar el resultado. `aroundUserPropertyChange()` maneja cambios en las propiedades del usuario y registra esos eventos.

- **Join Point**:
  Un join point es un punto en la ejecución del programa, como la llamada a un método o el manejo de una excepción, donde un aspecto puede ser aplicado. Los pointcuts ayudan a definir estos join points específicos para los advices.

- **Aspect**:
  Un aspecto es un módulo que encapsula pointcuts y advices, representando una preocupación transversal, como logging o seguridad. `LoggingAspect` en nuestro código maneja logs relacionados con el acceso y modificación de los usuarios.

- **Introducción**:
  Las introducciones permiten a los aspectos añadir nuevos métodos o campos a las clases existentes. Aunque no se muestra directamente en los ejemplos proporcionados, es otra poderosa herramienta de AOP para extender el comportamiento de las clases.

Este repositorio proporciona ejemplos prácticos de cómo AspectJ puede ser utilizado para mejorar la modularidad del código y separar las preocupaciones de logging y auditoría de la lógica de negocio principal, lo que resulta en un diseño más limpio y mantenible.


## Código de Ejemplo
A continuación, se muestran los ejemplos de cómo se pueden utilizar los aspectos:
[**LoggingAspect.java**](LoggingAspect.java)

```java
package com.example.myexample;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.ProceedingJoinPoint;


@Aspect
class LoggingAspect {
    @Pointcut("execution(* UserManager.getCurrentUser())")
    public void accessUser() {}

    @Pointcut("execution(* UserManager.setCurrentUser(User)) || execution(* UserManager.deleteUser())")
    public void modifyUser() {}

    @Before("accessUser()")
    public void beforeAccessUser() {
        System.out.println("---------------------------------------------------------");
        System.out.println("Usted acaba de acceder a la información del usuario");
        System.out.println("---------------------------------------------------------");
    }

    @After("modifyUser()")
    public void afterModifyUser() {
        System.out.println("---------------------------------------------------------");
        System.out.println("ATENCION! USTED ACABA DE MODIFICAR INFORMACION DE USUARIO.");
        System.out.println("Puede que se haya informacion sensible. Revise.");
        System.out.println("---------------------------------------------------------");
    }

    @Around("execution(* User.setName(String)) || execution(* User.setAge(int))")
    public Object aroundUserPropertyChange(ProceedingJoinPoint pjp) throws Throwable {
        System.out.println("---------------------------------------------------------");
        System.out.println("Cambiando propiedad del usuario....");
        Object returnValue = pjp.proceed();
        System.out.println("Propiedad cambiada con éxito");
        System.out.println("---------------------------------------------------------");
        return returnValue;
    }
}
```
Métodos Usados en el LoggingAspect.java

`accessUser()`: 
Define un **Pointcut** que identifica el punto exacto dentro del flujo del programa donde se accede a la información del usuario a través del método `UserManager.getCurrentUser()`. Este Pointcut se utiliza para ejecutar código antes y después de que se acceda a este método, permitiendo monitorizar y registrar el acceso a los datos del usuario.

`modifyUser()`: 
Otro **Pointcut** que captura tanto la actualización como la eliminación de usuarios, identificando los métodos `UserManager.setCurrentUser(User)` y `UserManager.deleteUser()`. Estos puntos en el código son críticos, ya que implican modificaciones en la información del usuario.

`beforeAccessUser()`: 
Un **Before Advice** que se dispara antes de que se ejecute el método interceptado por el pointcut `accessUser()`. Este advice imprime mensajes en la consola que indican que se está accediento a la información del usuario. Es útil para registrar accesos y garantizar que el uso de datos sensibles se monitorea adecuadamente.

`afterModifyUser()`: 
Un **After Advice** que se ejecuta después de que los métodos capturados por el pointcut `modifyUser()` hayan completado su ejecución. Este advice imprime advertencias en la consola para alertar al operador que la información del usuario ha sido modificada, lo cual es crucial para la auditoría de seguridad y la protección de datos.

`aroundUserPropertyChange()`: 
Un **Around Advice** que envuelve los métodos `User.setName(String)` y `User.setAge(int)`, permitiendo controlar la operación antes y después de que se ejecute. Este advice registra el inicio y la conclusión de la operación de cambio de propiedades del usuario, y también puede modificar el comportamiento (por ejemplo, añadir validación o transformación de datos) antes de continuar con la ejecución del método.

Estos métodos demuestran el poder de Aspect Oriented Programming (AOP) para separar las preocupaciones de registro y auditoría de la lógica de negocio principal, permitiendo un código más limpio y mantenible y facilitando la implementación de características de seguridad y registro sin invadir el código de negocio.

A continuación, la clase User:
[**User.java**](User.java)

```java
package com.example.myexample;

class User {
    private String name;
    private int age;

    User(String s, int e){
        name = s;
        age = e;
    }

    String getName() { return name; }
    void setName(String name) { this.name = name; }
    int getAge() { return age; }
    void setAge(int age) { this.age = age; }
}
```
La clase de manejo de usuario quedaría asi:
[**UserManager.java**](UserManager.java)

```java
package com.example.myexample;

public class UserManager {
    private User currentUser;

    User getCurrentUser() {
        System.out.println("Accessing user data");
        return currentUser;
    }

    void setCurrentUser(User user) {
        System.out.println("Updating user data");
        currentUser = user;
    }

    void deleteUser() {
        System.out.println("Deleting user data");
        currentUser = null;
    }
}
```
Y esta es la version con aspectos en la cual, como podemos ver no aparecen ningún System.out.println y ahora los logs se los delegamos al aspecto que es el cual se encarga de esto.
[**UserManagerAspect.java**](UserManagerAspect.java)
```java
package com.example.myexample;

class UserManagerAspect {
    private User currentUser;

    User getCurrentUser() {
        return currentUser;
    }

    void setCurrentUser(User user) {
        currentUser = user;
    }

    void deleteUser() {
        currentUser = null;
    }
}
```


## Código de tests
Ahora, se muestra unos tests para probar el correcto del ejemplo:
[**tests.java**](tests.java)

```java
package com.example.myexample;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

class UserManagerAspectTest {

    private UserManagerAspect userManagerAspect;
    private UserManager userManager;

    @BeforeEach
    void setUp() {
        userManager = new UserManager();
        userManagerAspect = new UserManagerAspect();
    }

    // Pruebas para la clase UserManager
    @Test
    void testGetCurrentUser() {
        // Arrange
        User user = new User("TestUser", 12);
        userManager.setCurrentUser(user);

        // Act
        User currentUser = userManager.getCurrentUser();

        // Assert
        assertEquals(user, currentUser, "getCurrentUser should return the current user");
    }

    @Test
    void testSetCurrentUser() {
        // Arrange
        User user = new User("TestUser", 12);

        // Act
        userManager.setCurrentUser(user);

        // Assert
        assertEquals(user, userManager.getCurrentUser(), "setCurrentUser should set the user");
    }

    @Test
    void testDeleteUser() {
        // Arrange
        User user = new User("TestUser", 12);
        userManager.setCurrentUser(user);

        // Act
        userManager.deleteUser();

        // Assert
        assertNull(userManager.getCurrentUser(), "deleteUser should set currentUser to null");
    }

    // Pruebas para el aspecto
    @Test
    void testGetCurrentUserWithAspects() {
        // Arrange
        User user = new User("TestUser", 12);
        userManagerAspect.setCurrentUser(user);

        // Act
        User currentUser = userManagerAspect.getCurrentUser();

        // Assert
        assertEquals(user, currentUser, "getCurrentUser should return the current user");
    }

    @Test
    void testSetCurrentUserWithAspects() {
        // Arrange
        User user = new User("TestUser", 12);

        // Act
        userManagerAspect.setCurrentUser(user); 

        // Assert
        assertEquals(user, userManagerAspect.getCurrentUser(), "setCurrentUser should set the user");
    }

    @Test
    void testDeleteUserWithAspects() {
        // Arrange
        User user = new User("TestUser", 12);
        userManagerAspect.setCurrentUser(user);

        // Act
        userManagerAspect.deleteUser();

        // Assert
        assertNull(userManagerAspect.getCurrentUser(), "deleteUser should set currentUser to null");
    }
}
```
El sistema de gestión de proyectos utilizado en el código es **Maven**, una herramienta de software para la gestión y construcción de proyectos Java. Maven simplifica el proceso de construcción del proyecto, incluida la compilación del código, la ejecución de pruebas y el empaquetado del resultado final en formatos distribuibles como JARs o WARs. Utiliza un archivo `pom.xml` para gestionar dependencias de bibliotecas, configuraciones de compilación y plugins, incluidos los necesarios para ejecutar pruebas unitarias.

Maven integra soporte para correr pruebas automáticamente durante el proceso de construcción utilizando frameworks de pruebas como JUnit. Al definir las dependencias y configurar los plugins adecuados en el archivo `pom.xml`, Maven puede compilar el proyecto y ejecutar todas las pruebas unitarias definidas, garantizando que el software cumpla con los requisitos especificados antes de cualquier despliegue o entrega. Esto asegura una integración continua eficiente y efectiva, y es esencial para mantener la calidad del código en desarrollos colaborativos y dinámicos.

Aquí vemos el archivo `pom.xml`:
[**pom.xml**](pom.xml)
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>hamilton</groupId>
    <artifactId>impl24</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>

    <dependencies>
        <!-- Dependencia para JUnit 5 -->
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-api</artifactId>
            <version>5.8.1</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.aspectj</groupId>
            <artifactId>aspectjrt</artifactId>
            <version>1.9.7</version>
        </dependency>
        <dependency>
            <groupId>org.aspectj</groupId>
            <artifactId>aspectjweaver</artifactId>
            <version>1.9.7</version>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <!-- Plugin para compilar y ejecutar las pruebas de JUnit -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>3.0.0-M5</version>
            </plugin>
        </plugins>
    </build>
</project>
``` 

Configuración del Proyecto Maven en `pom.xml`:

El archivo `pom.xml` define la estructura y configuración de gestión del proyecto Java, utilizando Maven para manejar dependencias, compilar el proyecto y ejecutar pruebas. Aquí se detallan los aspectos clave del archivo:

- **Información del Proyecto**:
  - `groupId`: Identifica el grupo del proyecto, aquí es `hamilton`.
  - `artifactId`: El nombre del artefacto que Maven construye, aquí es `impl24`.
  - `version`: La versión del artefacto, aquí es `1.0-SNAPSHOT`.

- **Configuración del Compilador**:
  - `maven.compiler.source` y `maven.compiler.target` están configurados para usar Java 8, asegurando que el código fuente y los artefactos compilados sean compatibles con esta versión de Java.

- **Dependencias**:
  - **JUnit 5**: Se incluye para escribir y ejecutar pruebas unitarias, especificando que es utilizada solo durante la fase de testeo (`scope: test`).
  - **AspectJ**: Dependencias `aspectjrt` y `aspectjweaver` para soportar la programación orientada a aspectos, permitiendo la implementación de cross-cutting concerns como logging y seguridad de manera modular.

- **Plugins**:
  - **Maven Surefire Plugin**: Configurado para automatizar la ejecución de pruebas durante el proceso de construcción. Este plugin busca y ejecuta pruebas dentro del proyecto, integrándose con JUnit para reportar resultados.

Este archivo `pom.xml` es fundamental para el manejo eficiente del ciclo de vida del proyecto, desde la compilación hasta la ejecución de pruebas, garantizando que todos los componentes se integren adecuadamente bajo la configuración especificada.


## Ejecución desde una Terminal

Para ejecutar el código y los tests en una máquina de fábrica, sigue estos pasos detallados que incluyen la descarga del código, instalación de Java y Maven, y ejecución de los tests:


### 1. Instalación de Java JDK 17
#### Primero, necesitas asegurarte de que Java JDK 17 está instalado en tu sistema.
#### Puedes descargar e instalar Java JDK desde:
#### https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html
#### Sigue las instrucciones específicas para tu sistema operativo.

#### Verifica la instalación ejecutando:
```bash
java -version
```
# Esto debería mostrar la versión de Java JDK 17 instalada.

### 2. Instalación de Maven
#### Necesitas tener Maven para gestionar el proyecto y ejecutar los tests.
#### Puedes descargar Maven 3.8.4 desde:
#### https://maven.apache.org/download.cgi
#### Sigue las instrucciones de instalación en:
#### https://maven.apache.org/install.html

#### Verifica la instalación de Maven ejecutando:
```bash
mvn -version
```
#### Esto mostrará la versión de Maven y confirmará que está correctamente instalado.

### 3. Clonar el Repositorio
#### Si el código está disponible en GitHub, puedes clonar el repositorio utilizando Git.
#### Si aún no tienes Git instalado, puedes descargarlo desde:
#### https://git-scm.com/downloads

#### Instala Git y luego ejecuta el siguiente comando para clonar el repositorio:
```bash
git clone https://github.com/sistemas-sw/impl-24.git
```
### 4. Cambiar al Directorio del Repositorio
#### Una vez clonado el repositorio, navega al directorio donde se encuentra el código:
```bash
cd impl-24/temas/aspectos/java/proyecto
```

### 5. Ejecutar los Tests con Maven
#### Finalmente, puedes ejecutar los tests utilizando Maven.
#### Desde el directorio del proyecto, ejecuta:
```bash
mvn clean
```
```bash
mvn test
```
#### Este comando compilará el proyecto y ejecutará todos los tests definidos, mostrando los resultados en la terminal.
