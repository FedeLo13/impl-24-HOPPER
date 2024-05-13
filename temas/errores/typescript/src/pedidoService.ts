import { LosPollosHermanos, Plato } from './restaurante';

// Error para los pedidos
class PedidoError extends Error { }

export class PedidoServicio {
    private losPollosHermanos: LosPollosHermanos;

    constructor() {
        this.losPollosHermanos = new LosPollosHermanos();
    }

    public async realizarPedido(pedido: Plato[]): Promise<string | undefined> {      
        // Comprueba si los platos del pedido existen y si hay suficiente stock
        pedido.forEach(platoPedido => {
            const { nombre, cantidad } = platoPedido;
            const platoStock = this.losPollosHermanos.obtenerPlatosDisponibles().find(p => p.nombre === nombre);
            
            // Comprueba si el plato existe o si hay suficiente stock
            try { this.verificarDisponibilidadPlato(nombre, cantidad); }
            catch (error) { return error.message; }
        });

        // Acualiza el stock de los platos
        pedido.forEach(platoPedido => {
            this.losPollosHermanos.actualizarStock(platoPedido);
        });

        return undefined;
    }

    private verificarDisponibilidadPlato(nombre: string, cantidad: number): void {
        const platoStock = this.losPollosHermanos.obtenerPlatosDisponibles().find(p => p.nombre === nombre);

        // Comprueba si el plato existe
        if (platoStock === undefined) {
            throw new PedidoError(`El plato ${nombre} no está disponible en Los Pollos Hermanos.`);
        }
        // Comprueba si hay suficiente stock
        if (platoStock.cantidad < cantidad) {
            throw new PedidoError(`No hay suficientes platos ${nombre} en Los Pollos Hermanos.`);
        }
    }
}