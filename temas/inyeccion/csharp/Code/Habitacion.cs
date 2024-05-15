using System;
public abstract class Habitacion
{
    protected string? nombre;

    protected double metrosCuadrados;
    
    public double getMetrosCuadrados(){
        return metrosCuadrados;
    }
    public void setMetrosCuadrados(double m2){
        this.metrosCuadrados = m2;
    }
    public string? getNombre(){
        return nombre;
    }

    public abstract void DetallesHabitacion();
    public abstract void ProbarHabitacion();    
}