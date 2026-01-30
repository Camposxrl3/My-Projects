package Modelo;

public class RegistrarDAO {
    String nombre;
    String apellido;
    String direccion;
    String telefono;
    String correo;
    String pass;

    public RegistrarDAO(String nombre, String apellido, String direccion, String telefono, String correo, String pass){
        this.nombre = nombre;
        this.apellido = apellido;
        this.direccion = direccion;
        this.telefono = telefono;
        this.correo = correo;
        this.pass = pass;
    }

    public String insertar(){
        return "INSERT INTO usuarios(nombre, apellido, direccion, telefono, correo, pass) " +
                "VALUES('"+this.nombre+"','"+this.apellido+"', '"+this.direccion+"', '"+this.telefono+
                "', '"+this.correo+"', '"+this.pass+"');";
    }
}
