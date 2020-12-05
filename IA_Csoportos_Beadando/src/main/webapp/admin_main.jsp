<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>

<% if((session.getAttribute("adminid")!=null)&&(session.getAttribute("usertype")=="admin")){ %>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Kezdőlap</title>
        </head>
        <body>
            <h1>Kezdőlap (admin)</h1>
            Felhasználó: <%= session.getAttribute("adminid") %><br>
            Fiók típusa: <%= session.getAttribute("usertype") %><br>
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