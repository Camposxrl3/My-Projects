<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= "Asignacion4.7" %></title>
    <link rel="stylesheet" href="css/plantilla.css">
</head>
<body>
    <header>
        <img src="" class="logo">
        <div class="title">
            <h1><%= "Tablas de multiplicar del 1 al 10" %></h1>
        </div>
    </header>
    <nav></nav>
    <main class="contenedor">
        <% for (int i = 1; i <= 10; i++) { %>
            <div class="tabla">
                <h2>La tabla del <%= i %></h2>
                <table>
                    <tr>
                        <th>Número</th>
                        <th>Resultado</th>
                    </tr>
                    <% for (int j = 1; j <= 10; j++) { %>
                        <tr>
                            <td><%= j %></td>
                            <td><%= i * j %></td>
                        </tr>
                    <% } %>
                </table>
            </div>
        <% } %>
    </main>
    <footer class="pie"></footer>
</body>
</html>