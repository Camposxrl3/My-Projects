<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Libros Populares</title>
    <link rel="stylesheet" type="text/css" href="../../css/plantilla.css">
    <link rel="stylesheet" type="text/css" href="../../css/librosPopulares.css">
    <link rel="stylesheet" type="text/css" href="../../css/nav.css">
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
                <li><a href="librosPopulares.jsp" class="here">Libros populares</a></li>
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
    <form>
        <section class="tabla">
            <div class="usr">
                <h2>Los 4 libros mas populares</h2>
            </div>
            <div class="display">
                <table>
                    <tr>
                        <td><img src="../../imagenes/portada.jpg" class="img"></td>
                        <td><h2>Libro1</h2></td>

                    </tr>
                    <tr>
                        <td><h4>Numero de <br>peticiones: 30</h4></td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td><img src="../../imagenes/portada.jpg" class="img"></td>
                        <td><h2>Libro2</h2></td>
                    </tr>
                    <tr>
                        <td><h4>Numero de <br>peticiones: 25</h4></td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td><img src="../../imagenes/portada.jpg" class="img"></td>
                        <td><h2>Libro3</h2></td>
                    </tr>
                    <tr>
                        <td><h4>Numero de <br>peticiones: 24</h4></td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td><img src="../../imagenes/portada.jpg" class="img"></td>
                        <td><h2>Libro4</h2></td>
                    </tr>
                    <tr>
                        <td><h4>Numero de <br>peticiones: 23</h4></td>
                    </tr>
                </table>
            </div>
        </section>
    </form>
</main>
<footer>
    Footer
</footer>
</body>
</html>
