<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/login.css">
    <title>Login</title>
</head>
<body>
<main>
    <%
        if(session.getAttribute("mensaje") == null){
            String msg = "";
            session.setAttribute("mensaje",msg);
        }
    %>
    <div class="login">
        <div class="loginCaja">
            <h2>Login</h2>
            <%=session.getAttribute("mensaje")%>
            <form action="../jsp/iniciar.jsp" method="post">
                <div class="input-group">
                    <img src="../imagenes/usuario.png" class="imagenes">
                    <input type="text" id="username" placeholder="usuario" name="username" required>
                </div>
                <div class="input-group">
                    <img src="../imagenes/contrasena.png" class="imagenes">
                    <input type="password" id="password" placeholder="contraseña" name="password" required>
                </div>
                <button type="submit">Iniciar Sesión</button><br>
                <a class="link" href="register.jsp">Registrarse</a>
            </form>
        </div>
    </div>
</main>
</body>
</html>

