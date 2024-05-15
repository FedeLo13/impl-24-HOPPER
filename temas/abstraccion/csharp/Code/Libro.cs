using System;

public class Libro :Publicacion
{
    private string autor;
    private string titulo;


    public string getAutor()
    {
        return autor;
    }

    public string getTitulo()
    {
        return titulo;
    }
    public Libro(DateTime f, int e, string a, string t)
    {
        fechaPublicacion = f;
        ejemplares = e;
        autor = a;
        titulo = t;
    }

    public override void mostrarDetalles(){
        Console.WriteLine("Libro:\n");
        Console.WriteLine("Fecha de publicación: " + fechaPublicacion + "\n");
        Console.WriteLine("Ejemplares: " + ejemplares + "\n");
        Console.WriteLine("Título: " + titulo + "\n");
        Console.WriteLine("Autor: " + autor + "\n");
        
    }
}
