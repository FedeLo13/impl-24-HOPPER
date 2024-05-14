// Platos del restaurante con sus ingredientes
export class Plato {
    nombre: string;
    cantidad:number; // Lista de ingredientes con su cantidad

    constructor(nombre: string, cantidad: number) {
        this.nombre = nombre;
        this.cantidad = cantidad;
    }
}

// Error para los platos
export class PlatoError extends Error {
    public tipo: string;
    private constructor(message: string, tipo: string) {
        super(message);
        this.name = 'PlatoError';
        this.tipo = tipo;
    }

    public static PlatoNoEncontrado(nombre: string): PlatoError {
        return new PlatoError(`El plato ${nombre} no está disponible en Los Pollos Hermanos.`, 'PlatoNoEncontrado');
    }

    public static PlatoStockInsuficiente(nombre: string): PlatoError {
        return new PlatoError(`No hay suficientes platos ${nombre} en Los Pollos Hermanos.`, 'PlatoStockInsuficiente');
    }
 }

// Clase principal del restaurante
export class Restaurante {
    private stockPlatos: Plato[] = [];

    public obtenerPlatosDisponibles(): Plato[] {
        return this.stockPlatos;
    }

    public insertarPlato(plato: Plato): void {
        this.stockPlatos.push(plato);
    }

    // Resta el stock de los platos
    public actualizarStock(platoPedido: Plato): void {
        // Itera sobre los platos del pedido
        const plato = this.stockPlatos.find(p => p.nombre === platoPedido.nombre);

        // Comprueba si el plato existe
        if (plato === undefined) {
            throw PlatoError.PlatoNoEncontrado(platoPedido.nombre);
        
        // Comprueba si hay suficiente stock
        } else if (plato.cantidad < platoPedido.cantidad) {
            throw PlatoError.PlatoStockInsuficiente(platoPedido.nombre);
        
        // Actualiza el stock de los platos    
        } else {
            plato.cantidad -= platoPedido.cantidad; // Resta la cantidad de platos del stock
        }
    }
}