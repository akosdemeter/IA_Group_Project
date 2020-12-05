<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>

<% if((session.getAttribute("userid")!=null)&&(session.getAttribute("usertype")=="user")){ %>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Mások szavazásai</title>
        </head>
        <body>
            <h1>Mások szavazásai (user)</h1>
            Felhasználó: <%= session.getAttribute("userid") %><br>
            Fiók típusa: <%= session.getAttribute("usertype") %><br>
            
            <!--Megírni a  funkciót, hogy a többi felhasználó által létrehozott
            szavazásokra lehessen szavazatot leadni, és a leadott szavazatok
            eredményét megtekinteni-->
            
            <br><a href="user_main.jsp">Vissza a kezdőlapra!</a><br>
            
            <form action="check.jsp" method="POST">
                <br><hr><br>
            <input type="submit" name="logout" value="Kijelentkezés">
            </form>
        </body>
    </html>
<% }else{ %>
<jsp:forward page="login.jsp">
    <jsp:param name="errorMsg" value="Kérem jelentkezzen be!"/>
</jsp:forward>
<% } %> 
