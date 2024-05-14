import { Almacen, Articulo, ArticuloError } from './almacen';

// Error para los pedidos
export class PedidoError extends Error {
    private constructor(message: string) {
        super(message);
        this.name = 'PedidoError';
    }

    public static PedidoVacio(): PedidoError {
        return new PedidoError('El pedido no puede estar vacío.');
    }
}

export class PedidoService {
    private almacen: Almacen;

    constructor(almacen: Almacen) {
        this.almacen = almacen;
    }

    public async realizarPedido(pedido: Articulo[]): Promise<void> {
        // Comprueba si el pedido está vacío
        if (pedido === undefined || pedido.length === 0) throw PedidoError.PedidoVacio();

        // Comprueba si los articulos del pedido existen y si hay suficiente stock
        pedido.forEach(articuloPedido => {
            const { nombre, cantidad } = articuloPedido;
            const articuloStock = this.almacen.obtenerArticulosDisponibles().find(a => a.nombre === nombre);

            // Comprueba si el articulo existe o si hay suficiente stock
            try {
                this.verificarDisponibilidadArticulo(nombre, cantidad);
            } catch (error) {
                if (error instanceof Error) return error.message;
            }
        });

        // Acualiza el stock de los platos
        pedido.forEach(articuloPedido => {
            this.almacen.actualizarStock(articuloPedido);
        });

        return undefined;
    }

    private verificarDisponibilidadArticulo(nombre: string, cantidad: number): void {
        const articuloStock = this.almacen.obtenerArticulosDisponibles().find(a => a.nombre === nombre);

        // Comprueba si el plato existe
        if (articuloStock === undefined)
            ArticuloError.ArticuloNoEncontrado(nombre);

        // Comprueba si hay suficiente stock
        else if (articuloStock.cantidad < cantidad)
            ArticuloError.ArticuloStockInsuficiente(nombre);
    }
}