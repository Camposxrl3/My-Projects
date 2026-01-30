<?php 
    session_start();
    $varsesion = $_SESSION['email'];
    if($varsesion == null || $varsesion = '' || time() - $_SESSION['time'] > 60){
        session_destroy();
        header("location:index.php?m=iniciar");
    }
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8">
        <title>Recuperación</title>
        <link rel="stylesheet" href="CSS/estilo.css">
    </head>
    <body>
        <main>
            <form class="form" action="index.php?m=Enviar" method="post">
                <h1>Recuperar Contraseña</h1>
                <label><?php echo $_SESSION['email']?></label><br><br>
                <input class="txt" type="password" id="pass" name="pass" placeholder="Nueva contraseña"><br><br>
                <input class="btn" type="submit" name="guardar" value="Guardar"><br><br>
            </form>
        </main>
    </body>
</html>