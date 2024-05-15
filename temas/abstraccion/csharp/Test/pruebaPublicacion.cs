using System;
using Xunit;
using System.IO;
using System.Text;

public class PruebasPublicacion
{
    // Test para comprobar la salida de mostrarDetalles en Libro
    [Fact]
    public void TestLibroMostrarDetalles()
    {
        var libro = new Libro(new DateTime(2023, 4, 24), 100, "Alejandro Sánchez", "Enum considered harmful");

        var output = new StringWriter();
        Console.SetOut(output);

        libro.mostrarDetalles();

        // Fragmentos que queremos verificar en la salida
        Assert.Contains("Libro:", output.ToString());
        Assert.Contains("24/4/2023", output.ToString());
        Assert.Contains("Ejemplares: 100", output.ToString());
        Assert.Contains("Título: Enum considered harmful", output.ToString());
        Assert.Contains("Autor: Alejandro Sánchez", output.ToString());
    }

    // Test para comprobar la salida de mostrarDetalles en Revista
    [Fact]
    public void TestRevistaMostrarDetalles()
    {
        var revista = new Revista(new DateTime(2023, 4, 24), 800, "UCA", 100);

        var output = new StringWriter();
        Console.SetOut(output);

        revista.mostrarDetalles();

        // Fragmentos que queremos verificar en la salida
        Assert.Contains("Revista:", output.ToString());
        Assert.Contains("24/4/2023", output.ToString());
        Assert.Contains("Ejemplares: 800", output.ToString());
        Assert.Contains("Editorial: UCA", output.ToString());
        Assert.Contains("Edición número: 100", output.ToString());
    }
}

