<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/register.css">
    <title>Registro</title>
</head>
<body>
<main>
    <%
        if(session.getAttribute("mensaje") == null){
            String msg = "";
            session.setAttribute("mensaje",msg);
        }
    %>
    <div class="login"> <!-- register -->
        <div class="loginCaja"> <!-- registerCaja -->
            <h2>Registro</h2>
            <%=session.getAttribute("mensaje")%>
            <form action="../jsp/registrar.jsp" method="post">
                <div class="input-group">
                    <img src="../imagenes/usuario.png" class="imagenes">
                    <input type="text" id="nombre" placeholder="nombre" name="nombre" required>
                </div>
                <div class="input-group">
                    <img src="../imagenes/usuario.png" class="imagenes">
                    <input type="text" id="apellido" placeholder="apellido" name="apellido" required>
                </div>
                <div class="input-group">
                    <img src="../imagenes/usuario.png" class="imagenes">
                    <input type="text" id="direccion" placeholder="direccion" name="direccion" required>
                </div>
                <div class="input-group">
                    <img src="../imagenes/usuario.png" class="imagenes">
                    <input type="text" id="telefono" placeholder="telefono" name="telefono" required>
                </div>
                <div class="input-group">
                    <img src="../imagenes/usuario.png" class="imagenes">
                    <input type="email" id="correo" placeholder="correo electronico" name="correo" required>
                </div>
                <div class="input-group">
                    <img src="../imagenes/contrasena.png" class="imagenes">
                    <input type="password" id="pass" placeholder="contraseña" name="pass" required>
                </div>
                <div class="input-group">
                    <img src="../imagenes/contrasena.png" class="imagenes">
                    <input type="password" id="pass2" placeholder="confirmar contraseña" name="pass2" required>
                </div>
                <button type="submit">Registrar</button><br>
                <a href="login.jsp">Iniciar Sesion</a>
            </form>
        </div>
    </div>
</main>
</body>
</html>