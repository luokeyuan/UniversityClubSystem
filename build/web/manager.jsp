<%-- 
    Document   : manager
    Created on : 2016-5-9, 13:08:22
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
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>高校社团管理系统</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
            <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <style type="text/css">
            body{
                padding-top: 60px;
            }
            .heading{
                width:100%;
                background:#222222;
            }
        </style>
    </head>
    <body>
    <nav class="heading">
        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#collapse">
                        <span class="sr-only">Toggle Navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a href="#" class="navbar-brand">高校社团管理系统</a>
                </div>
                <div class="collapse navbar-collapse" id="collapse">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="manager.jsp">用户管理</a></li>
                        <li><a href="club.jsp">社团管理</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="index.jsp">退出系统</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
    <div class="container">
        <div class="panel panel-success">
            <div class="panel-heading">用户信息</div>
            <div class="table-responsive">
                <table class="table table-hover table-bordered">
                    <tr>
                        <th>用户名</th>
                        <th>密码</th>
                        <th>性别</th>
                        <th>电话</th>
                        <th>邮箱</th>
                        <th>自我介绍</th>
                        <th>操作</th>
                    </tr>
                    <jsp:useBean id="user" scope="application" class="com.ucs.jsp.register"/>
                    <%
                        user.getConn();
                        ResultSet rs=null;
                        try{
                            String sql="select * from register";
                            rs=user.executeQuery(sql);
                            while(rs.next()){
                    %>
                                <tr>
                                    <td><%=rs.getString("username") %></td>
                                    <td><%=rs.getString("password") %></td>
                                    <td><%=rs.getString("sex") %></td>
                                    <td><%=rs.getString("phone") %></td>
                                    <td><%=rs.getString("email") %></td>
                                    <td><%=rs.getString("introduce") %></td>
                                    <td><a href='deleteUser?username=<%=rs.getString("username")%>'><button class="btn btn-success btn-xs">删除</button></a></td>
                                </tr>
                    <%
                            }

                        }catch (Exception ex) {
                            Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    %>
                </table>
            </div>
        </div>
    </div>
        <script src="js/jquery-2.2.4.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
