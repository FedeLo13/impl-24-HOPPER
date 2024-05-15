using Newtonsoft.Json;
using System;

public class Persona
{
    [JsonProperty("nombre")]
    public string? Nombre { get; set; }

    [JsonProperty("dni")]
    public string? DNI { get; set; }

    [JsonProperty("edad")]
    public int Edad { get; set; }

    [JsonProperty("fechaNacimiento")]
    [JsonConverter(typeof(JsonDateConverter))]
    public DateTime FechaNacimiento { get; set; }
}
