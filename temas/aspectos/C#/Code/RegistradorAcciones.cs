public class RegistradorAcciones{
    private static List<string> acciones = new List<string>();
    public static void registrarAccion(string s){
        Console.WriteLine("Registro de acción: " + s + "\n");
        acciones.Add(s);
    }
    public static void verAcciones(){
        Console.WriteLine("ACCIONES RECOGIDAS POR ASPECTOS:");
        foreach(string s in acciones){
            Console.WriteLine(s);
        }
    }
}