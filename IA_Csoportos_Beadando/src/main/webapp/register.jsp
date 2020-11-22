<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : register
    Created on : 2020.11.21., 19:06:26
    Author     : Ákos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Regisztráció</title>
    </head>
    <body>
        <h1>Regisztráció</h1>
        <form action="check.jsp" method="POST">
            E-mail cím: <input type="text" name="email" value="" /><br>
            Felhasználó név: <input type="text" name="username" value="" /><br>
            Jelszó: <input type="password" name="password" value="" /><br>
            Jelszó megerősítése: <input type="password" name="confirmpassword" value="" /><br>
            <input type="submit" value="Regisztráció" name="register" /><br><br>
            Visszatérek a <a href="login.jsp">Bejelentkezési</a> oldalra.<br>
        </form>
        <c:if test="${!empty param.errorMsg}">
            <hr>
            ${param.errorMsg}
        </c:if>
    </body>
</html>
