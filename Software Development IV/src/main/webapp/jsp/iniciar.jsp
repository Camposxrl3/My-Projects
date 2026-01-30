<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Logica.Login"%>
<%
    String msg;
    String correo = request.getParameter("username");
    String pass = request.getParameter("password");
    Login login = new Login(correo, pass);
    if(login.tipoUsuario() == 1){
        session.setAttribute("admin", correo);
        response.sendRedirect("../html/admin/reportes.jsp");
    }
    else if(login.tipoUsuario() == 0){
        session.setAttribute("usuario", correo);
        response.sendRedirect("../html/user/catalogo.jsp");
    }
    else{
        msg = "<label class='msg'>Cedula o contraseña incorrectos</label>";
        session.setAttribute("mensaje",msg);
        response.sendRedirect("../html/login.jsp");
    }
%>


