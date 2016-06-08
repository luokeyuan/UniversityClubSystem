<%-- 
    Document   : isset
    Created on : 2016-5-8, 16:55:50
    Author     : MR.l
--%>

<%@page import="com.ucs.jsp.register"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<jsp:useBean id="login" scope="application" class="com.ucs.jsp.register"/>
<% 
    String log_name=new String(request.getParameter("log_name").getBytes("iso-8859-1"),"utf-8");
    String log_pwd=request.getParameter("log_pwd");
    String log_type=request.getParameter("log_type");
    
    int status=-1;
    if(log_name==""&&log_pwd!=""){
        status=3;
        out.print(status);
    }else if(log_pwd==""&&log_name!=""){
        status=4;
        out.print(status);
    }else if(log_name==""&&log_pwd==""){
        status=5;
        out.print(status);
    }else{
        if (log_type.equals("user")) {
            
            ResultSet rs=null;
            try {
                login.getConn();
                String sql="select * from register";
                rs=login.executeQuery(sql);
                while(rs.next()){
                    if(rs.getString(1).equals(log_name)&&rs.getString(2).equals(log_pwd)){
                        session.setAttribute("username", log_name);
                        status=1;
                        out.print(status);
                        break;
                    }else{
                        status=0;
                        out.print(status);
                    }
                }
            } catch (Exception ex) {
                Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        if (log_type.equals("admin")) {
            ResultSet rs=null;
            try {
                login.getConn();
                String sql="select * from adminster";
                rs=login.executeQuery(sql);
                while(rs.next()){
                    if(rs.getString(1).equals(log_name)&&rs.getString(2).equals(log_pwd)){
                        session.setAttribute("adminname",log_name);
                        status=2;
                        out.print(status);
                    }else{
                        status=0;
                        out.print(status);
                    }
                }
                login.dbclose();
            } catch (Exception ex) {
                Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
%>