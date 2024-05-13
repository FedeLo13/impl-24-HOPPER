
// Platos del restaurante con sus ingredientes
export class Plato {
    nombre: string;
    cantidad:number; // Lista de ingredientes con su cantidad

    constructor(nombre: string, cantidad: number) {
        this.nombre = nombre;
        this.cantidad = cantidad;
    }
}

// Error para los Platos
export class PlatoError extends Error { }

// Clase principal del restaurante
export class LosPollosHermanos {
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
        const plato = this.stockPlatos.find(p => p.nombre === plato.nombre);

        // Comprueba si el plato existe
        if (plato === undefined) {
            throw new PlatoError(`El plato ${plato.nombre} no está disponible en Los Pollos Hermanos.`);
        } else {
            plato.cantidad -= plato.cantidad; // Resta la cantidad de platos del stock
        }
    }
}