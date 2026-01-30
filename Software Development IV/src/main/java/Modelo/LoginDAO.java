package Modelo;

public class LoginDAO {
    String correo;
    String pass;

    public  LoginDAO(String correo, String pass){
        this.correo = correo;
        this.pass   = pass;
    }

    public String consultar(){
        return"SELECT * FROM usuarios WHERE correo = '"+this.correo+"' and pass = '"+this.pass+"';";
    }
}
