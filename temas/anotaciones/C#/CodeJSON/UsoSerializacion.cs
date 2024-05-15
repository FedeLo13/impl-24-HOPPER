using Newtonsoft.Json;
class UsoSerializacion
{
    static void Main(string[] args)
    {
        Persona persona = new Persona
        {
            Nombre = "Juan",
            DNI = "12345678A",
            Edad = 30,
            FechaNacimiento = new DateTime(1992, 5, 10)
        };

        Serializer serializer = new Serializer();
        string json = serializer.Serialize(persona);
        Console.WriteLine("OBJETO SERIALIZADO:");
        Console.WriteLine(json);

        Persona? personaDeserializada = serializer.Deserialize(json);;
        if(personaDeserializada is not null){
            Console.WriteLine("\n\n\nOBJETO DESERIALIZADO:");
            Console.WriteLine($"Nombre: {personaDeserializada.Nombre}");
            Console.WriteLine($"DNI: {personaDeserializada.DNI}");
            Console.WriteLine($"Edad: {personaDeserializada.Edad}");
            Console.WriteLine($"Fecha de nacimiento: {personaDeserializada.FechaNacimiento}");
        }
        
    }
}
