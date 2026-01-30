<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Logica.Registrar"%>
<%@ page import="java.util.Objects" %>
<%
    String msg, ms;
    String nombre = request.getParameter("nombre");
    String apellido = request.getParameter("apellido");
    String direccion = request.getParameter("direccion");
    String telefono = request.getParameter("telefono");
    String correo = request.getParameter("correo");
    String pass = request.getParameter("pass");
    String pass2 = request.getParameter("pass2");
    if(Objects.equals(pass2, pass)){
        Registrar registrar = new Registrar(nombre, apellido, direccion, telefono, correo, pass);
        ms = registrar.registrarUsuario();
        msg = "<label class='msg'>"+ms+"</label>";
        session.setAttribute("mensaje",msg);
        response.sendRedirect("../html/register.jsp");
    }
    else{
        msg = "<label class='msg'>Las contraseñas no coinciden...</label>";
        session.setAttribute("mensaje",msg);
        response.sendRedirect("../html/register.jsp");
    }
%>



