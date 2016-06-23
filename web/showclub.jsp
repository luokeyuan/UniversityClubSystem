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
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/base.css">
        <link rel="stylesheet" type="text/css" href="css/showclub.css">
    </head>
    <body>
        <div class="header">
            <div class="header-content">
                <h1>高校社团管理系统</h1><span class="link"><a href="myclub.jsp">返回</a><a href="main.jsp">首页</a><a href="outSystem">退出系统</a></span>
            </div>
        </div>
        <div class="wrap">
            <div class="club_info">
                <jsp:useBean id="club" scope="application" class="com.ucs.jsp.register"/>
                <%
                    String clubname=request.getParameter("clubname"); 
                    String username=(String)session.getAttribute("username");
                    String owner="",school="",introduce="";
                    int members = 1;
                    
                    club.getConn();
                    ResultSet rs=null,rs_1=null,rs_2=null,rs_1_1=null;
                    try{
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
                        //统计社团成员数量
                        String sql_club="select username from clubowner where clubname='"+clubname+"'";
                        rs_1_1=club.executeQuery(sql_club);
                        while(rs_1_1.next()){
                            ++members;
                        }
                        
                    }catch (Exception ex) {
                        Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                    }
                %>
                <span class="title"><%=clubname%></span>创建者：<span><%=owner%></span>所在学校：<span><%=school%></span><span>社员：<%=members%>人</span>
                <p><%=introduce%></p>
            </div>
            <div class="container">
                <div class="col-md-2">
                    <div class="panel panel-success">  <!-- 成员列表 -->
                        <div class="panel-heading">
                            社团所有成员
                        </div>
                        <ul class="list-group">
                        <%
                        try{
                            String sql="select * from clubmember where clubname='"+clubname+"'";
                            ResultSet m_rs=null,m_rs1=null;
                            m_rs=club.executeQuery(sql);
                            m_rs1=club.executeQuery(sql);
                            if(!m_rs.next()){
                                out.print("<li class='list-group-item'>还没有成员！</li>");
                            }else{
                                while(m_rs1.next()){
                        %>
                        <li class='list-group-item' style="position: relative;"><%=m_rs1.getString("members")%>
                            <a href='personinfo.jsp?username=<%=m_rs1.getString("members")%>'>
                                <button type='button' class='btn btn-success btn-xs' style="position: absolute;right: 20px;">信息</button>
                            </a>
                        </li>
                        <%
                                }
                            }
                        }catch (Exception ex) {
                            Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        %>
                        </ul>
                    </div>
                </div>
                <div class="col-md-5">  <!-- 公告列表 -->
                    <%
                        ResultSet rs_3=null,rs_4=null;
                        String sql3="select * from clubnotice where clubname='"+clubname+"' order by datetime desc";
                        rs_3=club.executeQuery(sql3);
                        rs_4=club.executeQuery(sql3);
                        if(!rs_3.next()){
                            out.print("<li><p>该社团到现在为止还没有发布任何公告或消息！</p></li>");
                        }else{
                            while(rs_4.next()){
                    %>
                                <div class="panel panel-success">
                                    <div class="panel-body"><%=rs_4.getString("content") %></div>
                                    <div class="panel-footer">
                                        <span>发布日期：<%=rs_4.getString("datetime") %></span>
                                    </div>
                                </div>
                    <%
                            }
                        }
                    %>
                </div>
                <div class="col-md-5">  <!-- 活动列表 -->
                    <%
                    ResultSet rs_2_1=null,rs_3_1=null,rs_4_1=null,rs_4_2;
                    try{
                        club.getConn();
                        String sql="select * from clubactivity where clubname='"+clubname+"' order by datetime desc";
                        
                        rs_2_1=club.executeQuery(sql);
                        rs_3_1=club.executeQuery(sql);
                        
                        
                        if(rs_2_1.next()){
                            while(rs_3_1.next()){
                                //统计活动参与人数
                                String sql1_1="select * from activityjoiner where a_id="+Integer.parseInt(rs_3_1.getString("a_id"));
                                rs_4_1=club.executeQuery(sql1_1);
                                int count=0;
                                while(rs_4_1.next()){
                                    count++;
                                }
                                String sql1="select * from activityjoiner where a_id="+Integer.parseInt(rs_3_1.getString("a_id"))+" and joinername='"+username+"'";
                                rs_4_1=club.executeQuery(sql1);
                                if(rs_4_1.next()){ //已参加活动
                %>
                        <div class="panel">
                            <div class="panel-heading" style="position: relative;">
                                <h3 class="panel-title" style="display: inline-block;margin-right: 10px;"><%=rs_3_1.getString("title")%></h3><span><%=rs_3_1.getString("clubname")%></span>
                                <span class="text-right" style="position:absolute;right:20px;top:12px;">已有 <%=count%> 人参加</span>
                            </div>
                            <div class="panel-body"><%=rs_3_1.getString("content") %></div>
                            <div class="panel-footer" style="position: relative;">
                                <span>发布日期：<%=rs_3_1.getString("datetime") %></span>
                                <button class="btn btn-xs btn-default" disabled="disabled" style="position:absolute;right:20px;top:12px;">已加入</button>
                                <a href='outactivity?a_id=<%=rs_3_1.getString("a_id")%>&entry=showclub&clubname=<%=clubname%>'>
                                    <button class="btn btn-xs btn-success" style="position:absolute;right:75px;top:12px;">退出</button>
                                </a>
                            </div>
                        </div>
                <%
                                }else{  //未参加活动
                %>
                        <div class="panel panel-info">
                            <div class="panel-heading" style="position: relative;">
                                <h3 class="panel-title" style="display: inline-block;margin-right: 10px;"><%=rs_3_1.getString("title")%></h3><span><%=rs_3_1.getString("clubname")%></span>
                                <span class="text-right" style="position:absolute;right:20px;top:12px;">已有 <%=count%> 人参加</span>
                            </div>
                            <div class="panel-body"><%=rs_3_1.getString("content") %></div>
                            <div class="panel-footer" style="position: relative;">
                                <span>发布日期：<%=rs_3_1.getString("datetime") %></span>
                                <a href='joinactivity?a_id=<%=rs_3_1.getString("a_id")%>&entry=showclub&clubname=<%=clubname%>'>
                                    <button class="btn btn-xs btn-success" style="position:absolute;right:20px;top:12px;">加 入</button>
                                </a>
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
        </div>
    </body>
</html>
