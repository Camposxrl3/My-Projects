<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../css/notificacion.css">
    <link rel="stylesheet" href="../../css/plantilla.css">
    <title>Notificación</title>
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
        <button class="botonav">
            <img src="../../imagenes/libro.png" class="imgnav">
            <h3 class="textonav">Catalogo</h3>
        </button>
    </a>
    <a href="busqueda.jsp">
        <button class="botonav">
            <img src="../../imagenes/lupa.png" class="imgnav">
            <h3 class="textonav">Busqueda</h3>
        </button>
    </a>
    <a href="notificacion.jsp">
        <button class="aqui">
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
    <div class="container">
        <div class="notification">
        </div>
        <h2>NOTIFICACION DEL LIBRO</h2>
        <ul>
            <p><strong>¡Nuevo libro disponible!</strong> "Título del Libro 1" está ahora en nuestro catálogo.</p>
        </ul>

    </div>

    <div class="container2">
        <div class="notification1">

        </div>

        <h2>NOTIFICACION DEL LIBRO</h2>
        <ul>
            <p><strong>¡Oferta especial!</strong> Compra "Título del Libro 2" con un descuento del 20% hasta el final de la semana.</p>
        </ul>

    </div>

    <div class="container3">
        <div class="notification2">

        </div>

        <h2>NOTIFICACION DEL LIBRO</h2>
        <ul>
            <p><strong>¡Nuevo libro disponible!</strong> "Título del libro" está ahora en nuestro catálogo.</p>
        </ul>
    </div>
</main>
<footer>
    Footer
</footer>
</body>

