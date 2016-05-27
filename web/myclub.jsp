<%-- 
    Document   : myclub
    Created on : 2016-5-11, 16:24:18
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
                <img class="head" alt="头像" src="images/img.png" /><span class="username"><%=session.getAttribute("username")%></span><br/>
                <ul class="alist">
                    <li><a href="info.jsp">个人信息</a></li>
                    <li><a href="myclub.jsp">我的社团</a></li>
                    <li><a href="createclub.jsp">创建社团</a></li>
                    <li><a href="joinclub.jsp">加入社团</a></li>
                </ul>
            </div>
            <div class="content">
                <div class="club_list join_club_list">
                    <h2>我加入的社团</h2>
                    <ul>
                        <jsp:useBean id="userinfo" scope="application" class="com.ucs.jsp.register"/>
                        <%
                            ResultSet j_rs=null,j_rs1=null;
                            String username=(String)session.getAttribute("username");
                            try{
                                userinfo.getConn();
                                String clubname1="";
                                String sql="select * from clubmember where members='"+username+"'";
                                j_rs=userinfo.executeQuery(sql);
                                j_rs1=userinfo.executeQuery(sql);
                                if(!j_rs.next()){
                                    out.print("<li>你还没有加入任何社团！<a href=\"joinclub.jsp\">马上去参加社团！</a></li>");
                                }else{
                                    while(j_rs1.next()){
                                        clubname1=j_rs1.getString("clubname");
                                        out.print("<li><span>"+clubname1+"</span><button>退出</button><a href=\"showclub.jsp?clubname="+clubname1+"\"><button>查看</button></a></li>");
                                    }
                                }
                            }catch (Exception ex) {
                                Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        %>
                    </ul>
                </div>
                <div class="club_list create_club_list">
                    <h2>我创建的社团</h2>
                    <ul id="create_club_list">
                        
                        <%
                            ResultSet c_rs=null,c_rs1=null;
                            String clubname2="";
                            try{
                                userinfo.getConn();
                                String sql="select * from clubowner where username='"+username+"'";
                                c_rs=userinfo.executeQuery(sql);
                                c_rs1=userinfo.executeQuery(sql);
                                if(!c_rs.next()){
                                    out.print("<li>你还没有创建任何社团！<a href=\"createclub.jsp\">马上去创建社团！</a></li>");
                                }else{
                                    while(c_rs1.next()){
                                        clubname2=c_rs1.getString("clubname");
                                        out.print("<li><span>"+clubname2+"</span><a href='#'><button>管理</button></a></li>");
                                    }
                                }
                            }catch (Exception ex) {
                                Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                            }
                            userinfo.dbclose();
                        %>
                    </ul>
                </div>
            </div>
        </div>
        <script>
            var create_club=document.getElementById('create_club_list');
            var create_club_list=create_club.getElementsByTagName('button');
            for(var i=0;i<create_club_list.length;i++){
                create_club_list[i].onclick=function(){
                    this.parentNode.href="manageclub.jsp?clubname="+this.parentNode.parentNode.firstChild.innerHTML;
                }
            }
        </script>
    </body>
</html>
