<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : login
    Created on : 2020.11.21., 19:05:11
    Author     : Ákos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<sql:setDataSource 
    var="intalk"
    driver="org.apache.derby.jdbc.ClientDriver"
    url="jdbc:derby://localhost:1527/IntAlkDB"
    scope="session"
    user="intalk"
    password="123456"
/>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bejelentkezés</title>
    </head>
    <body>
        <h1>Üdvözöljük!</h1>
        <h2>Kérjük jelentkezzen be!</h2>
        <div class="login">
        <form action="check.jsp" method="POST">
            <label> <b> Felhasználó név:</b></label><br> <input type="text" name="username" value="" id="user"placeholder="Felhasználó név"/><br><br>
            <label> <b> Jelszó:</b></label><br> <input type="password" name="password" value="" id="pass" placeholder="Jelszó"/><br><br>
            <input type="submit" value="Bejelentkezés" name="login" id="log"/><br><br>
            <label>Nincs még fiókja? <a href="register.jsp">Regisztráljon!</a></label><br>
            <label>Adminisztrátori bejelentkezéshez kattintson <a href="adminlogin.jsp">ide</a>.</label><br>
        </form>
        </div>
        <c:if test="${!empty param.errorMsg}">
            <hr>
            ${param.errorMsg}
        </c:if>
    </body>
</html>
