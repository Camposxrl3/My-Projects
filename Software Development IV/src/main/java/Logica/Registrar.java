package Logica;

import Conexion.Conexion;
import Modelo.RegistrarDAO;

import java.util.Objects;

public class Registrar {
    String nombre;
    String apellido;
    String direccion;
    String telefono;
    String correo;
    String pass;

    public Registrar(String nombre, String apellido, String direccion, String telefono, String correo, String pass){
        this.nombre = nombre;
        this.apellido = apellido;
        this.direccion = direccion;
        this.telefono = telefono;
        this.correo = correo;
        this.pass = pass;
    }

    public String registrarUsuario(){
        String ms;
        Conexion conexion = new Conexion();
        RegistrarDAO registrarDAO = new RegistrarDAO(this.nombre, this.apellido, this.direccion, this.telefono,
                this.correo, this.pass);
        try{
            ms = conexion.ejecutarUpdate(registrarDAO.insertar());
            if(Objects.equals(ms, "opExitosa")){
                return "El usuario ha sido registrado";
            }
            else{
                return "El correo ya existe";
            }
        }catch(Exception e){
            return e.getMessage();
        }
    }
}
