using Xunit;
using System.Collections.Generic; // Para List
using System; // Para Console
using System.IO; // Para pruebas de salida

public class RegistroTests
{
    [Fact]
    public void TestRegistrarAccion()
    {
        var output = CaptureConsoleOutput(() => RegistradorAcciones.registrarAccion("Acción de prueba"));
        Assert.Contains("Registro de acción: Acción de prueba", output);
    }

    [Fact]
    public void TestVerAcciones()
    {
        RegistradorAcciones.registrarAccion("Acción 1");
        RegistradorAcciones.registrarAccion("Acción 2");

        var output = CaptureConsoleOutput(() => RegistradorAcciones.verAcciones());

        Assert.Contains("ACCIONES RECOGIDAS POR ASPECTOS:", output);
        Assert.Contains("Acción 1", output);
        Assert.Contains("Acción 2", output);    
        
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
