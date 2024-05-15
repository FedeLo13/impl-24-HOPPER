// Importamos la librería rxjs para trabajar con observables
import { Observable } from 'rxjs';
import { filter, map } from 'rxjs/operators';

// Definimos una interfaz funcional para representar un predicado
interface Predicate<T> {
    (value: T): boolean;
}

// Definimos una interfaz para representar un evento de carrera
interface Carrera {
    posicion: number;
    piloto: string;
    equipo: string;
    circuito: string;
    mejorTiempo: string;
}

// Creamos un flujo de datos simulado de carreras de Fórmula 1
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

// Ppredicado para filtrar eventos por el nombre del piloto
export const esConductor = (driverName: string):
    Predicate<Carrera> => (event: Carrera) => event.piloto === driverName;

// Lambda para transformar los circuitos a mayúsculas
export const circuitoToUpperCase = (stream: Observable<Carrera>):
    Observable<Carrera> =>
    stream.pipe(
        map(event => ({
            ...event,
            circuito: event.circuito.toUpperCase()
        }))
    );

// Lambda para determinar si el piloto hizo podio o es ganador
export const podioMensaje = (posicion: number) => {
    if (posicion === 1) {
        return "Hizo Podio y es Ganador!!!";
    } else if (posicion <= 3) {
        return "Hizo Podio!!!";
    } else {
        return "";
    }
};

// Lambda para calcular los puntos según la posición
export const calcularPuntos = (position: number): number => {
    switch (position) {
        case 1:
            return 25;
        case 2:
            return 18;
        case 3:
            return 15;
        case 4:
            return 12;
        case 5:
            return 10;
        case 6:
            return 8;
        case 7:
            return 6;
        case 8:
            return 4;
        case 9:
            return 2;
        case 10:
            return 1;
        default:
            return 0;
    }
};

// Función asincrónica para obtener los resultados como un string
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