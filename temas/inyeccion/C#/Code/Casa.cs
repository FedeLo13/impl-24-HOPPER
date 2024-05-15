
using System;

public class Casa
{
    private List<Habitacion> habitaciones; //Posible implementacion de iterable para poder cambiar
                                            //el contenedor de habitaciones sin cambiar el resto del código


    public Casa()
    {
        habitaciones = new List<Habitacion>();
    }

    public void AgregarHabitacion(Habitacion habitacion)
    {
        habitaciones.Add(habitacion);
    }
    public List<Habitacion> getHabitaciones(){
        return habitaciones;
    }

   
    //Metodos para mostrar y probar habitaciones
    public void MostrarHabitaciones()
    {
        Console.WriteLine("---------MOSTRANDO DETALLES----------------------");
        Console.WriteLine("Habitaciones en la casa:");
        foreach (Habitacion h in habitaciones)
        {
            h.DetallesHabitacion();
        }
        Console.WriteLine("-------------------------------------------------");
    }
    public void ProbarHabitaciones()
    {
        Console.WriteLine("---------PROBANDO HABITACIONES----------------------");
        foreach (Habitacion h in habitaciones)
        {
            h.ProbarHabitacion();
        }
        Console.WriteLine("----------------------------------------------------");
    }   
}