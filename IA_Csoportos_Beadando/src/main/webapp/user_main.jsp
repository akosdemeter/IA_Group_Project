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
            <link rel="stylesheet" href="style.css">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Kezdőlap</title>
        </head>
        <body>
            <h1>Kezdőlap (user)</h1>
            
            <br>
            <form action="user_myvote.jsp" method="POST"><input type="submit" value="Saját szavazások" id="utvalaszto">
            </form><br>
            <br><form action="user_othervote.jsp" method="POST"><input type="submit" value="Mások szavazásai" id="utvalaszto"></form><br>
            
            <form action="check.jsp" method="POST">
                <br><hr><br>
            <input type="submit" name="logout" value="Kijelentkezés" id="log">
            </form>
        </body>
    </html>
<% }else{ %>
<jsp:forward page="login.jsp">
    <jsp:param name="errorMsg" value="Kérem jelentkezzen be!"/>
</jsp:forward>
<% } %> 
