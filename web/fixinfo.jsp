<%-- 
    Document   : fixinfo
    Created on : 2016-5-12, 10:31:59
    Author     : MR.l
--%>

<%@page import="com.ucs.jsp.register"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>高校社团管理系统</title>
        <link rel="stylesheet" type="text/css" href="css/base.css">
        <link rel="stylesheet" type="text/css" href="css/info.css">
    </head>
    <body>
        <div class="header">
            <div class="nav">
                <h1>高校社团管理系统</h1><span class="link"><a href="main.jsp">首页</a><a href="index.jsp">退出系统</a></span>
            </div>
        </div>
        <div class="wrap">
            <jsp:useBean id="userinfo" scope="application" class="com.ucs.jsp.register"/>
            <%
                String username=(String)session.getAttribute("username");
                String image="";
                ResultSet rs=null;
                try{
                    userinfo.getConn();
                    String sql="select * from register where username='"+username+"'";
                    rs=userinfo.executeQuery(sql);
                    if(rs.next()){
                        image="Favicon\\"+rs.getString("image");
                    }
                }catch (Exception ex) {
                    Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                }
            %>
            <div class="info">
                <img class="head" alt="头像" src="<%=image%>" /><span class="username"><%=username%></span><br/>
                <ul class="alist">
                    <li><a href="info.jsp">个人信息</a></li>
                    <li><a href="myclub.jsp">我的社团</a></li>
                    <li><a href="createclub.jsp">创建社团</a></li>
                    <li><a href="joinclub.jsp">加入社团</a></li>
                </ul>
            </div>
            <div class="content">
                <form action="/UniversityClubSystem/changeinfoservlet" method="post">
                    <div class="changehead"><span class="item">头像：</span><img src="images/img.png" alt="头像" /><span class="inputfile">上传图片<input type="file"/></span></div>
                    <span class="item">性别：</span>
                    <select name="sex">
                        <option value="保密">保密</option>
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select><br/>
                    <span class="item">所在学校：</span><input class="fix_info" type="text" name="school" /><br/>
                    <span class="item">联系电话：</span><input class="fix_info" type="text" name="phone" /><br/>
                    <span class="item">E-mail：</span><input class="fix_info" type="text" name="email" /><br/>
                    <span class="item">个人描述：</span><textarea name="intro"></textarea><br/>
                    <button type="submit" class="btn">保存</button>
                    <a href="info.jsp"><button type="button" class="btn">取消</button></a>
                </form>
            </div>
        </div>
    </body>
</html>
