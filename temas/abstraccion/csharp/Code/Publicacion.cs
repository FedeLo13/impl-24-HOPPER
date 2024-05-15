public abstract class Publicacion{
    protected DateTime fechaPublicacion;
    protected int ejemplares;

    public DateTime getFechaPublicacion(){
        return fechaPublicacion;
    }

    public int getEjemplares(){
        return ejemplares;
       
    }

    public abstract void mostrarDetalles();
}