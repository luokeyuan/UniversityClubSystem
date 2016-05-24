<%-- 
    Document   : main
    Created on : 2016-5-8, 21:08:13
    Author     : MR.l
--%>

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
                    <li>
                        <a href="#">社团1</a><span class="date">发稿时间</span>
                        <p>内容</p>
                    </li>
                    <li>
                        <a href="#">社团1</a><span class="date">发稿时间</span>
                        <p>内容</p>
                    </li>
                    <li>
                        <a href="#">社团1</a><span class="date">发稿时间</span>
                        <p>内容</p>
                    </li>
                    <li>
                        <a href="#">社团1</a><span class="date">发稿时间</span>
                        <p>内容</p>
                    </li>
                </ul>
            </div>
        </div>
    </body>
</html>
