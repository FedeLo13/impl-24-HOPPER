# Ejemplo Fórmula 1
Este ejemplo sirve para reflejar el uso de funciones anónimas (lambdas), interfaces funcionales y streams en el contexto de programación funcional.

El ejemplo se basa en tratar los datos que tenemos de registros de carreras de fórmula 1. El objetivo es obtener un string personalizado en base a los datos que tenemos.

## Breve introducción a Typescript
TypeScript es un lenguaje de programación desarrollado por Microsoft que mejora JavaScript utilizando tipado estático. Esto hace que el código sea más sólido seguro y escalable. Se compila a JavaScript y además tiene herramientas que facilitan el desarrollo, como autocompletado y verificación de tipos. Es compatible con el ecosistema de JavaScript, lo que permite la compatibilidad con JavaScript.

### Mecanismos de programación funcional en TypeScript

1. **Funciones anónimas (lambdas):** TypeScript permite definir funciones anónimas utilizando la sintaxis de flecha (=>). Estas funciones pueden ser asignadas a variables y pasadas como argumentos a otras funciones.

2. **Interfaces funcionales:** TypeScript permite definir interfaces funcionales que describen la forma de una función. Esto facilita la creación de funciones genéricas y el uso de tipos de función como parámetros o valores de retorno.

3. **Streams:** TypeScript proporciona la capacidad de trabajar con streams de datos utilizando la librería RxJS. Los streams permiten manipular y transformar secuencias de datos de manera declarativa y funcional.

## Explicación de [formula1.ts](./src/formula1.ts)
``` typescript
import { Observable } from 'rxjs';
import { filter, map } from 'rxjs/operators';
```
Se importa la librería `RxJS` y se extraen las clases y funciones que necesitaremos: `Observable`, `filter` y `map` del módulo `rxjs/operators`.

Un **observable** es una fuente de datos o eventos que pueden ser observados a lo largo del tiempo en un programa. Permite la creación de streams de datos asíncronos y su manipulación mediante suscripciones y operadores de transformación. Son una parte fundamental de la programación reactiva y funcional.

``` typescript
interface Predicate<T> {
    (value: T): boolean;
}

interface Carrera {
    posicion: number;
    piloto: string;
    equipo: string;
    circuito: string;
    mejorTiempo: string;
}
```

Se definen dos interfaces: `Predicate` para representar un predicado funcional que reciberá un valor de tipo `T` y devolverá un `booleano`, y `Carrera` para representar un evento de carrera con varios campos como la `posición`, el `piloto`, el `equipo`, el `circuito` y el `mejorTiempo`.

```typescript
function simularCarreraFormula1(): Observable<Carrera> {
    return new Observable<Carrera>(subscriber => {
        // Simulamos la emisión de eventos de carreras
        subscriber.next({ posicion: 3, piloto: "Lewis Hamilton", equipo: "Mercedes", circuito: "Monza", mejorTiempo: "1:20.123"});
        subscriber.next({ posicion: 1, piloto: "Max Verstappen", equipo: "Red Bull Racing", circuito: "Silverstone", mejorTiempo: "1:21.456"});
        subscriber.next({ posicion: 2, piloto: "Fernando Alonso", equipo: "Aston Martin", circuito: "Mónaco", mejorTiempo: "1:11.449"});
        subscriber.next({ posicion: 4, piloto: "Charles Leclerc", equipo: "Ferrari", circuito: "Spa-Francorchamps", mejorTiempo: "1:23.987"});
        subscriber.complete();
    });
}
```
Simulación de los datos de las carreras de Fórmula 1.

``` typescript 
export const esConductor = (driverName: string):
    Predicate<Carrera> => (event: Carrera) => event.piloto === driverName;

```

Función anónima que recibe el nombre de piloto y devuelve un predicado que verifica si el piloto de una carrera coincide con ese nombre.

```typescript
export const circuitoToUpperCase = (stream: Observable<Carrera>):
    Observable<Carrera> =>
    stream.pipe(
        map(event => ({
            ...event,
            circuito: event.circuito.toUpperCase()
        }))
    );
```
Función anónima que recibe un stream de carrera y devuelve un nuevo stream donde los nombres de los circuitos están en mayúsculas.

``` typescript
export const podioMensaje = (posicion: number) => {
    if (posicion === 1) {
        return "Hizo Podio y es Ganador!!!";
    } else if (posicion <= 3) {
        return "Hizo Podio!!!";
    } else {
        return "";
    }
};
```
Función anónima que recibe la posición de un piloto y devuelve un mensaje indicando si el piloto hizo podio o ganó la carrera.

``` typescript
export const calcularPuntos = (position: number): number => {
    switch (position) {
        case 1:
            return 25;
        case 2:
            return 18;
    /* ....... Resto de código ....... */
```
Función anónima que recibe la posición y devuelve la cantidad de puntos ganados según esa posición.

#### Función principal
``` typescript
export async function getResultadosCarrera(piloto: string): Promise<string> {
    let resultadosCarrera = '';

    // Simulamos el flujo de datos de carreras de Fórmula 1
    const carreraStream = simularCarreraFormula1();

    // Filtramos y transformamos el flujo de datos utilizando expresiones lambda y funciones anónimas
    const filtradaTransformadaStream = circuitoToUpperCase(
        carreraStream.pipe(filter(esConductor(piloto))));

    // Nos suscribimos al stream resultante para almacenar los valores
    await new Promise<void>((resolve, reject) => {
        filtradaTransformadaStream.subscribe({
            next(val) {
                // Obtenemos el mensaje del podio y los puntos del piloto
                const podio = podioMensaje(val.posicion);
                const puntos = calcularPuntos(val.posicion);
                
                resultadosCarrera = `¡${val.piloto}, de ${val.equipo}, terminó en la posición ${val.posicion} ${podio}, en el circuito ${val.circuito} siendo su mejor vuelta ${val.mejorTiempo}! Ganó ${puntos} puntos.\n`;
            },
            complete() {
                resolve();
            },
            error(error) {
                reject(error);
            }
        });
    });

    return resultadosCarrera;
}
```
Función asincrónica que recibe el nombre de un piloto y devuelve una promesa con los los resultados filtrados y modificados de la carrera del piloto.

Cuando se completa el stream de datos, se resuelve la promesa con un string.

## Explicación de [controller.ts](./src/controller.ts)
Este código crea un servidor web usando Express, que está escuchando en el puerto 3333. Cuando recibe una solicitud en la ruta '/getResultadosCarrera', llama a la función getResultadosCarrera para obtener los resultados de la carrera de varios pilotos de Fórmula 1. Espera las respuestas de cada piloto y las envía de vuelta al cliente como una lista de resultados en formato JSON.

## Explicación de [index.html](./web/index.html)
Web diseñada para mostrar los resultados del ejemplo.
```
async function fetchResultados() {
            let resultados = document.getElementById('Resultados');
            const response = await fetch('http://localhost:3333/getResultadosCarrera', {
            <!-- ...... Resto de Código ...... -->
            
```
Función asíncrona encargada de obtener los resultados de la carrera de Fórmula 1 a través de una solicitud HTTP.

## Instalar Dependencias
Se necesita `npm`, se puede instalar con algún gestor de packetes.
### Instalar `node.js`:
```
npm install npm@latest -g
```
###<a name="dependencias"></a> Instalar las dependencias
```
RUN npm install
```

## Pruebas
Para las pruebas se utiliza [formula1.test.ts](./test/formula1.test.ts).
Las pruebas se realizan con `Jest`, instalar antes las [dependencias](#dependencias).

### Ejecutar los test
```
npm test
```

## Construir y desplegar
### Crear la imagen de docker
```
docker build -t formula1_app . 
```
### Desplegar el contenedor con la aplicación
```
terraform init
terraform apply
```
Una vez se haya iniciado correctamente, la web estará dispoible en:
`localhost:3333` ;)

### Detener el contenedor
```
terraform destroy
```
