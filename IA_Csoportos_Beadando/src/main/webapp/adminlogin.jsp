<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : adminlogin
    Created on : 2020.11.21., 19:06:57
    Author     : Ákos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adminisztrátori bejelentkezés</title>
    </head>
    <body>
        <h1>Adminisztrátori bejelentkezés</h1>
        <form action="check.jsp" method="POST">
            Felhasználó név: <input type="text" name="username" value="" /><br>
            Jelszó: <input type="password" name="password" value="" /><br>
            <input type="submit" value="Bejelentkezés" name="adminlogin" /><br><br>
            Visszatérek a <a href="login.jsp">Bejelentkezési</a> oldalra.<br>
        </form>
        <c:if test="${!empty param.errorMsg}">
            <hr>
            ${param.errorMsg}
        </c:if>
    </body>
</html>
