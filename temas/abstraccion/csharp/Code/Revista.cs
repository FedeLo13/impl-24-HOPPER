public class Revista :Publicacion
{
    private string editorial;
    private int numero;

    public Revista(DateTime f, int e, string a, int num)
    {
        fechaPublicacion = f;
        ejemplares = e;
        editorial = a;
        numero = num;
    }
    public override void mostrarDetalles(){
        Console.WriteLine("Revista:\n");
        Console.WriteLine("Fecha de publicación: " + fechaPublicacion + "\n");
        Console.WriteLine("Ejemplares: " + ejemplares + "\n");
        Console.WriteLine("Editorial: " + editorial + "\n");
        Console.WriteLine("Edición número: " + numero + "\n");
        
    }
}
