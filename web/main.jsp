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
        <link rel="stylesheet" type="text/css" href="css/base.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
    </head>
    <body>
        <div class="header">
            <div class="nav">
                <h1>高校社团管理系统</h1><span class="link"><a href="main.jsp">首页</a><a href="index.jsp">退出系统</a></span>
            </div>
        </div>
        <div class="wrap">
            <div class="info">
                <img class="head" src="images/img.png" /><span class="username"><%=session.getAttribute("username")%></span><br/>
                <ul class="alist">
                    <li><a href="info.jsp">个人信息</a></li>
                    <li><a href="myclub.jsp">我的社团</a></li>
                    <li><a href="createclub.jsp">创建社团</a></li>
                    <li><a href="joinclub.jsp">加入社团</a></li>
                </ul>
            </div>
            <div class="content">
                <h2>社团动态</h2>
                <ul>
                    <jsp:useBean id="club" scope="application" class="com.ucs.jsp.register"/>
                    <%
                        String username=(String)session.getAttribute("username");
                        club.getConn();
                        ResultSet rs=null,rs_1=null,rs_2=null,rs_3=null;
                        try{
                            club.getConn();
                            String sql="select * from clubnotice where clubname in (select clubname from clubowner where username='"+username
                                    +"') or clubname in (select clubname from clubmember where members='"+username+"')";
                            //String sql="select * from clubnotice where clubname in (select clubname from clubowner where username='"+username+"')";
                            //String sql1="select * from clubnotice where clubname in (select clubname from clubmember where members='"+username+"')";
                            rs=club.executeQuery(sql);
                            rs_1=club.executeQuery(sql);
                            if(!rs.next()){
                                out.print("<li>暂时没有任何社团动态！</li>");
                            }else{
                                while(rs_1.next()){
                                   out.print("<li><a href=\"#\">"+rs_1.getString("clubname")+"</a><span class=\"date\">发稿时间</span><p>"+rs_1.getString("content")+"</p></li>"); 
                                }
                            }

                        }catch (Exception ex) {
                            Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        club.dbclose();
                    %>
                </ul>
            </div>
        </div>
    </body>
</html>
