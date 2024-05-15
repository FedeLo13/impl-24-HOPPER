using Xunit;
using System.Collections.Generic; // Para List
using System; // Para Console
using System.IO; // Para pruebas de salida

public class CasaTests
{
    [Fact]
    public void TestAgregarHabitacion()
    {
        var casa = new Casa();
        var habitacion = new CuartoDeBaño("Baño 1", 10.5);

        casa.AgregarHabitacion(habitacion);

        // Verifica que la habitación fue agregada
        casa.getHabitaciones().Contains(habitacion);
    }

    [Fact]
    public void TestMostrarHabitaciones()
    {
        var casa = new Casa();
        var habitacion = new CuartoDeBaño("Baño 1", 10.5);
        casa.AgregarHabitacion(habitacion);

        var output = CaptureConsoleOutput(() => casa.MostrarHabitaciones());

        Console.WriteLine(output);
        // Verifica que la salida contenga el detalle de la habitación
        Assert.Contains("10", output);
    }

    [Fact]
    public void TestProbarHabitaciones()
    {
        var casa = new Casa();
        var habitacion = new CuartoDeBaño("Baño 1", 10.5);
        casa.AgregarHabitacion(habitacion);

        var output = CaptureConsoleOutput(() => casa.ProbarHabitaciones());

        Console.WriteLine(output);

        // Verifica que la salida contenga los resultados de las pruebas
        Assert.Contains("Probando el vater", output);
        Assert.Contains("Probando la ducha", output);
    }

    // Método auxiliar para capturar la salida de consola
    private string CaptureConsoleOutput(Action action)
    {
        var originalOutput = Console.Out;
        try
        {
            using (var stringWriter = new StringWriter())
            {
                Console.SetOut(stringWriter);
                action();
                return stringWriter.ToString();
            }
        }
        finally
        {
            Console.SetOut(originalOutput);
        }
    }
}
