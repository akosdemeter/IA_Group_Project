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
            <link rel="stylesheet" href="style.css">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Saját szavazások</title>
        </head>
        <body>
            <h1>Saját szavazások (user)</h1>
            <hr><br>
            <div class="login">
            <form action="check2.jsp" method="POST" name="createvote">
                <h2>Új szavazás</h2>
                <label><b>  Cím:</b></label> <input type="text" name="title" value="" id="vote"/><br><br>
                <label><b>A kérdés részletes leírása:</b> <input type="text" name="question" value="" id="vote"/><br><br>
                <label><b> 1. válaszlehetőség:</b></label> <input type="text" name="answer1" value="" id="vote"/><br><br>
                <label><b>2. válaszlehetőség:</b></label> <input type="text" name="answer2" value="" id="vote"/><br><br>
                <label><b>3. válaszlehetőség:</b></label> <input type="text" name="answer3" value="" id="vote"/><br><br>
                <label><b>4. válaszlehetőség:</b></label> <input type="text" name="answer4" value="" id="vote"/><br><br>
                <input type="submit" value="Szavazás létrehozása" name="createvote" id="votebtn"/><br><br>
                <hr>
            </form>
            </div>
                <!--ha lesz rá idő plusz funkció,
                hogy több választós is lehet a szavazás, 
                illetve lehet több lehetőségnek is hely -->
                <sql:query  var="lekerdezes7" dataSource="${intalk}">
                    SELECT t.TITLE, t.QUESTION, t.ID,
                    t.ANSWER1, (SELECT COUNT(*) FROM VOTES v WHERE v.TOPIC=t.ID and v.SELECTEDANSWER = 1) as A1_VOTES, 
                    t.ANSWER2, (SELECT COUNT(*) FROM VOTES v WHERE v.TOPIC=t.ID and v.SELECTEDANSWER = 2) as A2_VOTES,
                    t.ANSWER3, (SELECT COUNT(*) FROM VOTES v WHERE v.TOPIC=t.ID and v.SELECTEDANSWER = 3) as A3_VOTES,
                    t.ANSWER4, (SELECT COUNT(*) FROM VOTES v WHERE v.TOPIC=t.ID and v.SELECTEDANSWER = 4) as A4_VOTES
                     FROM TOPICS t WHERE t.ALLOWED = true and t.USERID = <%= session.getAttribute("userid") %>
                </sql:query>
                     <div class="table-vote">
                <div class="header">Korábbi engedélyezett szavazások eredményei</div>
                <table>
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
                       <th>Szavazás törlése</th>
                    </tr>
                    <c:forEach var = "row6" items = "${lekerdezes7.rows}">
                       <form action="check2.jsp" method="POST" name="${row6.ID}+form">
                       <input type="hidden" name="topicid" value="${row6.ID}" />
                       <tr>
                          <td> <c:out value = "${row6.title}"/></td>
                          <td> <c:out value = "${row6.question}"/></td>
                          <td> <c:out value = "${row6.answer1}"/></td>
                          <td> <c:out value = "${row6.a1_votes}"/></td>
                          <td> <c:out value = "${row6.answer2}"/></td>
                          <td> <c:out value = "${row6.a2_votes}"/></td>
                          <td> <c:out value = "${row6.answer3}"/></td>
                          <td> <c:out value = "${row6.a3_votes}"/></td>
                          <td> <c:out value = "${row6.answer4}"/></td>
                          <td> <c:out value = "${row6.a4_votes}"/></td>
                          <td><input type="submit" value="Törlés" name="deletevote" id="userbtn"/></td>
                       </tr>
                       </form>
                    </c:forEach>
                </table>
                     </div>
                <hr>
                <div class="table-vote">
                <div class="header">Jóváhagyásra váró szavazások</div>
                <sql:query  var="lekerdezes11" dataSource="${intalk}">
                    SELECT t.ID, t.TITLE, t.QUESTION, t.ANSWER1, t.ANSWER2, t.ANSWER3, t.ANSWER4
                     FROM TOPICS t WHERE t.ADMIN is null and t.ALLOWED = false and t.USERID = <%= session.getAttribute("userid") %>
                </sql:query>
                <table>
                    <tr>
                       <th>Cím</th>
                       <th>A kérdés részletes leírása</th>
                       <th>1. válaszlehetőség</th>
                       <th>2. válaszlehetőség</th>
                       <th>3. válaszlehetőség</th>
                       <th>4. válaszlehetőség</th>
                       <th>Szavazás törlése</th>
                    </tr>
                    <c:forEach var = "row11" items = "${lekerdezes11.rows}">
                       <form action="check2.jsp" method="POST" name="${row11.ID}+form">
                       <input type="hidden" name="topicid" value="${row11.ID}" />
                       <tr>
                          <td> <c:out value = "${row11.title}"/></td>
                          <td> <c:out value = "${row11.question}"/></td>
                          <td> <c:out value = "${row11.answer1}"/></td>
                          <td> <c:out value = "${row11.answer2}"/></td>
                          <td> <c:out value = "${row11.answer3}"/></td>
                          <td> <c:out value = "${row11.answer4}"/></td>
                          <td><input type="submit" value="Törlés" name="deletevote" id="userbtn"/></td>
                       </tr>
                       </form>
                    </c:forEach>
                </table>
                </div>
            <hr>
            <div class="table-vote">
                <div class="header">Elutasított szavazások</div>
                <sql:query  var="lekerdezes10" dataSource="${intalk}">
                    SELECT t.ID, t.TITLE, t.QUESTION, t.ANSWER1, t.ANSWER2, t.ANSWER3, t.ANSWER4
                     FROM TOPICS t WHERE t.ADMIN is not null and t.ALLOWED = false and t.USERID = <%= session.getAttribute("userid") %>
                </sql:query>
                <table>
                    <tr>
                       <th>Cím</th>
                       <th>A kérdés részletes leírása</th>
                       <th>1. válaszlehetőség</th>
                       <th>2. válaszlehetőség</th>
                       <th>3. válaszlehetőség</th>
                       <th>4. válaszlehetőség</th>
                       <th>Szavazás törlése</th>
                    </tr>
                    <c:forEach var = "row10" items = "${lekerdezes10.rows}">
                       <form action="check2.jsp" method="POST" name="${row10.ID}+form">
                       <input type="hidden" name="topicid" value="${row10.ID}" />
                       <tr>
                          <td> <c:out value = "${row10.title}"/></td>
                          <td> <c:out value = "${row10.question}"/></td>
                          <td> <c:out value = "${row10.answer1}"/></td>
                          <td> <c:out value = "${row10.answer2}"/></td>
                          <td> <c:out value = "${row10.answer3}"/></td>
                          <td> <c:out value = "${row10.answer4}"/></td>
                          <td><input type="submit" value="Törlés" name="deletevote" id="userbtn"/></td>
                       </tr>
                       </form>
                    </c:forEach>
                </table>
            </div>
            <hr>
            <form action="check.jsp" method="POST" name="logout">
                <br><label><b><a href="user_main.jsp">Vissza a kezdőlapra!</a></b></label><br>
                <br><hr><br>
                <input type="submit" name="logout" value="Kijelentkezés" id="log">
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
