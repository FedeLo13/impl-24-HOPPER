import express, { Request, Response } from 'express';
import { getResultadosCarrera } from './formula1';

const app = express();
app.use(express.static('web'));

app.get('/getResultadosCarrera', async (req: Request, res: Response) => {
    let resultados: string[] = [];
    resultados.push(await getResultadosCarrera('Fernando Alonso'));
    resultados.push(await getResultadosCarrera('Lewis Hamilton'));
    resultados.push(await getResultadosCarrera('Max Verstappen'));
    resultados.push(await getResultadosCarrera('Charles Leclerc'));

    res.send(JSON.stringify(resultados));
});


app.listen(3333, () => {
    console.log('Servidor escuchando en el puerto 3333');
});