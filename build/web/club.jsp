<%-- 
    Document   : club
    Created on : 2016-6-23, 22:08:53
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
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>高校社团管理系统</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
            <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <style type="text/css">
            body{
                padding-top: 60px;
            }
        </style>
    </head>
    <body>
        <nav class="heading">
            <div class="navbar navbar-inverse navbar-fixed-top">
                <div class="container">
                    <div class="navbar-header">
                        <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#collapse">
                            <span class="sr-only">Toggle Navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a href="#" class="navbar-brand">高校社团管理系统</a>
                    </div>
                    <div class="collapse navbar-collapse" id="collapse">
                        <ul class="nav navbar-nav">
                            <li class="active"><a href="manager.jsp">用户信息</a></li>
                            <li><a href="club.jsp">社团管理</a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="index.jsp">退出系统</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
    <div class="container">
        <div class="panel panel-success">
            <div class="panel-heading">社团管理</div>
            <div class="table-responsive">
                <table class="table table-hover table-bordered">
                    <tr>
                        <th>社团名称</th>
                        <th>创建者</th>
                        <th>简介</th>
                        <th>审核情况</th>
                        <th>社员人数</th>
                        <th>发布公告数</th>
                        <th>发布活动数</th>
                        <th>操作</th>
                    </tr>
                    <jsp:useBean id="user" scope="application" class="com.ucs.jsp.register"/>
                    <%
                        user.getConn();
                        ResultSet rs=null,rs_mem=null,rs_notice=null,rs_activity=null;
                        try{
                            String sql = "select * from clubowner";
                            rs=user.executeQuery(sql);
                            while(rs.next()){
                                int member = 0, notice = 0, activity = 0;
                                String state = "";
                                String clubname = rs.getString("clubname");
                                String sql_mem = "select * from clubmember where clubname = '"+clubname+"'";
                                rs_mem=user.executeQuery(sql_mem);
                                while(rs_mem.next()){
                                    member++;
                                }
                                String sql_notice = "select * from clubnotice where clubname = '"+clubname+"'";
                                rs_notice=user.executeQuery(sql_notice);
                                while(rs_notice.next()){
                                    notice++;
                                }
                                String sql_activity = "select * from clubactivity where clubname = '"+clubname+"'";
                                rs_activity=user.executeQuery(sql_activity);
                                while(rs_activity.next()){
                                    activity++;
                                }
                                
                                if(Integer.parseInt(rs.getString("state"))==1){  //查看审核情况
                                    state = "通过";
                                    
                    %>
                    <tr>
                        <td><%=rs.getString("clubname")%></td>
                        <td><%=rs.getString("username")%></td>
                        <td><%=rs.getString("introduce")%></td>
                        <td><%=state%></td>
                        <td><%=member%></td>
                        <td><a href='club_notice.jsp?clubname=<%=clubname%>'><%=notice%></a></td>
                        <td><a href='club_activity.jsp?clubname=<%=clubname%>'><%=activity%></a></td>
                        <td><a href="deleteclub_admin?clubname=<%=clubname%>"><button class="btn btn-danger btn-xs">删除</button></a></td>
                    </tr>
                    <%
                                }else{
                                    state = "待审核";
                    %>
                    <tr>
                        <td><%=rs.getString("clubname")%></td>
                        <td><%=rs.getString("username")%></td>
                        <td><%=rs.getString("introduce")%></td>
                        <td><%=state%></td>
                        <td><%=member%></td>
                        <td><a href='club_notice.jsp?clubname=<%=rs.getString("clubname")%>'><%=notice%></a></td>
                        <td><a href='club_activity.jsp?clubname=<%=rs.getString("clubname")%>'><%=activity%></a></td>
                        <td>
                            <a href="passClub?clubname=<%=clubname%>"><button class="btn btn-success btn-xs">通过</button></a>
                            <a href="nopassClub?clubname=<%=clubname%>"><button class="btn btn-danger btn-xs">不通过</button></a>
                        </td>
                    </tr>
                    <%
                                }
                            }
                        }catch (Exception ex) {
                            Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    %>

                </table>
            </div>
        </div>
    </div>
        
        
        <script src="js/jquery-2.2.4.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script>
            $("td>a").click(function(){
                if($(this).text()==0){
                   $(this).attr("href","#");
                }
            });
            
        </script>
    </body>
</html>
