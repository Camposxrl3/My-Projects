<?php
    @session_start();
    $varsesion = $_SESSION['usuario'];


    if($varsesion == null || $varsesion = ''){
        echo "<script> alert('Usted no tiene autorizacion'); location.href='index.php?m=iniciar';</script>";
        die();
    }
?> 

<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8">
        <title>Perfil</title>
        <link rel="stylesheet" href="CSS/panel.css">
    </head>
    <body>
        <header>
            <div>
                <h1 class="titulo">Perfil</h1>
                <ul class="nav">
                    <li><a href="index.php?m=sesion">Inicio</a></li>
                    <li><?php echo $_SESSION['usuario']?>
                        <ul>
                            <li><a href="index.php?m=perfil">Perfil</a></li>
                            <li><a href="index.php?m=cerrar">Cerrar sesión</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </header>
        <main>
            <form class="form" action="index.php?m=guardar" method="POST" enctype="multipart/form-data">
                <h2>Detalles de Usuario</h2><br><br>
                <div class="imagen">
                    <img src="data:image/jpg;base64,<?php echo base64_encode($_SESSION['foto'])?>">
                </div>
                <h3>Nombre: <input type="text" name="nombre" value="<?php echo $_SESSION['nombre']?>" required></h3><br>
                <h3>Apellido: <input type="text" name="apellido" value="<?php echo $_SESSION['apellido']?>" required></h3><br>
                <h3>Provincia: 
                    <?php 
                        $provincias = $_SESSION['provincias'];
                        $ids = $_SESSION['idprovincias'];
                        $selected = $_SESSION['idpUsuario'];
                        echo "<select name='provincia'>";
                        foreach($ids as $index => $id){
                            if($selected == $id){
                                echo "<option selected='selected' value='$id'>$provincias[$index]</option>";
                            }
                            else{
                                echo "<option value='$id'>$provincias[$index]</option>";
                            }
                            
                        }
                        echo "</select";
                    ?>
                </h3>
                <br>
                <h3>Direccion de correo:<br><?php echo $_SESSION['email']?></h3><br>
                <label class="btn">
                    Seleccionar Imagen
                    <input type="file" name="imagen">
                </label>
                <input class="btn" type="submit" value="Guardar">
            </form>   
        </main>

        
        
        <main>
        </main>
    </body>
</html>