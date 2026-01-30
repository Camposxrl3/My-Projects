package Conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Conexion {
    private Connection miConexion;
    private Statement miStatement;
    private String jdbc;
    private String url;
    private String usuario;
    private String contra;

    public Conexion(){
        this.miConexion = null;
        this.miStatement = null;
        this.jdbc = "com.mysql.jdbc.Driver";
        this.url = "jdbc:mysql://localhost:3306/biblioteca";
        this.usuario = "edgar";
        this.contra = "eCampos";
    }
    public void abrirConexion(){
        try{
            Class.forName(this.jdbc);
            System.out.println("Driver cargado con exito");
            try{
                this.miConexion = DriverManager.getConnection(this.url, this.usuario, this.contra);
                this.miStatement = this.miConexion.createStatement();
            }catch(Exception e){
                System.out.println("Error al conectar con la base, "+e);
            }
        }catch (Exception e){
            System.out.println("Ha ocurrido un error al cargar el driver "+e);
        }
    }

    public String ejecutarUpdate(String sql){
        try{
            this.abrirConexion();
            this.miStatement.executeUpdate(sql);
            return "opExitosa";
        }catch (Exception e){
            return e.toString();
        }
    }

    public ResultSet consultarQuery(String sql){
        ResultSet resultado = null;
        try{
            this.abrirConexion();
            resultado = this.miStatement.executeQuery(sql);

        }catch(Exception e){
            e.printStackTrace();
        }
        return resultado;
    }

}
