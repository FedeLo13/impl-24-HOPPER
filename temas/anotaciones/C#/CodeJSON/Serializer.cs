using System;
using Newtonsoft.Json;
public class Serializer
{
    public string Serialize(Persona persona)
    {
        if (persona == null)
        {
            throw new ArgumentNullException(nameof(persona), "La persona no puede ser nula.");
        }

        return JsonConvert.SerializeObject(persona);
    }

    public Persona? Deserialize(string json)
    {
        return JsonConvert.DeserializeObject<Persona>(json);
    }
}