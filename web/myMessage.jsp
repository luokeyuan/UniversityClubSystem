<%-- 
    Document   : myMessage
    Created on : 2016-6-24, 5:15:38
    Author     : MR.l
--%>

<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.ucs.jsp.register"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>首页</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/base.css">
    </head>
    <body>
        <%
            String username=(String)session.getAttribute("username");
        %>
        <div class="header">
            <div class="header-content">
                <h1>高校社团管理系统</h1><span class="link"><span class="user-link">欢迎你:&nbsp;&nbsp;[<a href="info.jsp"><%=username%></a>]</span><a href="outSystem">退出系统</a></span>
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
                    <li><a href="#">我的消息</a></li>
                </ul>
            </div>
            <div class="content">
            <jsp:useBean id="message" scope="application" class="com.ucs.jsp.register"/>
            <%
            ResultSet rs = null,rs_1 = null;
            
            try{
                message.getConn();
                String sql = "select * from usermessage where username = '"+username+"' order by m_id desc";
                rs = message.executeQuery(sql);
                rs_1 = message.executeQuery(sql);
                if(rs.next()){  //有信息
                    while(rs_1.next()){
                        if(Integer.parseInt(rs_1.getString("state"))==1){  //已读信息
            %>
                <div class="panel panel-default">
                    <div class="panel-body">
                    <%=rs_1.getString("content")%>
                    </div>
                    <div class="panel-footer">
                        <button class="btn btn-xs disabled" style="margin-right: 10px;">已读</button><a href="deleteMessage?m_id=<%=rs_1.getString("m_id")%>"><button class="btn btn-xs btn-danger">删除</button></a>
                    </div>
                </div>
            <%
                        }else{  //未读信息
            %>
                <div class="panel panel-info">
                    <div class="panel-heading">
                        新消息
                    </div>
                    <div class="panel-body">
                        <%=rs_1.getString("content")%>
                    </div>
                    <div class="panel-footer">
                        <a href="readMessage?m_id=<%=rs_1.getString("m_id")%>"><button class="btn btn-xs btn-success">标为已读</button></a>
                    </div>
                </div>
            <%
                        }
                    }
                }else{  //没有信息
            %>
                <div class="panel panel-default">
                    <div class="panel-body">
                    你暂时没有收到任何消息！
                    </div>
                </div>
            <%
                }
            }catch(Exception ex){
                Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
            }

            message.dbclose();
            %>
            </div>
        </div>
    </body>
</html>
