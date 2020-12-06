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
        <form action="check.jsp" method="POST">
            Felhasználó név: <input type="text" name="username" value="" /><br>
            Jelszó: <input type="password" name="password" value="" /><br>
            <input type="submit" value="Bejelentkezés" name="login" /><br><br>
            Nincs még fiókja? <a href="register.jsp">Regisztráljon!</a><br>
            Adminisztrátori bejelentkezéshez kattintson <a href="adminlogin.jsp">ide</a>.<br>
        </form>
        <c:if test="${!empty param.errorMsg}">
            <hr>
            ${param.errorMsg}
        </c:if>
    </body>
</html>
