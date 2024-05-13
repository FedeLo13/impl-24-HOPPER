package uca.iiss;
import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class Robot {
    private String id;
    private String nombre;
    private String material;
    private Date fechaFabricacion;
    private String fabricante;

    public Robot() {} // Constructor por defecto

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public Date getFechaFabricacion() {
        return fechaFabricacion;
    }

    public void setFechaFabricacion(String fechaFabricacion) {
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        try {
            Date date = formatter.parse(fechaFabricacion);
            this.fechaFabricacion = date;
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }


    public String getFabricante() {
        return fabricante;
    }

    public void setFabricante(String fabricante) {
        this.fabricante = fabricante;
    }

}
