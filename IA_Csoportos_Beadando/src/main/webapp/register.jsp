<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
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
        <link rel="stylesheet" href="style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Regisztráció</title>
    </head>
    <body>
        <h1>Regisztráció</h1>
        <div class="login">
        <form action="check.jsp" method="POST">
            <label><b>E-mail cím:</b></label><br> <input type="text" name="email" value="" id="mail" placeholder="E-mail cím"/><br><br>
            <label><b> Felhasználó név:</b></label> <input type="text" name="username" value="" id="user" placeholder="Felhasználó név"/><br><br>
            <label><b>Jelszó:</b> </label><br> <input type="password" name="password" value="" id="pass" placeholder="Jelszó"/><br><br>
            <label><b>Jelszó megerősítése:</b></label> <input type="password" name="confirmpassword" value="" id="pass" placeholder="Jelszó megerősítése"/><br><br>
            <input type="submit" value="Regisztráció" name="register" id="log"/><br><br>
            <label>Visszatérek a <a href="login.jsp">Bejelentkezési</a> oldalra.</label><br>
        </form>
        </div>
        <c:if test="${!empty param.errorMsg}">
            <hr>
            ${param.errorMsg}
        </c:if>
    </body>
</html>
