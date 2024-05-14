import { Restaurante, Plato } from './../src/restaurante';

describe('Restaurante', () => {
    let restaurante: Restaurante;

    beforeEach(() => {
        restaurante = new Restaurante();
    });

    test('insertarPlato añade un plato al stock', () => {
        const plato: Plato = { nombre: 'Plato1', cantidad: 10 };
        restaurante.insertarPlato(plato);
        expect(restaurante.obtenerPlatosDisponibles()).toContainEqual(plato);
    });

    test('actualizarStock reduce la cantidad de un plato en el stock', () => {
        const plato: Plato = { nombre: 'Plato1', cantidad: 10 };
        restaurante.insertarPlato(plato);
        restaurante.actualizarStock({ nombre: 'Plato1', cantidad: 1 });
        const platoActualizado = restaurante.obtenerPlatosDisponibles().find(p => p.nombre === 'Plato1');
        expect(platoActualizado && platoActualizado.cantidad).toBe(9);
    });

    test('actualizarStock lanza un error si el plato no existe en el stock', () => {
        expect(() => restaurante.actualizarStock({ nombre: 'PlatoInexistente', cantidad: 1 })).toThrowError('El plato PlatoInexistente no está disponible en Los Pollos Hermanos.');
    });

    test('actualizarStock lanza un error si la cantidad es mayor que la disponible en el stock', () => {
        const plato: Plato = { nombre: 'Plato1', cantidad: 10 };
        restaurante.insertarPlato(plato);
        expect(() => restaurante.actualizarStock({ nombre: 'Plato1', cantidad: 11 })).toThrowError('No hay suficientes platos Plato1 en Los Pollos Hermanos.');
    });
});
