<%-- 
    Document   : reg_isset
    Created on : 2016-5-9, 13:13:00
    Author     : MR.l
--%>

<%@page import="com.jsp.register"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="register" scope="application" class="com.jsp.register"/>
<%
    String reg_name=request.getParameter("reg_name");
    String reg_pwd=request.getParameter("reg_pwd");
    
    int status=-1;
    if(reg_name==""&&reg_pwd!=""){
        status=2;
        out.print(status);
    }else if(reg_pwd==""&&reg_name!=""){
        status=3;
        out.print(status);
    }else if(reg_name==""&&reg_pwd==""){
        status=4;
        out.print(status);
    }else{
        ResultSet rs=null;
        try {
            register.getConn();
            String sql="select * from register";
            rs=register.executeQuery(sql);
            while(rs.next()){
                if(rs.getString(1).equals(reg_name)){
                    status=1;
                    out.print(status);
                    break;
                }
            }
            if(status==-1){
                String insertsql="insert into register values('"+reg_name+"','"+reg_pwd+"')";
                register.insertConn(insertsql);
                status=0;
                out.print(status);
            }
            register.dbclose();
        } catch (Exception ex) {
            Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
%>
