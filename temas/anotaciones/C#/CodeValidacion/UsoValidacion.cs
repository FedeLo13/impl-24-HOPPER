class UsoValidacion
{
    static void Main(string[] args)
    {
        Validador validador = new Validador();
        
        Persona personaValida = new Persona
        {
            Nombre = "Juan",
            DNI = "123456789",
            Edad = 25,
            FechaNacimiento = new DateTime(1996, 5, 10)
        };

        Persona personaNoValida = new Persona
        {
            Nombre = "Pedro",
            DNI = "123489",
            Edad = 17,
            FechaNacimiento = new DateTime(1996, 5, 10)
        };

        foreach (var persona in new Persona[] { personaValida, personaNoValida })
        {
            validador.validar(persona);
        }
    }
}