<?php
    class login{
        
        public function __construct($email, $password){
            $this->email = $email;
            $this->pass = md5($password);
        }
        public function iniciar(){
            include('Conexion.php');
            $sql = "SELECT email FROM usuarios WHERE email = '$this->email' and pass = '$this->pass';";
            $sql_email = mysqli_query($conexion,$sql);
                
            if(mysqli_num_rows($sql_email) > 0){
                $sql = "SELECT CONCAT_WS(' ', nombre, apellido) AS nombre_completo FROM usuarios WHERE email = '$this->email';";
                $sql_nombre = mysqli_query($conexion,$sql);
                if(mysqli_num_rows($sql_nombre) > 0){
                    while($row = mysqli_fetch_assoc($sql_nombre)){
                        $nombreCompleto = $row["nombre_completo"];
                    }
                }
                session_start();
                $_SESSION['usuario'] = $nombreCompleto;
                $_SESSION['email'] = $this->email;
                header("location:index.php?m=sesion");
                mysqli_close($conexion);
            }
            else{
                echo "<script> alert('Email o Contraseña incorrectos.'); location.href='index.php?m=iniciar';</script>";
                mysqli_close($conexion);
            }
        }
    }
?>