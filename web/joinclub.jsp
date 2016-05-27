<%-- 
    Document   : managerclub
    Created on : 2016-5-11, 16:25:26
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
        <link rel="stylesheet" type="text/css" href="css/base.css">
        <link rel="stylesheet" type="text/css" href="css/myclub.css">
    </head>
    <body>
        <div class="header">
            <div class="nav">
                <h1>高校社团管理系统</h1><span class="link"><a href="main.jsp">首页</a><a href="index.jsp">退出系统</a></span>
            </div>
        </div>
        <div class="wrap">
            <div class="info">
                <img class="head" alt="头像" src="images/img.png" /><span class="username"><%String username=(String)session.getAttribute("username");out.print(username);%></span><br/>
                <ul class="alist">
                    <li><a href="info.jsp">个人信息</a></li>
                    <li><a href="myclub.jsp">我的社团</a></li>
                    <li><a href="createclub.jsp">创建社团</a></li>
                    <li><a href="joinclub.jsp">加入社团</a></li>
                </ul>
            </div>
            <div class="content">
                <div class="club_list join_club_list">
                    <h2>可加入的社团</h2>
                    <ul>
                        <jsp:useBean id="club" scope="application" class="com.ucs.jsp.register"/>
                        <%
                            ResultSet rs=null,rs_1=null,rs_2=null;
                            try{
                                club.getConn();
                                String sql1="select clubname from clubmember where members='"+username+"'";
                                rs=club.executeQuery(sql1);
                                
                                if(!rs.next()){
                                    String sql="select clubname from clubowner where username!='"+username+"';";
                                    rs_1=club.executeQuery(sql);
                                    rs_2=club.executeQuery(sql);
                                }else{
                                    String sql="select clubname from clubowner where clubname!=(select clubname from clubmember where members='"+username+"') and username!='"+username+"';";
                                    rs_1=club.executeQuery(sql);
                                    rs_2=club.executeQuery(sql);
                                }
                                
                                if(!rs_1.next()){
                                    out.print("<li>还没有人拥有社团，赶紧自己<a href=\"createclub.jsp\">创建</a>一个吧！</li>");
                                }else{
                                    while(rs_2.next()){
                                        out.print("<li><span>"+rs_2.getString("clubname")+"</span><button>加入</button><a href=\"showclub.jsp?clubname="+rs_2.getString("clubname")+"\"><button>查看</button></a></li>");
                                    }
                                }
                                club.dbclose();
                            }catch (Exception ex) {
                                Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        %>
                    </ul>
                </div>
            </div>
        </div>
    </body>
</html>
