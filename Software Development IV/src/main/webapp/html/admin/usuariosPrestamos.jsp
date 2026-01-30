<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../css/usuarios.css">
    <link rel="stylesheet" href="../../css/plantilla.css">
    <link rel="stylesheet" type="text/css" href="../../css/nav.css">
    <title>Usuarios con más Préstamos</title>
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

    <ul class="nav">
        <li>
            <a href="reportes.jsp" class="navbuttom">
                <div class="ord">
                    <img src="../../imagenes/libro.png" class="imgnav">
                    <h3 class="textonav">Reportes</h3>
                </div>

            </a>
        </li>

        <li>
            <a href="" class="navbuttom">
                <div class="ord">
                    <img src="../../imagenes/lupa.png" class="imgnav">
                    <h3 class="textonav">Devoluciones/Retiros</h3>
                </div>

            </a>
            <ul>
                <li><a href="devoluciones.jsp" class="submenu">Devoluciones</a></li>
                <li><a href="retiros.jsp" class="submenu">Retiros</a></li>
            </ul>
        </li>

        <li>
            <a href="" class="here">
                <div class="ord">
                    <img src="../../imagenes/campana.png" class="imgnav">
                    <h3 class="textonav">Informes Periodicos</h3>
                </div>

            </a>
            <ul>
                <li><a href="prestamos.jsp" class="submenu">Prestamos realizados</a></li>
                <li><a href="librosPopulares.jsp" class="submenu">Libros populares</a></li>
                <li><a href="usuariosPrestamos.jsp" class="here">Usuarios con mas Préstamos</a></li>
            </ul>
        </li>
    </ul>

    <!--<button class="botonav">
        <img src="../imagenes/libro.png" class="imgnav">
        <a href=""><h3 class="textonav">Reportes</h3></a>
    </button>
    <button class="botonav">
        <img src="../imagenes/lupa.png" class="imgnav">
        <a href=""><h3 class="textonav">Devoluciones/Retiros</h3></a>
    </button>
    <button class="botonav">
        <img src="../imagenes/campana.png" class="imgnav">
        <a href=""><h3 class="textonav">Informes Periodicos</h3></a>
    </button>-->
</nav>
<main>
    <%
        if(session.getAttribute("usuario") != null){
            session.removeAttribute("usuario");
            response.sendRedirect("../login.jsp");
            String msg = "<label class'msg'>Usted no tiene autorización en esa página</label>";
            session.setAttribute("mensaje",msg);
        }
        else if(session.getAttribute("admin") == null){
            response.sendRedirect("../login.jsp");
            String msg = "<label class='msg'>Debe Iniciar sesión</label>";
            session.setAttribute("mensaje",msg);
        }
    %>
    <div class="user-list">
        <div class="user">
            <div class="user-details">
                <p class="user-name">Nombre del Usuario</p>
                <p class="user-date">Fecha: 2023-10-28</p>
            </div>
            <div class="user-loan">
                <p class="loan-number">Número de Préstamos: 5</p>
                <button class="read-button">Leído</button>
                <!-- Esta parte se repite para la cantidad de usuarios que queramos -->

            </div>
        </div>
    </div>
</main>
<footer>
    Footer
</footer>
</body>
</html>

