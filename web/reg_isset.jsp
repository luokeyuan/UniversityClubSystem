<%-- 
    Document   : reg_isset
    Created on : 2016-5-9, 13:13:00
    Author     : MR.l
--%>

<%@page import="com.ucs.jsp.register"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="register" scope="application" class="com.ucs.jsp.register"/>
<%
    String reg_name=request.getParameter("reg_name");
    String reg_pwd=request.getParameter("reg_pwd");
    
    int status=-1;
    ResultSet rs=null;
    try {
        register.getConn();
        String sql="select * from register where username = '" + reg_name + "'";
        rs=register.executeQuery(sql);


        if(rs.next()){
            status=1;//用户已存在
            out.print(status);
        }

        if(status==-1){//用户不存在
            String insertsql="insert into register (username,password) values('"+reg_name+"','"+reg_pwd+"')";
            register.insertConn(insertsql);
            status=0;
            out.print(status);
        }
        register.dbclose();
    } catch (Exception ex) {
        Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
    }
%>
