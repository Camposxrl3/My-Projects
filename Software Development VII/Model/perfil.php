<?php
    class Perfil{
        public function cargarDatos(){
            include('Conexion.php');
            session_start();
            $email = $_SESSION['email'];
            $sql = "SELECT nombre, apellido, idprovincia, foto FROM usuarios WHERE email = '$email';";
            $sql_datos = mysqli_query($conexion,$sql);
            if(mysqli_num_rows($sql_datos) > 0){
                while($row = mysqli_fetch_assoc($sql_datos)){
                    $nombre = $row["nombre"];
                    $apellido = $row["apellido"];
                    $provincia = $row["idprovincia"];
                    $foto = $row['foto'];
                } 
            }
            
            $sql = "SELECT * FROM provincias;";
            $sql_provincias = mysqli_query($conexion, $sql);
            $provincias = array();
            $idprovincias = array();
            if(mysqli_num_rows($sql_provincias) > 0 ){
                while($row = mysqli_fetch_assoc($sql_provincias)){
                    array_push($idprovincias, $row['idprovincia']);
                    array_push($provincias, $row['provincia']);
                }
            }

            $_SESSION['nombre'] = $nombre;
            $_SESSION['apellido'] = $apellido;
            $_SESSION['provincias'] = $provincias;
            $_SESSION['idprovincias'] = $idprovincias;
            $_SESSION['idpUsuario'] = $provincia;
            $_SESSION['foto'] = $foto;
            mysqli_close($conexion);
        }
        public function listarUsuarios(){
            include('Conexion.php');
            $sql = "SELECT * FROM usuarios;";
            $resultado = mysqli_query($conexion, $sql);
    
            while($mostrar = mysqli_fetch_array($resultado)){
                echo "<tr>";
                echo "<td>".$mostrar['idusuarios']."</td>";
                echo "<td>".$mostrar['nombre']."</td>";
                echo "<td>".$mostrar['apellido']."</td>";
                echo "<td>".$mostrar['email']."</td>";
                echo "<td>".$mostrar['idprovincia']."</td>";
                echo "<tr>";
            }
            mysqli_close($conexion);
        }
    }

    

?>