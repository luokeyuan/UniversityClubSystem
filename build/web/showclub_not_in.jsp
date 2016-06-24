<%-- 
    Document   : showclub_not_in
    Created on : 2016-5-12, 16:19:45
    Author     : MR.l
--%>

<%@page import="com.ucs.jsp.register"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>高校社团管理系统</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/base.css">
        <link rel="stylesheet" type="text/css" href="css/showclub.css">
    </head>
    <body>
        <div class="header">
            <div class="header-content">
                <h1>高校社团管理系统</h1><span class="link"><a href="joinclub.jsp">返回</a><a href="main.jsp">首页</a><a href="outSystem">退出系统</a></span>
            </div>
        </div>
        <div class="wrap">
            <div class="club_info">
                <jsp:useBean id="club" scope="application" class="com.ucs.jsp.register"/>
                <%
                    String clubname=request.getParameter("clubname");
                    String owner="",school="",introduce="";
                    int members = 1;
                    club.getConn();
                    ResultSet rs=null,rs_1=null,rs_1_1=null;
                    try{
                        club.getConn();
                        String sql="select * from clubowner where clubname='"+clubname+"'";
                        rs=club.executeQuery(sql);
                        if(rs.next()){
                            owner=rs.getString("username");
                            introduce=rs.getString("introduce");
                            String sql1="select school from register where username='"+owner+"'";
                            rs_1=club.executeQuery(sql1);
                            if(rs_1.next()){
                                school=rs_1.getString("school");
                            }
                        }
                        //统计社团成员数量
                        String sql_club="select username from clubowner where clubname='"+clubname+"'";
                        rs=club.executeQuery(sql_club);
                        while(rs_1_1.next()){
                            members++;
                        }
                        
                    }catch (Exception ex) {
                        Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                    }
                %>
                <span class="title"><%=clubname%></span>创建者：<span><%=owner%></span>所在学校：<span><%=school%></span><span>社员：<%=members%>人</span>
                <p><%=introduce%></p>
            </div>
        </div>
    </body>
</html>
