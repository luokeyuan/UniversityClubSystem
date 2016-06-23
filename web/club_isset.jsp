<%-- 
    Document   : club_isset
    Created on : 2016-6-8, 15:29:28
    Author     : MR.l
--%>

<%@page import="com.ucs.servlet.createclub"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.ucs.jsp.register"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="register" scope="application" class="com.ucs.jsp.register"/>
<%
ResultSet rs=null;
String clubname=new String(request.getParameter("clubname").getBytes("iso8859-1"),"utf-8");

try {
    register.getConn();
    String sql = "select * from clubowner where clubname = '" + clubname + "'";
    rs = register.executeQuery(sql);
    if(rs.next()){
        out.print(1);
    }
} catch (Exception ex) {
    Logger.getLogger(createclub.class.getName()).log(Level.SEVERE, null, ex);
}
    register.dbclose();
%>
