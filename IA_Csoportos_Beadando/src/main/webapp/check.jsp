<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
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
<c:choose>
    <c:when test="${!param.login}">
        <c:when test="${(empty param.username) || (empty param.password)}">
            <jsp:forward page="login.jsp">
                <jsp:param name="errorMsg" value="A felhasználó név/jelszó megadása kötelező!"/>
            </jsp:forward>
        </c:when>
        <c:otherwise>
            
        </c:otherwise>
    </c:when>
    <c:when test="${!param.adminlogin}">
        <c:when test="${(empty param.username) || (empty param.password)}">
            <jsp:forward page="adminlogin.jsp">
                <jsp:param name="errorMsg" value="A felhasználó név/jelszó megadása kötelező!"/>
            </jsp:forward>
        </c:when>
        <c:otherwise>
            
        </c:otherwise>
    </c:when>
    <c:when test="${!param.register}">
        <c:when test="${(empty param.username) || (empty param.password) || (empty param.email) || (empty param.confirmpassword)}">
            <jsp:forward page="register.jsp">
                <jsp:param name="errorMsg" value="Az adatok megadása kötelező!"/>
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
                                    
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </c:otherwise>
    </c:when>
    <c:otherwise>
        <jsp:forward page="login.jsp">
            <jsp:param name="errorMsg" value="Kérem jelentkezzen be!"/>
        </jsp:forward>
    </c:otherwise>
</c:choose>
