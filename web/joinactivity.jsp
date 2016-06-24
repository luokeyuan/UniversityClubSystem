<%-- 
    Document   : joinactivity
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
    </head>
    <body>
        <%
            String username=(String)session.getAttribute("username");
            int message_unread = 0;
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
                    <li><a href="myMessage.jsp">我的消息<span class="badge" id="badge"><%if(message_unread!=0){out.print(message_unread);}%></span></a></li>
                </ul>
            </div>
            <div class="content">
                <jsp:useBean id="club" scope="application" class="com.ucs.jsp.register"/>
                
                <%
                    ResultSet rs_1=null,rs_2=null,rs_3=null,rs_4=null,rs_4_1=null;
                    try{
                        club.getConn();
                        String sql="select * from clubactivity where clubname in (select clubname from clubmember where members='"+username+"') order by datetime desc";
                        
                        rs_2=club.executeQuery(sql);
                        rs_3=club.executeQuery(sql);
                        
                        String sql_1 = "select * from usermessage where username='"+username+"' and state=0";
                        rs_1 = club.executeQuery(sql_1);
                        while(rs_1.next()){
                            message_unread++;
                        }
                        
                        if(rs_2.next()){
                            while(rs_3.next()){
                                String sql1_1="select * from activityjoiner where a_id="+Integer.parseInt(rs_3.getString("a_id"));
                                rs_4_1=club.executeQuery(sql1_1);
                                int count=0;
                                while(rs_4_1.next()){
                                    count++;
                                }
                                String sql1="select * from activityjoiner where a_id="+Integer.parseInt(rs_3.getString("a_id"))+" and joinername='"+username+"'";
                                rs_4=club.executeQuery(sql1);
                                if(rs_4.next()){ //已参加活动
                %>
                        <div class="panel">
                            <div class="panel-heading" style="position: relative;">
                                <h3 class="panel-title" style="display: inline-block;margin-right: 10px;"><%=rs_3.getString("title")%></h3><span><%=rs_3.getString("clubname")%></span>
                                <span class="text-right" style="position:absolute;right:20px;top:12px;">已有 <%=count%> 人参加</span>
                            </div>
                            <div class="panel-body"><%=rs_3.getString("content") %></div>
                            <div class="panel-footer" style="position: relative;">
                                <span>发布日期：<%=rs_3.getString("datetime") %></span>
                                <button class="btn btn-xs btn-default" disabled="disabled" style="position:absolute;right:20px;top:12px;">已加入</button>
                                <a href='outactivity?a_id=<%=rs_3.getString("a_id")%>&entry='><button class="btn btn-xs btn-success" style="position:absolute;right:75px;top:12px;">退出</button></a>
                            </div>
                        </div>
                <%
                                }else{  //未参加活动
                %>
                        <div class="panel">
                            <div class="panel-heading" style="position: relative;">
                                <h3 class="panel-title" style="display: inline-block;margin-right: 10px;"><%=rs_3.getString("title")%></h3><span><%=rs_3.getString("clubname")%></span>
                                <span class="text-right" style="position:absolute;right:20px;top:12px;">已有 <%=count%> 人参加</span>
                            </div>
                            <div class="panel-body"><%=rs_3.getString("content") %></div>
                            <div class="panel-footer" style="position: relative;">
                                <span>发布日期：<%=rs_3.getString("datetime") %></span>
                                <a href='joinactivity?a_id=<%=rs_3.getString("a_id")%>&entry='><button class="btn btn-xs btn-success" style="position:absolute;right:20px;top:12px;">加 入</button></a>
                            </div>
                        </div>
                <%
                                }
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
