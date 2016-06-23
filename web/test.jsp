<%-- 
    Document   : test
    Created on : 2016-6-22, 15:39:38
    Author     : MR.l
--%>

<%@page contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            //String clubname=new String(request.getParameter("clubname").getBytes("iso8859-1"),"utf-8"); 
            String clubname=request.getParameter("clubname");
        %>
        <p><%=clubname%></p>
    </body>
</html>
