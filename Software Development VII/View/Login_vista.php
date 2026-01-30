<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8">
        <title>Inicio</title>
        <link rel="stylesheet" href="CSS/estilo.css">
    </head>
    <body>
        <main>
            <form class="form" action="index.php?m=iniciarUser" method="post">
                <h1>Inicio</h1>
                <input class="txt" type="email" id="email" name="email" placeholder="Email Address"><br><br>
                <input class="txt" type="password" id="Pass" name="pass" placeholder="Password"><br><br>
                <a class="link" href="index.php?m=registrar">Registrarse</a><br><br>
                <input class="btn" type="submit" value="Iniciar sesión"><br><br>
                <a class="link" href="index.php?m=recuperar">Olvido su contraseña?</a><br><br>
            </form>
        </main>
    </body>
</html>