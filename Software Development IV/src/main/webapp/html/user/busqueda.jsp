<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../css/busqueda.css">
    <link rel="stylesheet" href="../../css/plantilla.css">
    <title>Busqueda</title>
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
<nav id="nav">
    <a href="catalogo.jsp">
        <button class="botonav">
            <img src="../../imagenes/libro.png" class="imgnav">
            <h3 class="textonav">Catálago</h3>
        </button>
    </a>

    <a href="busqueda.jsp">
        <button class="aqui">
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
    <div class="search-container">
        <h2>Buscar Libros</h2>
        <div class="search-options">
            <label for="title-search">
                <input type="checkbox" id="title-search">Buscar por Título
            </label>
            <label for="author-search">
                <input type="checkbox" id="author-search">Buscar por Autor
            </label>
            <label for="genre-search">
                <input type="checkbox" id="genre-search">Buscar por Género
            </label>
        </div>
        <div class="book-result">
            <img src="../../imagenes/libro.png" alt="Imagen del Libro">
            <h3>Nombre del Libro</h3>
            <div class="disponible">
                <p> No disponible</p>
            </div>
        </div>
    </div>
</main>
<footer>
    Footer
</footer>
</body>
</html>

