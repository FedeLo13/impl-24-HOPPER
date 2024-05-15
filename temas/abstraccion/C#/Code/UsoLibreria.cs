public class UsoLibreria{
    public static void Main(){
        List<Publicacion> publicaciones  =
        [
            new Libro(DateTime.Now, 100, "Alejandro Sánchez", "Enum considered harmful"),
            new Libro(DateTime.Now, 500, "David Thomas", "The pragmatic programmer"),
            new Revista(DateTime.Now, 800, "UCA", 100),
            new Revista(DateTime.Now, 300, "National Geographic", 310),
        ];
        foreach(Publicacion p in publicaciones){
            p.mostrarDetalles();
        }
       
    }
}