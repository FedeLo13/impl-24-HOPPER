using System;
using System.Collections.Generic;
using Microsoft.Extensions.DependencyInjection;
public class CreaCasa
{
    private readonly IServiceProvider _serviceProvider;

    public CreaCasa()
    {
        var services = new ServiceCollection();

        // Uso de una fábrica para configurar las instancias con parámetros específicos
        services.AddTransient<Habitacion>((provider) => new CuartoDeBaño("Baño pequeño", 10));
        services.AddTransient<Habitacion>((provider) => new CuartoDeBaño("Baño grande", 20));
        services.AddTransient<Habitacion>((provider) => new Salon("Sala", 30));

        _serviceProvider = services.BuildServiceProvider();
    }

    public Casa CrearCasa()
    {
        var casa = new Casa();

        var habitaciones = _serviceProvider.GetServices<Habitacion>();
        foreach (var habitacion in habitaciones)
        {
            casa.AgregarHabitacion(habitacion);
        }

        return casa;
    }
}