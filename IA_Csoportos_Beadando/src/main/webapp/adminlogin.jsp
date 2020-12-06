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
        <link rel="stylesheet" href="style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adminisztrátori bejelentkezés</title>
    </head>
    <body>
        <h1>Adminisztrátori bejelentkezés</h1>
        <div class="login">
        <form action="check.jsp" method="POST" name="login">
            <label> <b> Felhasználó név:</b></label><br><input type="text" name="username" value="" id="user" placeholder="Felhasználó név"/><br><br>
            <label> <b> Jelszó:</b></label><br><input type="password" name="password" value="" id="pass" placeholder="Jelszó"/><br><br>
            <input type="submit" value="Bejelentkezés" name="adminlogin" id="log" /><br><br>
            <label> Visszatérek a <a href="login.jsp">Bejelentkezési</a> oldalra.</label> <br>
        </form>
        </div>
        <c:if test="${!empty param.errorMsg}">
            <hr>
            ${param.errorMsg}
        </c:if>
    </body>
</html>
