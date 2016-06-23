<%-- 
    Document   : info
    Created on : 2016-5-11, 16:22:21
    Author     : MR.l
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.ucs.jsp.register"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>高校社团管理系统</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/base.css">
        <link rel="stylesheet" type="text/css" href="css/info.css">
        <style>
            .showinfo{
                padding-top: 20px;
            }
            .showinfo p{
                display: inline-block;
                width: 400px;
            }
            .showinfo .btn{
                width:120px;
            }
        </style>
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
        <jsp:useBean id="userinfo" scope="application" class="com.ucs.jsp.register"/>
        <%
            String name="",sex="",school="",phone="",email="",intro="";
            ResultSet rs=null;
            try{
                userinfo.getConn();
                String sql="select * from register where username='"+username+"'";
                rs=userinfo.executeQuery(sql);
                if(rs.next()){
                    name=rs.getString("username");
                    sex=rs.getString("sex");
                    school=rs.getString("school");
                    phone=rs.getString("phone");
                    email=rs.getString("email");
                    intro=rs.getString("introduce");
                }
            }catch (Exception ex) {
                Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
            }
        %>
        <div class="wrap">
            <div class="info">
                <ul class="nav nav-pills nav-stacked">
                    <li class="active"><a href="main.jsp">首页</a></li>
                    <li><a href="info.jsp">个人信息</a></li>
                    <li><a href="myclub.jsp">我的社团</a></li>
                    <li><a href="createclub.jsp">创建社团</a></li>
                    <li><a href="joinclub.jsp">加入社团</a></li>
                    <li><a href="joinactivity.jsp">参加活动</a></li>
                </ul>
            </div>
            <div class="content" id="info">
                <div class="showinfo">
                    <span class="item">用户名：</span><span><%=name%></span><br/>
                    <span class="item">性别：</span><span><%=sex%></span><br/>
                    <span class="item">所在学校：</span><span><%=school%></span><br/>
                    <span class="item">联系电话：</span><span><%=phone%></span><br/>
                    <span class="item">E-mail：</span><span><%=email%></span><br/>
                    <span class="item">个人描述：</span><p><%=intro%></p><br/>
                    <button type="button" class="btn btn-success" id="fixinfo">修改个人信息</button>
                </div>
            </div>
            <div class="content" id="changeinfo">
                <form action="/UniversityClubSystem/changeinfoservlet" method="post" class="form form-horizontal">
                    <div class="form-group">
                        <div class="col-md-2 text-right sex">性别：</div>
                        <div class="col-md-10">
                            <select name="sex" class="form-control">
                            <%
                            String[] sexes = {"保密","男","女"};
                            for (int i=0; i< 3; i++){
                                if(sexes[i].equals(sex)){%>
                                    <option value="<%=sexes[i]%>" selected="selected"><%=sexes[i]%></option>
                                <%}else{%>
                                    <option value="<%=sexes[i]%>"><%=sexes[i]%></option>
                                <%}
                            }
                            %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="school" class="col-md-2 control-label">所在学校：</label>
                        <div class="col-md-10">
                            <input class="fix_info form-control" type="text" name="school" id="school" value="<%=school%>"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="phone" class="col-md-2 control-label">联系电话：</label>
                        <div class="col-md-10">
                            <input class="fix_info form-control" type="text" name="phone" id="phone" value="<%=phone%>"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">E-mail：</label>
                        <div class="col-md-10">
                            <input class="fix_info form-control" type="text" name="email" value="<%=email%>"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label" for="introduce">个人描述：</label>
                        <div class="col-md-10">
                            <textarea name="intro" id="introduce" class="form-control" rows="5"><%=intro%></textarea>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-success" id="submit">保存</button>
                    <button type="button" class="btn btn-success" id="cancel">取消</button>
                </form>
            </div>
        </div>
                    
        <script>
            var fixinfo = document.getElementById("fixinfo");
            var submit = document.getElementById("submit");
            var cancel = document.getElementById("cancel");
            var changeinfo = document.getElementById("changeinfo");
            var info = document.getElementById("info");
            
            function showinfo(){
                info.style.display = "block";
                changeinfo.style.display = "none";
            }
    
            fixinfo.onclick  = function(){
                info.style.display = "none";
                changeinfo.style.display = "block";
            }
            submit.onclick = showinfo;
            cancel.onclick = function(){
                var c = confirm("确认不修改任何信息吗？");
                if (c == true){
                    showinfo();
                }
            }
        </script>
    </body>
</html>
