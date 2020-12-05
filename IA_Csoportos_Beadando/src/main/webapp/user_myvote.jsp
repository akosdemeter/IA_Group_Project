<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

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
            <title>Saját szavazások</title>
        </head>
        <body>
            <h1>Saját szavazások (user)</h1>
            Felhasználó: <%= session.getAttribute("userid") %><br>
            Fiók típusa: <%= session.getAttribute("usertype") %><br>
            <hr><br>

            <form action="check.jsp" method="POST">
                <h2>Új szavazás</h2>
                Cím: <input type="text" name="title" value="" /><br>
                A kérdés részletes leírása: <input type="text" name="question" value="" /><br>
                1. válaszlehetőség: <input type="text" name="answer1" value="" /><br>
                2. válaszlehetőség: <input type="text" name="answer2" value="" /><br>
                3. válaszlehetőség: <input type="text" name="answer3" value="" /><br>
                4. válaszlehetőség: <input type="text" name="answer4" value="" /><br>
                <input type="submit" value="Szavazás létrehozása" name="createvote" /><br>
                <hr><br>
                <!--ha lesz rá idő plusz funkció,
                hogy több választós is lehet a szavazás, 
                illetve lehet több lehetőségnek is hely -->
                <sql:query  var="lekerdezes7" dataSource="${intalk}">
                    SELECT t.TITLE, t.QUESTION, 
                    t.ANSWER1, (SELECT COUNT(*) FROM VOTES v WHERE v.TOPIC=t.ID and v.SELECTEDANSWER = 1) as A1_VOTES, 
                    t.ANSWER2, (SELECT COUNT(*) FROM VOTES v WHERE v.TOPIC=t.ID and v.SELECTEDANSWER = 2) as A2_VOTES,
                    t.ANSWER3, (SELECT COUNT(*) FROM VOTES v WHERE v.TOPIC=t.ID and v.SELECTEDANSWER = 3) as A3_VOTES,
                    t.ANSWER4, (SELECT COUNT(*) FROM VOTES v WHERE v.TOPIC=t.ID and v.SELECTEDANSWER = 4) as A4_VOTES
                     FROM TOPICS t WHERE t.USERID = <%= session.getAttribute("userid") %>
                </sql:query>
                <h2>Korábbi szavazások eredményei</h2>
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
                    <c:forEach var = "row" items = "${lekerdezes7.rows}">
                       <tr>
                          <td> <c:out value = "${row.title}"/></td>
                          <td> <c:out value = "${row.question}"/></td>
                          <td> <c:out value = "${row.answer1}"/></td>
                          <td> <c:out value = "${row.a1_votes}"/></td>
                          <td> <c:out value = "${row.answer2}"/></td>
                          <td> <c:out value = "${row.a2_votes}"/></td>
                          <td> <c:out value = "${row.answer3}"/></td>
                          <td> <c:out value = "${row.a3_votes}"/></td>
                          <td> <c:out value = "${row.answer4}"/></td>
                          <td> <c:out value = "${row.a4_votes}"/></td>
                       </tr>
                    </c:forEach>
                </table>
                <!--A törlés fukció még nincs benne-->
                <br><a href="user_main.jsp">Vissza a kezdőlapra!</a><br>
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
