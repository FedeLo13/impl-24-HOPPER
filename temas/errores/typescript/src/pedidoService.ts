import { Restaurante, Plato, PlatoError } from './restaurante';

// Error para los pedidos
export class PedidoError extends Error {
    public tipo: string;
    private constructor(message: string, tipo: string) {
        super(message);
        this.name = 'PedidoError';
        this.tipo = tipo;
    }

    public static PedidoVacio(): PedidoError {
        return new PedidoError('El pedido no puede estar vacío.', 'PedidoVacio');
    }
 }

export class PedidoService {
    private restaurante: Restaurante;

    constructor(restaurante: Restaurante) {
        this.restaurante = restaurante;
    }

    public async realizarPedido(pedido: Plato[]): Promise<void> {      
        // Comprueba si el pedido está vacío
        if (pedido === undefined || pedido.length === 0) throw PedidoError.PedidoVacio();

        // Comprueba si los platos del pedido existen y si hay suficiente stock
        pedido.forEach(platoPedido => {
            const { nombre, cantidad } = platoPedido;
            const platoStock = this.restaurante.obtenerPlatosDisponibles().find(p => p.nombre === nombre);
            
            // Comprueba si el plato existe o si hay suficiente stock
            try { this.verificarDisponibilidadPlato(nombre, cantidad); }
            catch (error) { return error.message; }
        });

        // Acualiza el stock de los platos
        pedido.forEach(platoPedido => {
            this.restaurante.actualizarStock(platoPedido);
        });

        return undefined;
    }

    private verificarDisponibilidadPlato(nombre: string, cantidad: number): void {
        const platoStock = this.restaurante.obtenerPlatosDisponibles().find(p => p.nombre === nombre);

        // Comprueba si el plato existe
        if (platoStock === undefined)
            PlatoError.PlatoNoEncontrado(nombre);
            
        // Comprueba si hay suficiente stock
        else if (platoStock.cantidad < cantidad)
            PlatoError.PlatoStockInsuficiente(nombre);
        
    }
}