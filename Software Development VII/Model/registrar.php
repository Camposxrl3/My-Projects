<?php
    class registrar{
        
        public function __construct($nombre, $apellido, $email, $password, $password2){
            $this->nombre = $nombre;
            $this->apellido = $apellido;
            $this->email = $email;
            $this->pass = md5($password);
            $this->pass2 = md5($password2);
        }
        public function registro(){
            if($this->pass != $this->pass2){
                echo "Las contaseñas no son iguales!";
            }
            else{
                include('conexion.php');
                $sql = "INSERT INTO usuarios (nombre, apellido, email, pass) 
                    VALUES('$this->nombre', '$this->apellido', '$this->email', '$this->pass');";

                try{
                    mysqli_query($conexion, $sql);
                    echo "<script> alert('El Usuario ha sido registrado'); location.href='index.php?m=registrar';</script>";
                    mysqli_close($conexion);
                }
                catch(Exception $e){
                    echo "<script> alert('El correo ya está registrado'); location.href='index.php?m=registrar';</script>";
                }
            }
        }  
    }
?>