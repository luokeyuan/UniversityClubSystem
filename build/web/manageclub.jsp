<%-- 
    Document   : manageclub
    Created on : 2016-5-12, 16:20:28
    Author     : MR.l
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="com.ucs.jsp.register"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>高校社团管理系统</title>
        <link rel="stylesheet" type="text/css" href="css/base.css">
        <link rel="stylesheet" type="text/css" href="css/manageclub.css">
    </head>
    <body>
        <div class="header">
            <div class="nav">
                <h1>高校社团管理系统</h1><span class="link"><a href="myclub.jsp">返回</a><a href="main.jsp">首页</a><a href="index.jsp">退出系统</a></span>
            </div>
        </div>
        <div class="wrap">
            <div class="clubinfo"><!--显示社团信息-->
                名称：<span><%String clubname=new String(request.getParameter("clubname").getBytes("iso-8859-1"),"utf-8"); %><%=clubname%></span><br/>
                简介：
                <jsp:useBean id="club" scope="application" class="com.ucs.jsp.register"/>
                <%
                    ResultSet rs=null;
                    try{
                        club.getConn();
                        String sql="select * from club where clubname='"+clubname+"'";
                        rs=club.executeQuery(sql);
                        if(rs.next()){
                            out.print("<p>"+rs.getString("introduce")+"</p>");
                        }
                        
                    }catch (Exception ex) {
                        Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    Date date=new Date();
                    DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String time=format.format(date);
                %>
            </div>
            <div class="notice">
                <div class="edit">
                    <form action="announcenotice" method="post">
                        发布公告<textarea name="content"></textarea>
                        <input type="hidden" value="<%=clubname%>" name="clubname">
                        <input type="hidden" value="<%=time%>" name="date">
                        <button type="submit">完&nbsp;成</button>
                    </form>
                </div>
                <div class="shownotice"><!--显示发布的公告-->
                    <ul>
                        
                            <%
                            try{
                                ResultSet n_rs1=null,n_rs=null;
                                String sql="select * from clubnotice where clubname='"+clubname+"'";
                                n_rs=club.executeQuery(sql);
                                n_rs1=club.executeQuery(sql);
                                if(!n_rs.next()){
                                    out.print("<li><p>你还没有发布任何公告！</p></li>");
                                }else{
                                    while(n_rs1.next()){//
                                        out.print("<li><p>"+n_rs1.getString("content")+"</p><span class=\"date\">"+n_rs1.getString("datetime")+"</span><a href=\"deletenotice?n_id="+
                                                n_rs1.getString("n_id")+"&clubname="+clubname+"\">删除</a></li>");
                                    }
                                }
                            }catch (Exception ex) {
                                Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                            }
                            %>
                    </ul>
                </div>
            </div>
            <div class="members"><!--显示社团成员-->
                <h5>社团成员</h5>
                <ul>
                    <%
                    try{
                        String sql="select * from clubmember where clubname='"+clubname+"'";
                        ResultSet m_rs=null,m_rs1=null;
                        m_rs=club.executeQuery(sql);
                        m_rs1=club.executeQuery(sql);
                        if(!m_rs.next()){
                            out.print("<li>还没有成员！</li>");
                        }else{
                            while(m_rs1.next()){
                                out.print("<li>"+m_rs.getString("members")+"<a href=\"deletemember?members="+m_rs.getString("members")+"&clubname="+clubname
                                        +"\"><button type=\"button\">删除</button></a></li>");
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
    </body>
</html>
