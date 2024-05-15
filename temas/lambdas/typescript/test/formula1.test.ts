import {esConductor, circuitoToUpperCase, podioMensaje, calcularPuntos, getResultadosCarrera} from './../src/formula1';
import { of } from 'rxjs';

describe('Formula 1', () => {
    const carrera = { posicion: 2, piloto: "Fernando Alonso", equipo: "Aston Martin", circuito: "Mónaco", mejorTiempo: "1:11.449"};
    test('esConductor devuelve el resultado correcto', () => {
        expect(esConductor('Fernando Alonso')(carrera)).toBe(true);
        expect(esConductor('Lewis Hamilton')(carrera)).toBe(false);
    });

    test('circuitoToUpperCase devuelve el resultado correcto', () => {
        const resultado = circuitoToUpperCase(of(carrera));
        resultado.subscribe(evento => {
            expect(evento.circuito).toBe('MÓNACO');
        });
    });

    test('podioMensaje devuelve el mensaje correcto', () => {
        expect(podioMensaje(1)).toBe('Hizo Podio y es Ganador!!!');
        expect(podioMensaje(2)).toBe('Hizo Podio!!!');
        expect(podioMensaje(4)).toBe('');
    });

    test('calcularPuntos devuelve los puntos correctos', () => {
        expect(calcularPuntos(1)).toBe(25);
        expect(calcularPuntos(2)).toBe(18);
        expect(calcularPuntos(3)).toBe(15);
        expect(calcularPuntos(4)).toBe(12);
        expect(calcularPuntos(5)).toBe(10);
        expect(calcularPuntos(11)).toBe(0);
    });

    test('getResultadosCarrera devuelve los resultados correctos', async () => {
        const resultado = await getResultadosCarrera('Fernando Alonso');
        expect(resultado).toContain('Fernando Alonso')
        expect(resultado).toContain('Aston Martin')
        expect(resultado).toContain('MÓNACO')
        expect(resultado).toContain('1:11.449')
        expect(resultado).toContain('Hizo Podio!!!')
        expect(resultado).toContain('18')
    });

    

    
});