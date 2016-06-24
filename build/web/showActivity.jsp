<%-- 
    Document   : showActivity
    Created on : 2016-6-14, 23:14:13
    Author     : MR.l
--%>

<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.ucs.jsp.register"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>活动详情</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/base.css">
        <link rel="stylesheet" type="text/css" href="css/showActivity.css">
    </head>
    <body>
            <jsp:useBean id="activity" scope="application" class="com.ucs.jsp.register"/>
            <%
                String user = (String)session.getAttribute("username");
                String username=request.getParameter("username");
                String clubname="";
                int a_id=Integer.parseInt(request.getParameter("a_id"));
                String title="",content="";
                activity.getConn();
                ResultSet rs=null,rs_1=null,rs_2=null;
                try{
                    activity.getConn();
                    String sql="select * from clubactivity where a_id="+a_id;
                    rs=activity.executeQuery(sql);
                    if(rs.next()){
                        title=rs.getString("title");
                        content=rs.getString("content");
                        clubname=rs.getString("clubname");
                    }
                    activity.dbclose();
                }catch (Exception ex) {
                    Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                }
            %>
        <div class="header">
            <div class="header-content">
                <h1>高校社团管理系统</h1><span class="link"><span class="user-link">欢迎你:&nbsp;&nbsp;[<a href="info.jsp"><%=user%></a>]</span><a href="manageclub.jsp?clubname=<%=clubname%>">返回</a><a href="main.jsp">首页</a><a href="outSystem">退出系统</a></span>
            </div>
        </div>
        <div class="wrap">
            <div class="activity">
                <form action="updateactivity" method="post" class="form form-horizontal">
                    <div class="form-group">
                        <div class="col-md-2 text-right">活动主题：</div>
                        <div class="col-md-5"><%=title%></div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2 text-right">活动内容：</div>
                        <div class="col-md-5">
                            <textarea class="form-control" disabled="disabled" id="actContent" name="actContent" rows="5"><%=content%></textarea>
                        </div>
                    </div>
                    <input type="hidden" value="<%=a_id%>" name="a_id"/>
                    <button class="btn btn-success" type="button" style="margin:0 15px 0 450px;" id="fix">修改</button>
                    <button class="btn btn-success" type="submit" disabled="disabled" id="confirm_fix" style="margin-right:15px;">确认修改</button>
                    <button class="btn btn-success" type="button" disabled="disabled" id="cancel_fix">取消</button>
                </form>
            </div>
            <div class="joiner">  <!--显示参加活动人员-->
                <ul class="list-group">
                <%
                try{
                    activity.getConn();
                    String sql1="select * from activityjoiner where a_id="+a_id;
                    rs_1=activity.executeQuery(sql1);
                    while(rs_1.next()){
                %>
                <li class="list-group-item" style="position:relative;"><%=rs_1.getString("joinername")%>
                    <a href='deletejoiner?a_id=<%=a_id%>&joinername=<%=rs_1.getString("joinername")%>'>
                        <button class="btn btn-success btn-xs" style="position:absolute;right:20px;">删 除</button>
                    </a>
                    <a href='personinfo.jsp?username=<%=rs_1.getString("joinername")%>'>
                        <button type='button' class='btn btn-success btn-xs' style="position: absolute;right: 75px;">信息</button>
                    </a>
                </li>
                <%
                    }
                    activity.dbclose();
                }catch (Exception ex) {
                    Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                }
                %>
                </ul>
            </div>
        </div>
        <script type="text/javascript">
            var fix=document.getElementById('fix');
            var confirm_fix=document.getElementById('confirm_fix');
            var cancel_fix=document.getElementById('cancel_fix');
            var actContent=document.getElementById('actContent');
            
            fix.onclick=function(){
                confirm_fix.removeAttribute("disabled");
                actContent.removeAttribute("disabled");
                cancel_fix.removeAttribute("disabled");
                this.setAttribute("disabled","disabled");
            }
            cancel_fix.onclick=function(){
                fix.removeAttribute("disabled");
                confirm_fix.setAttribute("disabled","disabled");
                actContent.setAttribute("disabled","disabled");
                this.setAttribute("disabled","disabled");
            }
        </script>
    </body>
</html>
