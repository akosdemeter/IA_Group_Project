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
            <c:when test="${not empty param.jovahagy}">
                <sql:update var="jovahagyott" dataSource="${intalk}">
                    UPDATE INTALK.TOPICS SET t.ALLOWED= 'true' t.ADMIN = '<%=session.getAttribute("adminid") %>' WHERE t.ID='${param.jovahagyid}'
                </sql:update>
            </c:when>
            <c:when test="${not empty param.elutasit}"> 
                UPDATE INTALK.TOPICS SET t.ALLOWED = 'false' t.ADMIN = '<%=session.getAttribute("adminid")%>' WHERE t.ID ='${param.elutasitid}'
            </c:when>
        </c:choose>
    </body>
</html>
