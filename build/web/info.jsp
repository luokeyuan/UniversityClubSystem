<%-- 
    Document   : info
    Created on : 2016-5-11, 16:22:21
    Author     : MR.l
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.ucs.jsp.register"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>高校社团管理系统</title>
        <link rel="stylesheet" type="text/css" href="css/base.css">
        <link rel="stylesheet" type="text/css" href="css/info.css">
        <style>
            .showinfo{
                padding-top: 20px;
            }
            .showinfo p{
                display: inline-block;
                width: 400px;
            }
            .showinfo .btn{
                width:120px;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="nav">
                <h1>高校社团管理系统</h1><span class="link"><a href="main.jsp">首页</a><a href="index.jsp">退出系统</a></span>
            </div>
        </div>
        <div class="wrap">
            <div class="info">
                <img class="head" alt="头像" src="images/img.png" /><span class="username"><%String username=(String)session.getAttribute("username");%><%=username%></span><br/>
                <ul class="alist">
                    <li><a href="info.jsp">个人信息</a></li>
                    <li><a href="myclub.jsp">我的社团</a></li>
                    <li><a href="createclub.jsp">创建社团</a></li>
                    <li><a href="joinclub.jsp">加入社团</a></li>
                </ul>
            </div>
            <div class="content">
                <div class="showinfo">
                    <jsp:useBean id="userinfo" scope="application" class="com.ucs.jsp.register"/>
                    <%
                        String name="",sex="",school="",phone="",email="",intro="";
                        ResultSet rs=null;
                        try{
                            userinfo.getConn();
                            String sql="select * from register where username='"+username+"'";
                            rs=userinfo.executeQuery(sql);
                            if(rs.next()){
                                name=rs.getString(1);
                                sex=rs.getString(3);
                                school=rs.getString(4);
                                phone=rs.getString(5);
                                email=rs.getString(6);
                                intro=rs.getString(7);
                            }
                        }catch (Exception ex) {
                            Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    %>
                    <span class="item">用户名：</span><span><%=name%></span><br/>
                    <span class="item">性别：</span><span><%=sex%></span><br/>
                    <span class="item">所在学校：</span><span><%=school%></span><br/>
                    <span class="item">联系电话：</span><span><%=phone%></span><br/>
                    <span class="item">E-mail：</span><span><%=email%></span><br/>
                    <span class="item">个人描述：</span><p><%=intro%></p><br/>
                    <a href="fixinfo.jsp"><button type="button" class="btn">修改个人信息</button></a>
                </div>
            </div>
        </div>
    </body>
</html>
