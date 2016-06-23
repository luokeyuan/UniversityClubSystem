<%-- 
    Document   : main
    Created on : 2016-5-8, 21:08:13
    Author     : MR.l
--%>

<%@page import="com.ucs.jsp.register"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>首页</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/base.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
    </head>
    <body>
        <%
            String username=(String)session.getAttribute("username");
        %>
        <div class="header">
            <div class="header-content">
                <h1>高校社团管理系统</h1><span class="link"><span class="user-link">欢迎你:&nbsp;&nbsp;<a href="info.jsp"><%=username%></a></span><a href="index.jsp">退出系统</a></span>
            </div>
        </div>
        <div class="wrap">
            <div class="info">
                <ul class="nav nav-pills nav-stacked">
                    <li class="active"><a href="main.jsp">首页</a></li>
                    <li><a href="info.jsp">个人信息</a></li>
                    <li><a href="myclub.jsp">我的社团</a></li>
                    <li><a href="createclub.jsp">创建社团</a></li>
                    <li><a href="joinclub.jsp">加入社团</a></li>
                    <li><a href="joinactivity.jsp">参加活动</a></li>
                </ul>
            </div>
            <div class="content">
                <h2>社团动态</h2>
                <jsp:useBean id="club" scope="application" class="com.ucs.jsp.register"/>
                <%
                    club.getConn();
                    ResultSet rs=null,rs_1=null;
                    try{
                        club.getConn();
                        String sql="select * from clubnotice where clubname in (select clubname from clubowner where username='"+username
                                +"') or clubname in (select clubname from clubmember where members='"+username+"')";
                        rs=club.executeQuery(sql);
                        rs_1=club.executeQuery(sql);
                        if(!rs.next()){
                            out.print("<ul class='list-group'><li class='list-group-item'>暂时没有任何社团动态！</li></ul>");
                        }else{
                            while(rs_1.next()){
                %>
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <h3 class="panel-title">公告&nbsp;&nbsp;<%=rs_1.getString("clubname")%></h3>
                            </div>
                            <div class="panel-body"><%=rs_1.getString("content") %></div>
                            <div class="panel-footer">
                                <span>发布日期：<%=rs_1.getString("datetime") %></span>
                            </div>
                        </div>
                <%
                            }
                        }

                    }catch (Exception ex) {
                        Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    club.dbclose();
                %>
            </div>
        </div>
    </body>
</html>
