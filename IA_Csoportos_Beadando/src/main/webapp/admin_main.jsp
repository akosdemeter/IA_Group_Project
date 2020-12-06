<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>

<% if((session.getAttribute("adminid")!=null)&&(session.getAttribute("usertype")=="admin")){ %>
    <!DOCTYPE html>
    <html>
        <head>
            <link rel="stylesheet" href="style.css">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Kezdőlap</title>
        </head>
        <body>
            <h1>Kezdőlap (admin)</h1>
            Felhasználó: <%= session.getAttribute("adminid") %><br>
            Fiók típusa: <%= session.getAttribute("usertype") %><br>
            <sql:query var="szavazasjovahagyas" dataSource="${intalk}">
                SELECT t.ID,t.TITLE,t.QUESTION,t.ANSWER1,t.ANSWER2,t.ANSWER3,t.ANSWER4 FROM TOPICS t WHERE t.ADMIN is NULL
            </sql:query>
            <div class="table-vote">
                <div class="header">Jóváhagyásra váró szavazások:</div>
            <table>
                <tr>
                    <th>Cím</th>
                    <th>A kérdés részletes leírása</th>
                    <th>1. válaszlehetőség</th>
                    <th>2. válaszlehetőség</th>
                    <th>3. válaszlehetőség</th>
                    <th>4. válaszlehetőség</th>
                    <th>Opciók</th>
                </tr>
                <c:forEach var="szavazassorok" items="${szavazasjovahagyas.rows}">
                    <tr>
                    <td><c:out value="${szavazassorok.title}"/></td>
                    <td><c:out value="${szavazassorok.question}"/></td>
                    <td><c:out value="${szavazassorok.answer1}"/></td>
                    <td><c:out value="${szavazassorok.answer2}"/></td>
                    <td><c:out value="${szavazassorok.answer3}"/></td>
                    <td><c:out value="${szavazassorok.answer4}"/></td>
                    <td>            
                        <form action="check2.jsp" method="POST" name="jovahagyo">  
                            <input type="hidden" name="jovahagyid" value="${szavazassorok.id}">
                            <input type="submit" name="jovahagy" value="Jóváhagyás" id="adminbtn"> 
                        </form>                            
                        <form action="check2.jsp" method="POST" name="elutasit" >
                            <input type="hidden" name="elutasitid" value="${szavazassorok.id}">
                        <input type="submit" name="elutasit" value="Elutasítás" id="adminbtn">
                        </form></td>
                    </tr>
                </c:forEach>
            </table>
            </div>
            <form action="check.jsp" method="POST" name="kijelentkezo">
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