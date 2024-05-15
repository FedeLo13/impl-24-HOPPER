using System;
using Xunit;

public class SerializerTests
{
    private Serializer serializer;

    public SerializerTests()
    {
        serializer = new Serializer();
    }

    [Fact]
    public void Serialize_ValidPersona_ReturnsJsonString()
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
        string json = serializer.Serialize(persona);

        // Assert
        Assert.NotNull(json);
        Assert.NotEmpty(json);
    }

    [Fact]
    public void Deserialize_ValidJson_ReturnsPersonaObject()
    {
        // Arrange
        string json = "{\"Nombre\":\"Juan\",\"DNI\":\"12345678A\",\"Edad\":30,\"FechaNacimiento\":\"1992-05-10T00:00:00\"}";

        // Act
        Persona? persona = serializer.Deserialize(json);

        // Assert
        Assert.NotNull(persona);
        Assert.Equal("Juan", persona.Nombre);
        Assert.Equal("12345678A", persona.DNI);
        Assert.Equal(30, persona.Edad);
        Assert.Equal(new DateTime(1992, 5, 10), persona.FechaNacimiento);
    }
}
