<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../css/catalogo.css">
    <link rel="stylesheet" href="../../css/plantilla.css">
    <title>Catalago</title>
</head>
<body>
<header class="encabezado">
    <div>
        <img src="../../imagenes/logo.png" class="logo">
    </div>
    <div class="title">
        <h1>BIBLIOTECA UTP</h1>
    </div>
    <div>
        <img src="../../imagenes/usuario.png" class="perfil">
    </div>
</header>
<nav>
    <a href="catalogo.jsp">
        <button class="aqui">
            <img src="../../imagenes/libro.png" class="imgnav">
            <h3 class="textonav">Catálago</h3>
        </button>
    </a>
    <a href="busqueda.jsp">
        <button class="botonav">
            <img src="../../imagenes/lupa.png" class="imgnav">
            <h3 class="textonav">Busqueda</h3>
        </button>
    </a>
    <a href="notificacion.jsp">
        <button class="botonav">
            <img src="../../imagenes/campana.png" class="imgnav">
            <h3 class="textonav">Notificaciones</h3>
        </button>
    </a>
</nav>
<main>
    <%
        if(session.getAttribute("admin") != null){
            session.removeAttribute("admin");
            response.sendRedirect("../login.jsp");
            String msg = "<label class'msg'>Usted no tiene autorización en esa página</label>";
            session.setAttribute("mensaje",msg);
        }
        else if(session.getAttribute("usuario") == null){
            response.sendRedirect("../login.jsp");
            String msg = "<label class='msg'>Debe Iniciar sesión</label>";
            session.setAttribute("mensaje",msg);
        }
    %>
    <div class="main">
        <div class="container">
            <img class="libro" src="../../imagenes/libro.png">
            <label>Nombre Libro</label><br><br>
            <label class="btn">Disponibilidad</label>
        </div>

        <div class="container">
            <img class="libro" src="../../imagenes/libro.png">
            <label>Nombre Libro</label><br><br>
            <label class="btn">Disponibilidad</label>
        </div>

        <div class="container">
            <img class="libro" src="../../imagenes/libro.png">
            <label>Nombre Libro</label><br><br>
            <label class="btn">Disponibilidad</label>
        </div>

        <div class="container">
            <img class="libro" src="../../imagenes/libro.png">
            <label>Nombre Libro</label><br><br>
            <label class="btn">Disponibilidad</label>
        </div>

        <div class="container">
            <img class="libro" src="../../imagenes/libro.png">
            <label>Nombre Libro</label><br><br>
            <label class="btn">Disponibilidad</label>
        </div>

        <div class="container">
            <img class="libro" src="../../imagenes/libro.png">
            <label>Nombre Libro</label><br><br>
            <label class="btn">Disponibilidad</label>
        </div>

        <div class="container">
            <img class="libro" src="../../imagenes/libro.png">
            <label>Nombre Libro</label><br><br>
            <label class="btn">Disponibilidad</label>
        </div>

        <div class="container">
            <img class="libro" src="../../imagenes/libro.png">
            <label>Nombre Libro</label><br><br>
            <label class="btn">Disponibilidad</label>
        </div>
    </div>
</main>
<footer>
    Footer
</footer>
</body>
</html>
