public class Inmobiliaria
{
    public static void Main()
    {
        CreaCasa creaCasas = new CreaCasa();
        Casa casa = creaCasas.CrearCasa();


        casa.MostrarHabitaciones();

        casa.ProbarHabitaciones();
    }
}   