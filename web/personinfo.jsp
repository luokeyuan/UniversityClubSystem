<%-- 
    Document   : personinfo
    Created on : 2016-6-16, 12:49:14
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
        <style>
            .item {
                display: inline-block;
                width: 100px;
                height: 40px;
                text-align: right;
                border: none;
                margin-right: 30px;
                margin-bottom: 10px;
            }
            .showinfo p {
                display: inline-block;
                width: 400px;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="header-content">
                <h1>高校社团管理系统</h1><span class="link"><a href="#" id="back">返回</a><a href="main.jsp">首页</a><a href="outSystem">退出系统</a></span>
            </div>
        </div>
        <div class="wrap">
            <jsp:useBean id="userinfo" scope="application" class="com.ucs.jsp.register"/>
        <%
            String username=request.getParameter("username"); 
            String name="",sex="",school="",phone="",email="",intro="";
            ResultSet rs=null;
            try{
                userinfo.getConn();
                String sql="select * from register where username='"+username+"'";
                rs=userinfo.executeQuery(sql);
                if(rs.next()){
                    name=rs.getString("username");
                    sex=rs.getString("sex");
                    school=rs.getString("school");
                    phone=rs.getString("phone");
                    email=rs.getString("email");
                    intro=rs.getString("introduce");
                }
            }catch (Exception ex) {
                Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
            }
        %>
            <div class="panel panel-success">
                <div class="panel-heading">
                    <h4 style="display:inline-block;margin-right:10px;"><%=username%></h4><span>的个人信息</span>
                </div>
                <div class="panel-body">
                    <div class="showinfo">
                        <span class="item">用户名：</span><span><%=name%></span><br/>
                        <span class="item">性别：</span><span><%=sex%></span><br/>
                        <span class="item">所在学校：</span><span><%=school%></span><br/>
                        <span class="item">联系电话：</span><span><%=phone%></span><br/>
                        <span class="item">E-mail：</span><span><%=email%></span><br/>
                        <span class="item">个人描述：</span><p><%=intro%></p><br/>
                    </div>
                </div>
            </div>
        </div>
        <script>
            var back=document.getElementById('back');
            back.onclick=function(){
                window.history.back();
            }
        </script>
    </body>
</html>
