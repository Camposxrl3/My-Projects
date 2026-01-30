<?php
    require_once('Model/perfil.php');
    session_start();
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
        <title>Panel</title>
        <link rel="stylesheet" href="CSS/panel.css">
    </head>
    <body>
        <header>
            <div>
                <h1 class="titulo">Bienvenido</h1>
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
            <table class="tabla">
                <tr>
                    <td class="t">id</td>
                    <td class="t">Nombre</td>
                    <td class="t">Apellido</td>
                    <td class="t">Email</td>
                    <td class="t">id Provincia</td>
                </tr>
                <?php $lista = new perfil();
                    $lista->listarUsuarios();
                ?>
            </table>
        </main>
    </body>
</html>