public class PruebaAspectos{
    public static void Main(){
        Investigacion Investigacion1 = new Investigacion(1,10,2,new DateTime(2024, 4, 1));
        Juicio juicio1 = new Juicio(Investigacion1, 50,  new DateTime(2024, 6, 1));

        Investigacion1.mostrarDetalles();
        juicio1.mostrarDetalles();
        Investigacion1.solicitarRevision();
        juicio1.solicitarRevision();
        //juicio1.setFecha(new DateTime(2024, 6, 14), "policia");
        juicio1.setFecha(new DateTime(2024, 6, 14), "contraseña");
        RegistradorAcciones.verAcciones();

    }
}