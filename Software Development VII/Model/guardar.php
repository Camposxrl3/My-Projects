<?php
    class guardar{
        
        public function __construct($nombre,$apellido,$provincia, $foto){
            $this->nombre = $nombre;
            $this->apellido = $apellido;
            $this->provincia = $provincia;
            $this->foto = $foto;
        }
        public function guardarDatos(){
            include('Conexion.php');
            session_start();
            $email = $_SESSION['email'];
            if($this->foto == ""){
                $sql = "UPDATE usuarios SET nombre = '$this->nombre', apellido = '$this->apellido', idprovincia = '$this->provincia' WHERE email = '$email';";
                $sql_email = mysqli_query($conexion,$sql);
                mysqli_close($conexion);
                header('location:index.php?m=perfil');
            }
            else{
                $sql = "UPDATE usuarios SET nombre = '$this->nombre', apellido = '$this->apellido', idprovincia = '$this->provincia', foto = '$this->foto' WHERE email = '$email';";
                $sql_email = mysqli_query($conexion,$sql);
                mysqli_close($conexion);
                header('location:index.php?m=perfil');
            }
            
        }
    }
?>