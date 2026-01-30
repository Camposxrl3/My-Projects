package Logica;

import Conexion.Conexion;
import Modelo.LoginDAO;

import java.sql.ResultSet;

public class Login {
    String correo;
    String pass;

    public Login(String correo, String pass){
        this.correo = correo;
        this.pass   = pass;
    }

    public int tipoUsuario(){
        Conexion miConexion = new Conexion();
        LoginDAO loginDAO = new LoginDAO(this.correo, this.pass);
        ResultSet resultado = miConexion.consultarQuery(loginDAO.consultar());
        try{
            if(resultado.next()){
                return resultado.getInt("nivel");
            }
            else{
                return -1;
            }
        }catch(Exception e){
            e.printStackTrace();
            return -1;
        }
    }
}
