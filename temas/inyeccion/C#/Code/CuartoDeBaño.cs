using System;

public class CuartoDeBaño : Habitacion
{
    public CuartoDeBaño(string nom, double m2)
    {
        this.nombre = nom;
        this.metrosCuadrados = m2;
    }

    private void UsarVater()
    {
        Console.WriteLine("Probando el vater...");
       
    }

    private void UsarDucha()
    {
        Console.WriteLine("Probando la ducha...");
        
    }

    public override void ProbarHabitacion(){
        UsarVater();
        UsarDucha();
    }

    public override void DetallesHabitacion(){
        Console.WriteLine("Cuarto de baño de " + metrosCuadrados + " metros cuadrados.");
    }
}