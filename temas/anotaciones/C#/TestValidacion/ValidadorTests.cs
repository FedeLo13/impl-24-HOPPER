using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Xunit;

public class ValidadorTests
{
    private Validador validador;

    public ValidadorTests()
    {
        validador = new Validador();
    }

    [Fact]
    public void Validar_ValidPersona_PrintsValidMessage()
    {
        // Arrange
        var persona = new Persona
        {
            Nombre = "Juan",
            DNI = "12345678A",
            Edad = 30,
            FechaNacimiento = new DateTime(1992, 5, 10)
        };

        // Act
        using (var consoleOutput = new ConsoleOutput())
        {
            validador.validar(persona);

            // Assert
            Assert.Contains($"VALIDANDO A {persona.Nombre}...", consoleOutput.GetOuput());
            Assert.Contains("La persona es válida.", consoleOutput.GetOuput());
        }
    }

    [Fact]
    public void Validar_InvalidPersona_PrintsErrorMessages()
    {
        // Arrange
        var persona = new Persona
        {
            Nombre = "", // Nombre vacío, lo que debería ser inválido según las reglas de validación
            DNI = "12345678A",
            Edad = 30,
            FechaNacimiento = new DateTime(1992, 5, 10)
        };

        // Act
        using (var consoleOutput = new ConsoleOutput())
        {
            validador.validar(persona);

            // Assert
            Assert.Contains($"VALIDANDO A {persona.Nombre}...", consoleOutput.GetOuput());
            Assert.Contains("El nombre es obligatorio.", consoleOutput.GetOuput());
        }
    }
}

public class ConsoleOutput : IDisposable
{
    private readonly System.IO.StringWriter stringWriter;
    private readonly System.IO.TextWriter originalOutput;

    public ConsoleOutput()
    {
        stringWriter = new System.IO.StringWriter();
        originalOutput = Console.Out;
        Console.SetOut(stringWriter);
    }

    public string GetOuput()
    {
        return stringWriter.ToString();
    }

    public void Dispose()
    {
        Console.SetOut(originalOutput);
        stringWriter.Dispose();
    }
}
