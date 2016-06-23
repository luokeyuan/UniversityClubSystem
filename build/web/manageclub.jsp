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
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/base.css">
        <link rel="stylesheet" type="text/css" href="css/manageclub.css">
    </head>
    <body>
        <jsp:useBean id="club" scope="application" class="com.ucs.jsp.register"/>
        <%
            String clubname=request.getParameter("clubname");
        %>
        <div class="header">
            <div class="header-content">
                <h1>高校社团管理系统</h1><span class="link"><a href="myclub.jsp">返回</a><a href="main.jsp">首页</a><a href="outSystem">退出系统</a></span>
            </div>
        </div>
        <div class="wrap">
            <div class="operate_list">
                <ul id="operate_list">
                    <li class="active">发布公告</li>
                    <li>发布活动</li>
                    <li>查看成员</li>
                    <li>修改信息</li>
                </ul>
            </div>
            <div class="clubname">
                <h2><%=clubname%></h2>
            </div>
            <div class="notice sidebar" id="sb1">
                <div class="edit">  <!--发布公告-->
                    <form action="manageclub" method="post" class="form" onsubmit="return check_notice()">
                        <div class="form-group">
                            <h4>发布公告</h4>
                            <textarea name="content" class="form-control" rows="5" id="noti_content"></textarea>
                        </div>
                        <input type="hidden" value="<%=clubname%>" name="clubname" />
                        <div class="form-group">
                            <input type="hidden" name="formcontent" value="clubnotice" />
                            <button type="submit" class="btn btn-success" id="noti_submit" >完&nbsp;成</button>
                        </div>
                    </form>
                </div>
                <div class="shownotice"><!--显示已发布的公告-->
                <%
                try{
                    club.getConn();
                    ResultSet n_rs1=null,n_rs=null;
                    String sql="select * from clubnotice where clubname='"+clubname+"'";
                    n_rs=club.executeQuery(sql);
                    n_rs1=club.executeQuery(sql);
                    if(n_rs.next()){
                        while(n_rs1.next()){//%>
                            <div class="panel panel-success">
                                <div class="panel-body"><%=n_rs1.getString("content") %></div>
                                <div class="panel-footer" style="position:relative">
                                    <span>发布日期：<%=n_rs1.getString("datetime") %></span>
                                    <a href='deletenotice?n_id=<%=n_rs1.getString("n_id")%>&clubname=<%=clubname%>'>
                                    <button class="btn btn-success btn-xs" style="position:absolute;right:20px;top:12px;">删除</button>
                                    </a>
                                </div>
                            </div>
                    <%  }
                    }
                }catch (Exception ex) {
                    Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                }
                %>
                </div>   
            </div>
            
            <div class="activity sidebar" id="sb2"><!-- 发布活动-->
                <div class="issueAct"><!--发布活动-->
                    <form action="manageclub" method="post" class="form form-horizontal" onsubmit="return check_activity()">
                        <div class="form-group">
                            <label for="actTitle" class="col-md-2 control-label">活动标题</label>
                            <div class="col-md-5">
                                <input type="text" name="actTitle" id="actTitle" class="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="actContent" class="col-md-2 control-label">活动内容</label>
                            <div class="col-md-5">
                                <textarea class="form-control" id="actContent" name="actContent" rows="5"></textarea>
                            </div>
                        </div>
                        <input type="hidden" value="<%=clubname%>" name="clubname" />
                        <input type="hidden" name="formcontent" value="clubactivity">
                        <button type="submit" class="btn btn-success" id="act_submit" >发&nbsp;布</button>
                    </form>
                </div>
                <div class="showAct"><!--显示已发布活动-->
                    <%
                    try{
                        club.getConn();
                        ResultSet a_rs1=null,a_rs=null,rs_4_1=null;
                        String sql="select * from clubactivity where clubname='"+clubname+"'";
                        a_rs=club.executeQuery(sql);
                        a_rs1=club.executeQuery(sql);
                        if(a_rs.next()){
                            while(a_rs1.next()){//
                                String sql1_1="select * from activityjoiner where a_id="+Integer.parseInt(a_rs1.getString("a_id"));
                                rs_4_1=club.executeQuery(sql1_1);
                                int count=0;
                                while(rs_4_1.next()){
                                    count++;
                                }
                    %>
                    <div class="panel panel-success">
                        <div class="panel-heading" style="position:relative;">
                            <h3 class="panel-title"><%=a_rs1.getString("title")%></h3><span class="text-right" style="position:absolute;right:20px;top:12px;">已有 <%=count%> 人参加</span>
                        </div>
                        <div class="panel-body"><%=a_rs1.getString("content") %></div>
                        <div class="panel-footer" style="position:relative">
                            <span>发布日期：<%=a_rs1.getString("datetime") %></span>
                            <a href='showActivity.jsp?a_id=<%=a_rs1.getString("a_id")%>'>
                                <button class="btn btn-success btn-xs" style="position:absolute;right:76px;top:6px;">查看</button>
                            </a>
                            <a href='deleteactivity?a_id=<%=a_rs1.getString("a_id")%>&clubname=<%=clubname%>'>
                                <button class="btn btn-success btn-xs" style="position:absolute;right:20px;top:6px;">删除</button>
                            </a>
                        </div>
                    </div>
                    <%
                            }
                        }
                    }catch (Exception ex) {
                        Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    %>
                </div> 
            </div>
            
            <div class="members sidebar" id="sb3"><!--显示社团成员-->
                <h2>社团所有成员</h2>
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
                    <li class='list-group-item' style="position: relative;"><%=m_rs.getString("members")%>
                        <a href='deletemember?members=<%=m_rs.getString("members")%>&clubname=<%=clubname%>'>
                            <button type='button' class='btn btn-success btn-xs' style="position: absolute;right: 20px;">删除</button>
                        </a>
                        <a href='personinfo.jsp?username=<%=m_rs.getString("members")%>'>
                            <button type='button' class='btn btn-success btn-xs' style="position: absolute;right: 75px;">信息</button>
                        </a>
                    </li>
                    <%
                            }
                        }
                        club.dbclose();
                    }catch (Exception ex) {
                        Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    %>
                </ul>
            </div>
                
            <div class="clubinfo sidebar" id="sb4"><!--修改社团信息-->
                <form class="form" action="manageclub" method="post">
                <div class="form-group">
                    <h4>名称：</h4>
                    <input type="text" value="<%=clubname%>" class="form-control" disabled="disabled"/>
                </div>
                <%
                    ResultSet rs=null;
                    String intro="";
                    try{
                        club.getConn();
                        String sql="select * from club where clubname='"+clubname+"'";
                        rs=club.executeQuery(sql);
                        if(rs.next()){
                           intro = rs.getString("introduce");
                        }
                        
                    }catch (Exception ex) {
                        Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    club.dbclose();
                %>
                <div class="form-group">
                    <h4>简介：</h4>
                    <textarea class="form-control" name="introduce" rows="3"><%=intro%></textarea>
                </div>
                <div class="form-group">
                    <input type="hidden" name="clubname" value="<%=clubname%>"/>
                    <input type="hidden" name="formcontent" value="clubinfo" />
                    <input type="submit" value="确认修改" class="btn btn-success" />
                </div>
                </form>
            </div>
        </div>

        <script src="js/http-ajax.js"></script>
        <script>
            var operate_list = document.getElementById("operate_list");
            var sidebar = {
                0 : document.getElementById("sb1"),
                1 : document.getElementById("sb2"),
                2 : document.getElementById("sb3"),
                3 : document.getElementById("sb4")
            }
            var list_child = operate_list.getElementsByTagName("li");

            //切换页面
            for(var i=0;i<list_child.length;i++){
                cutView(list_child[i],list_child,sidebar,i);
            }
            function cutView(ele1,eles1,eles2,index){
                ele1.onclick=function(){
                    for (var j=0; j<eles1.length; j++){
                        eles1[j].removeAttribute("class");
                        eles2[j].style.display = "none";
                    }
                    this.setAttribute("class","active");
                    eles2[index].style.display = "block";
                }
            }
            
            var noti_content = document.getElementById("noti_content");
            var actTitle = document.getElementById("actTitle");
            var actContent = document.getElementById("actContent");
            
            //表单信息不能为空
            function check_notice(){
                if(noti_content.value==""||noti_content.value==null){
                    alert("发布公告信息不能为空！");
                    return false;
                }
                return true;
            }
            function check_activity(){
                if(actContent.value==""||actContent.value==null||actTitle.value==""||actTitle.value==null){
                    alert("发布活动内容不能为空！");
                    return false;
                }
                return true;
            }
            
        </script>
    </body>
</html>
