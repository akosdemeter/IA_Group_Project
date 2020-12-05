<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : check
    Created on : 2020.11.21., 19:07:49
    Author     : Ákos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<%!
    String userid;
    String adminid;
    String answerselected;
%>
<c:choose>
    <c:when test="${!empty param.login}">
        <c:choose>
            <c:when test="${(empty param.username) || (empty param.password)}">
                <jsp:forward page="login.jsp">
                    <jsp:param name="errorMsg" value="A felhasználó név/jelszó megadása kötelező!"/>
                </jsp:forward>
            </c:when>
            <c:otherwise>
                <sql:query var="lekerdezes" dataSource="${intalk}">
                    SELECT id FROM USERS WHERE username = '${param.username}' and password = '${param.password}'
                </sql:query>
                    <c:choose>
                        <c:when test="${lekerdezes.rowCount ne 0}">
                            <c:forEach var = "row" items = "${lekerdezes.rows}">
                                <c:set var = "id" value = "${row.id}"/>
                                <%userid = (String)pageContext.getAttribute("id").toString();%>
                            </c:forEach>
                            <% 
                                session.setAttribute("userid", userid);
                                session.setAttribute("usertype", "user");
                            %>
                            <jsp:forward page="user_main.jsp"/>
                        </c:when>
                        <c:otherwise>
                            <jsp:forward page="login.jsp">
                                <jsp:param name="errorMsg" value="Hibás felhasználónév vagy hibás jelszó!"/>
                            </jsp:forward>
                        </c:otherwise>
                    </c:choose>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${!empty param.adminlogin}">
        <c:choose>
            <c:when test="${(empty param.username) || (empty param.password)}">
                <jsp:forward page="adminlogin.jsp">
                    <jsp:param name="errorMsg" value="A felhasználó név/jelszó megadása kötelező!"/>
                </jsp:forward>
            </c:when>
            <c:otherwise>
                <sql:query var="lekerdezes2" dataSource="${intalk}">
                    SELECT id FROM ADMIN WHERE username = '${param.username}' and password = '${param.password}'
                </sql:query>
                    <c:choose>
                        <c:when test="${lekerdezes2.rowCount ne 0}">
                            <c:forEach var = "row2" items = "${lekerdezes2.rows}">
                                <c:set var = "id2" value = "${row2.id}"/>
                                <%adminid = (String)pageContext.getAttribute("id2").toString();%>
                            </c:forEach>
                            <% 
                                session.setAttribute("adminid", adminid);
                                session.setAttribute("usertype", "admin");
                            %>
                            <jsp:forward page="admin_main.jsp"/>
                        </c:when>
                        <c:otherwise>
                            <jsp:forward page="adminlogin.jsp">
                                <jsp:param name="errorMsg" value="Hibás felhasználónév vagy hibás jelszó!"/>
                            </jsp:forward>
                        </c:otherwise>
                    </c:choose>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${!empty param.register}">
        <c:choose>
            <c:when test="${(empty param.username) || (empty param.password) || (empty param.email) || (empty param.confirmpassword)}">
                <jsp:forward page="register.jsp">
                    <jsp:param name="errorMsg" value="Az adatok megadása kötelező!"/>
                </jsp:forward>
            </c:when>
            <c:otherwise>
                <sql:query var="lekerdezes3" dataSource="${intalk}">
                    SELECT * FROM USERS WHERE username = '${param.username}'
                </sql:query>
                <c:choose>
                    <c:when test="${lekerdezes3.rowCount ne 0}">
                        <jsp:forward page="register.jsp">
                            <jsp:param name="errorMsg" value="A megadott felhasználónév már foglalt, kérem válasszon másikat!"/>
                        </jsp:forward>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${fn:length(param.email) < 3 or fn:indexOf(param.email, '@')==-1}">
                                <jsp:forward page="register.jsp">
                                    <jsp:param name="errorMsg" value="Kérem, hogy az 'E-mail cím'-hez legalább 3 karakter hosszú, '@' jelet tartalmazó értéket írjon be!"/>
                                </jsp:forward>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${fn:length(param.password) < 6}">
                                        <jsp:forward page="register.jsp">
                                            <jsp:param name="errorMsg" value="Kérem, hogy az 'Jelszó'-hoz legalább 6 karakter hosszú értéket írjon be!"/>
                                        </jsp:forward>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${param.password ne param.confirmpassword}">
                                                <jsp:forward page="register.jsp">
                                                    <jsp:param name="errorMsg" value="Kérem ügyeljen rá, hogy az 'Jelszó' és a 'Jelszó megerősítése' mezőkbe azonos értéket írjon!"/>
                                                </jsp:forward>
                                            </c:when>
                                            <c:otherwise>
                                                <sql:update var="beszuras" dataSource="${intalk}">
                                                    INSERT INTO USERS (username, email, password)
                                                    VALUES ('${param.username}', '${param.email}', '${param.password}')
                                                </sql:update> 
                                                <jsp:forward page="login.jsp">
                                                    <jsp:param name="errorMsg" value="Sikeres regisztráció! Kérem jelentkezzen be!"/>
                                                </jsp:forward>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${!empty param.logout}">
        <% session.invalidate(); %>
        <jsp:forward page="login.jsp"/>
    </c:when>
    <c:when test="${!empty param.createvote}">
        <c:choose>
            <c:when test="${(empty param.title) || (empty param.question || ((empty param.answer1) && (empty param.answer2) && (empty param.answer3) && (empty param.answer4)))}">
                <jsp:forward page="user_myvote.jsp">
                    <jsp:param name="errorMsg" value="A cím, a leírás és legalább 1 válaszlehetőség megadása kötelező!"/>
                </jsp:forward>
            </c:when>
            <c:otherwise>
                <sql:update var="beszurastema" dataSource="${intalk}">
                    INSERT INTO INTALK.TOPICS (TITLE, QUESTION, ANSWER1, ANSWER2, ANSWER3, ANSWER4, USERID, ALLOWED, ADMIN)
                    VALUES('${param.title}', '${param.question}', '${param.answer1}', '${param.answer2}', '${param.answer3}', '${param.answer4}', <%= session.getAttribute("userid")%>, FALSE, null)
                </sql:update>
                <jsp:forward page="user_myvote.jsp">
                    <jsp:param name="errorMsg" value="A szavazás továbbítva lett jóváhagyásra."/>
                </jsp:forward>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${!empty param.sendvote}">
            <%
                String topicid = request.getParameter("topicid");
                answerselected = request.getParameter(topicid);
                if (answerselected!=null && !answerselected.isEmpty()) {%>
                   <sql:update var="beszurasszavazat" dataSource="${intalk}">
                        INSERT INTO INTALK.VOTES (TOPIC, USERID, SELECTEDANSWER)
                        VALUES(${param.topicid}, <%= session.getAttribute("userid")%>, <%=answerselected%>)
                    </sql:update>     
                <%}%>
                <jsp:forward page="user_othervote.jsp">
                    <jsp:param name="errorMsg" value="A szavazat sikeresen leadásra került."/>
                </jsp:forward>
    </c:when>
    <c:otherwise>
        <jsp:forward page="login.jsp">
            <jsp:param name="errorMsg" value="Kérem jelentkezzen be!"/>
        </jsp:forward>
    </c:otherwise>
</c:choose>
