<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8">
        <title>Registrarse</title>
        <link rel="stylesheet" href="CSS/estilo.css">
    </head>
    <body>
        <main>
            <form class="form" action="index.php?m=registrarUser" method="post">
                <h1>Registrarse</h1>
                <input class="txt" class="txt" type="text" id="nombre" name="nombre" placeholder="Nombre"><br><br>
                <input class="txt" type="text" id="apellido" name="apellido" placeholder="Apellido"><br><br>
                <input class="txt" type="email" id="email" name="email" placeholder="Email Address"><br><br>
                <input class="txt" type="password" id="Pass" name="pass" placeholder="Password"><br><br>
                <input class="txt" type="password" id="Pass2" name="pass2" placeholder="Confirmar Password"><br><br>
                <a class="link" href="index.php?m=iniciar">Iniciar sesión</a><br><br>
                <input class="btn" type="submit" value="Registrarse">
            </form>
        </main>
    </body>
</html>