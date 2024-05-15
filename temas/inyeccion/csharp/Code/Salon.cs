public class Salon: Habitacion {
   
    public Salon(string nom, double m2){
        this.nombre = nom;
        this.metrosCuadrados = m2;
    }   
    public void VerTele(){
        Console.WriteLine("Viendo la tele...");
    }

    public void Sofa(){
        Console.WriteLine("Probando el sofá...");
    }

    public override void DetallesHabitacion(){
        Console.WriteLine("Salón de " + metrosCuadrados + " metros cuadrados.");
    }

    public override void ProbarHabitacion(){
        VerTele();
        Sofa();
    }
}