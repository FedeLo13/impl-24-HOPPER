import express from 'express';
import bodyParser from 'body-parser';
import { PedidoService } from './pedidoService'; // Asegúrate de que la ruta sea correcta
import { Almacen, Articulo } from './almacen'; // Asegúrate de que la ruta sea correcta

const app = express();

app.use(express.static('web'));

app.get('/', function (req, res) {
    res.sendFile('index.html', { root: '../web' });
});


// Crear una instancia de Restaurante y agregar algunos platos
const restaurante = new Almacen();
restaurante.insertarArticulo({ nombre: 'Plato1', cantidad: 10 });
restaurante.insertarArticulo({ nombre: 'Plato2', cantidad: 5 });

const pedidoService = new PedidoService(restaurante);

app.use(bodyParser.json());

app.post('/realizarPedido', async (req, res) => {
    try {
        let pedido: Articulo[] = req.body;
        const { nombre, cantidad } = req.body;
        if (nombre === undefined || cantidad === undefined)
            pedido = [];

        await pedidoService.realizarPedido(pedido);
        res.status(200).send('Pedido realizado con éxito');
    } catch (error) {
        if (error instanceof Error) res.status(400).send(error.message);
    }
});

app.listen(3000, () => {
    console.log('Servidor escuchando en el puerto 3000');
});