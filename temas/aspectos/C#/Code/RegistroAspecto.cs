
using PostSharp.Aspects;
using PostSharp.Serialization;

[PSerializable]
public class RegistroAspecto: OnMethodBoundaryAspect{
    public override void OnExit(MethodExecutionArgs args)
    {
        if(args.Method.Name == "mostrarDetalles"){

            Console.WriteLine("ASPECTO");
            RegistradorAcciones.registrarAccion("Se han consultado los detalles de un archivo");
        }
        else if(args.Method.Name == "solicitarRevision"){
            Console.WriteLine("ASPECTO");
            RegistradorAcciones.registrarAccion("Se ha solicitado una revisión");
        }
    }
    public override void OnEntry(MethodExecutionArgs args)
    {
        if(args.Method.Name == "solicitarRevision"){
            Console.WriteLine("ASPECTO");
            RegistradorAcciones.registrarAccion("¡Una revisión está a punto de ser solicitada!");
        }
    }
    public override void OnException(MethodExecutionArgs args)
    {
        if(args.Method.Name == "setFecha"){
            Console.WriteLine("ASPECTO");
            RegistradorAcciones.registrarAccion("Alguien que no conoce la clave ha intentado cambiar una fecha");
        }
    }
}