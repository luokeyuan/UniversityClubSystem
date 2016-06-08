<%-- 
    Document   : showclub
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
        <link rel="stylesheet" type="text/css" href="css/base.css">
        <link rel="stylesheet" type="text/css" href="css/showclub.css">
    </head>
    <body>
        <div class="header">
            <div class="nav">
                <h1>高校社团管理系统</h1><span class="link"><a href="#" id="back">返回</a><a href="main.jsp">首页</a><a href="index.jsp">退出系统</a></span>
            </div>
        </div>
        <div class="wrap">
            <div class="club_info">
                <jsp:useBean id="club" scope="application" class="com.ucs.jsp.register"/>
                <%
                    String clubname=new String(request.getParameter("clubname").getBytes("iso-8859-1"),"utf-8"); 
                    String owner="",school="",introduce="";
                    club.getConn();
                    ResultSet rs=null,rs_1=null,rs_2=null;
                    try{
                        club.getConn();
                        String sql="select username from clubowner where clubname='"+clubname+"'";
                        rs=club.executeQuery(sql);
                        if(rs.next()){
                            owner=rs.getString("username");
                            String sql1="select school from register where username='"+owner+"'";
                            rs_1=club.executeQuery(sql1);
                            if(rs_1.next()){
                                school=rs_1.getString("school");
                            }
                        }
                        String sql2="select introduce from club where clubname='"+clubname+"'";
                        rs_2=club.executeQuery(sql2);
                        if(rs_2.next()){
                            introduce=rs_2.getString("introduce");
                        }
                        
                    }catch (Exception ex) {
                        Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                    }
                %>
                <span class="title"><%=clubname%></span>创建者：<span><%=owner%></span>所在学校：<span><%=school%></span>
                <p><%=introduce%></p>
            </div>
            <div class="club_dyn">
                <ul>
                    <%
                        ResultSet rs_3=null,rs_4=null;
                        String sql3="select * from clubnotice where clubname='"+clubname+"'";
                        rs_3=club.executeQuery(sql3);
                        rs_4=club.executeQuery(sql3);
                        if(!rs_3.next()){
                            out.print("<li><p>该社团到现在为止还没有发布任何公告或消息！</p></li>");
                        }else{
                            while(rs_4.next()){
                                out.print("<li><p>"+rs_4.getString("content")+"</p><span class=\"date\">"+rs_4.getString("datetime")+"</span></li>");
                            }
                        }
                        club.dbclose();
                    %>
                </ul>
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
