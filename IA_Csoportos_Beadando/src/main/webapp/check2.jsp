<%-- 
    Document   : check2
    Created on : 2020. dec. 6., 11:36:22
    Author     : leron
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Funkció ellenőrző, átírányító oldal</title>
    </head>
    <body>
        <c:choose>
            <%--Jóváhagyás gombra kattintva átírja az adatbázisban az allowed mezőt true-ra --%>
            <c:when test="${not empty param.jovahagy}">
                <sql:update var="jovahagyott" dataSource="${intalk}">
                    UPDATE INTALK.TOPICS SET t.ALLOWED= true t.ADMIN = <%=session.getAttribute("adminid") %> WHERE t.ID=${param.jovahagyid}
                </sql:update>
                <jsp:forward page="admin_main.jsp"/>
            </c:when>
            <%-- Az elutasítás gombra kattintva átírja az adatbázisban az allowed mezőt false-ra--%>
            <c:when test="${not empty param.elutasit}"> 
                <sql:update var="elutasitott" dataSource="${intalk}">
                UPDATE INTALK.TOPICS SET t.ALLOWED = false t.ADMIN = <%=session.getAttribute("adminid")%> WHERE t.ID =${param.elutasitid}
                </sql:update>
                <jsp:forward page="admin_main.jsp"></jsp:forward>
            </c:when>
        </c:choose>
        <%-- A szavazás létrehozása --%>
        <c:choose>
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
                    <%--Szavazat leadása --%>
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
                    <c:when test="${not empty param.deletevote}">
                        <sql:update var="torles" dataSource="${intalk}">
                            DELETE INTALK.TOPICS WHERE T.ID = ${param.topicid}
                        </sql:update>
                        <jsp:forward page="user_myvote" />
                    </c:when>
        </c:choose>
    </body>
</html>
