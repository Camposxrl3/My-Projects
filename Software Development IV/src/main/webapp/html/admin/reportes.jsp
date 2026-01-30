<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <title>Reportes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../css/reporte.css">
    <link rel="stylesheet" href="../../css/plantilla.css">
    <!--<link rel="stylesheet" href="../css/style.css">-->
    <link rel="stylesheet" type="text/css" href="../../css/nav.css">
</head>

<body>
<header class="encabezado">
    <div>
        <img src="../../imagenes/logo.png" class="logo">
    </div>
    <div class="tittle">
        <h1 class="tittle-header">BIBLIOTECA UTP</h1>
    </div>

    <div>
        <img src="../../imagenes/usuario.png" class="perfil">
    </div>
</header>

<nav id="nav">

    <ul class="nav">
        <li>
            <a href="reportes.jsp" class="here">
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
            <a href="" class="navbuttom">
                <div class="ord">
                    <img src="../../imagenes/campana.png" class="imgnav">
                    <h3 class="textonav">Informes Periodicos</h3>
                </div>

            </a>
            <ul>
                <li><a href="prestamos.jsp" class="submenu">Prestamos realizados</a></li>
                <li><a href="librosPopulares.jsp" class="submenu">Libros populares</a></li>
                <li><a href="usuariosPrestamos.jsp" class="submenu">Usuarios con mas Préstamos</a></li>
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
    <section class="content">
        <div class="report">
            <h2>Reporte 1</h2>
            <p>Este es el primer reporte. Ingrese una descripción aquí.</p>
            <label>
                <input type="checkbox"> Leido
            </label>
        </div>

        <div class="report">
            <h2>Reporte 2</h2>
            <p>Este es el segundo reporte. Ingrese una descripción aquí.</p>
            <label>
                <input type="checkbox"> Leido
            </label>
        </div>

        <div class="report">
            <h2>Reporte 3</h2>
            <p>Este es el tercer reporte. Ingrese una descripción aquí.</p>
            <label>
                <input type="checkbox">Leido
            </label>
        </div>
    </section>
</main>

<footer>
    footer
</footer>

</body>
</html>


<footer>
    footer
</footer>

</body>
</html>
