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
            <h2>Új szavazások</h2>
            <sql:query  var="lekerdezes8" dataSource="${intalk}">
                SELECT t.ID, t.TITLE, t.QUESTION, t.ANSWER1, t.ANSWER2, t.ANSWER3, t.ANSWER4
                FROM TOPICS t WHERE t.ID not in 
                (SELECT vo.TOPIC FROM VOTES vo WHERE vo.USERID = <%= session.getAttribute("userid") %>)
            </sql:query>
            <c:forEach var = "row8" items = "${lekerdezes9.rows}">
                <h3><c:out value = "${row8.title}"/></h3>
                <c:out value = "${row8.question}"/><br>
                <input type="radio" name="${row8.ID}" value="1" /><c:out value = "${row8.answer1}"/><br>
                <input type="radio" name="${row8.ID}" value="2" /><c:out value = "${row8.answer2}"/><br>
                <input type="radio" name="${row8.ID}" value="3" /><c:out value = "${row8.answer3}"/><br>
                <input type="radio" name="${row8.ID}" value="4" /><c:out value = "${row8.answer4}"/><br>
                <input type="hidden" name="topicid" value="${row8.ID}" />
                <br><input type="submit" value="Szavazás" name="sendvote" />
                <hr>
            </c:forEach>
            <hr><br>

            <h2>Szavazások eredményei (ahova már adott le szavazatot)</h2>
            <sql:query  var="lekerdezes9" dataSource="${intalk}">
                SELECT t.TITLE, t.QUESTION, 
                t.ANSWER1, (SELECT COUNT(*) FROM VOTES v WHERE v.TOPIC=t.ID and v.SELECTEDANSWER = 1) as A1_VOTES, 
                t.ANSWER2, (SELECT COUNT(*) FROM VOTES v WHERE v.TOPIC=t.ID and v.SELECTEDANSWER = 2) as A2_VOTES,
                t.ANSWER3, (SELECT COUNT(*) FROM VOTES v WHERE v.TOPIC=t.ID and v.SELECTEDANSWER = 3) as A3_VOTES,
                t.ANSWER4, (SELECT COUNT(*) FROM VOTES v WHERE v.TOPIC=t.ID and v.SELECTEDANSWER = 4) as A4_VOTES
                 FROM TOPICS t WHERE t.ID in (SELECT vo.TOPIC FROM VOTES vo WHERE vo.USERID = <%= session.getAttribute("userid") %>)
            </sql:query>
            <table border = "1" width = "100%">
                <tr>
                   <th>Cím</th>
                   <th>A kérdés részletes leírása</th>
                   <th>1. válaszlehetőség</th>
                   <th>1. válaszlehetőségre adott válaszok száma</th>
                   <th>2. válaszlehetőség</th>
                   <th>2. válaszlehetőségre adott válaszok száma</th>
                   <th>3. válaszlehetőség</th>
                   <th>3. válaszlehetőségre adott válaszok száma</th>
                   <th>4. válaszlehetőség</th>
                   <th>4. válaszlehetőségre adott válaszok száma</th>
                </tr>
                <c:forEach var = "row8" items = "${lekerdezes9.rows}">
                   <tr>
                      <td> <c:out value = "${row8.title}"/></td>
                      <td> <c:out value = "${row8.question}"/></td>
                      <td> <c:out value = "${row8.answer1}"/></td>
                      <td> <c:out value = "${row8.a1_votes}"/></td>
                      <td> <c:out value = "${row8.answer2}"/></td>
                      <td> <c:out value = "${row8.a2_votes}"/></td>
                      <td> <c:out value = "${row8.answer3}"/></td>
                      <td> <c:out value = "${row8.a3_votes}"/></td>
                      <td> <c:out value = "${row8.answer4}"/></td>
                      <td> <c:out value = "${row8.a4_votes}"/></td>
                   </tr>
                </c:forEach>
            </table>
            <hr>
            <br><a href="user_main.jsp">Vissza a kezdőlapra!</a><br>
            <form action="check.jsp" method="POST">
                <br><hr><br>
            <input type="submit" name="logout" value="Kijelentkezés">
            </form>
            <c:if test="${!empty param.errorMsg}">
                <hr>
                ${param.errorMsg}
            </c:if>
        </body>
    </html>
<% }else{ %>
<jsp:forward page="login.jsp">
    <jsp:param name="errorMsg" value="Kérem jelentkezzen be!"/>
</jsp:forward>
<% } %> 
