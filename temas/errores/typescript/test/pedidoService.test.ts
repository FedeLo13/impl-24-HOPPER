import { PedidoService, PedidoError } from './../src/pedidoService';
import { Restaurante, Plato, PlatoError } from './../src/restaurante';

describe('PedidoService', () => {
    let pedidoService: PedidoService;
    let restaurante: Restaurante;

    beforeEach(() => {
        restaurante = new Restaurante();
        pedidoService = new PedidoService(restaurante);
    });

    test('realizarPedido lanza un error si el pedido está vacío', async () => {
        // Pedido vacío
        const pedidoVacio: Plato[] = [];

        // Debe lanzar un error de PedidoError.PedidoVacio
        await expect(pedidoService.realizarPedido(pedidoVacio)).rejects.toThrow(PedidoError.PedidoVacio());
    });

    test('realizarPedido actualiza el stock de los platos y devuelve undefined si el pedido se realiza con éxito', async () => {
        // Configuración de los platos en el restaurante
        const plato1: Plato = { nombre: 'Plato1', cantidad: 10 };
        const plato2: Plato = { nombre: 'Plato2', cantidad: 5 };
        restaurante.insertarPlato(plato1);
        restaurante.insertarPlato(plato2);

        // Pedido exitoso
        const pedidoExitoso: Plato[] = [
            { nombre: 'Plato1', cantidad: 2 },
            { nombre: 'Plato2', cantidad: 3 }
        ];

        await expect(pedidoService.realizarPedido(pedidoExitoso)).resolves.toBeUndefined();

        // Comprobación de que el stock se ha actualizado correctamente
        expect(restaurante.obtenerPlatosDisponibles()).toEqual([
            { nombre: 'Plato1', cantidad: 8 },
            { nombre: 'Plato2', cantidad: 2 }
        ]);
    });

    test('realizarPedido lanza un error si el plato no existe en el restaurante', async () => {
        // Pedido con plato inexistente
        const pedidoPlatoInexistente: Plato[] = [
            { nombre: 'PlatoInexistente', cantidad: 2 }
        ];

        // Debe lanzar un error de PlatoError.PlatoNoEncontrado
        await expect(pedidoService.realizarPedido(pedidoPlatoInexistente)).rejects.toThrow(PlatoError.PlatoNoEncontrado('PlatoInexistente'));
    });

    test('realizarPedido lanza un error si no hay suficiente stock para el pedido', async () => {
        // Configuración de los platos en el restaurante
        const plato: Plato = { nombre: 'Plato3', cantidad: 2 };
        restaurante.insertarPlato(plato);

        // Pedido con cantidad mayor que el stock disponible
        const pedidoCantidadInsuficiente: Plato[] = [
            { nombre: 'Plato3', cantidad: 3 }
        ];

        await expect(pedidoService.realizarPedido(pedidoCantidadInsuficiente)).rejects.toThrow(PlatoError.PlatoStockInsuficiente('Plato3'));
    });
});
