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
        <div class="header">
            <div class="nav">
                <h1>高校社团管理系统</h1><span class="link"><a href="main.jsp">首页</a><a href="index.jsp">退出系统</a></span>
            </div>
        </div>
        <jsp:useBean id="userinfo" scope="application" class="com.ucs.jsp.register"/>
        <%
            String username=(String)session.getAttribute("username");
            String name="",sex="",school="",phone="",email="",intro="",image="";
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
                    image="Favicon\\"+rs.getString("image");
                }
            }catch (Exception ex) {
                Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
            }
        %>
        <div class="wrap">
            <div class="info">
                <img class="head" alt="头像" src="<%=image%>"/><span class="username"><%=username%></span><br/>
                <ul class="alist">
                    <li><a href="info.jsp">个人信息</a></li>
                    <li><a href="myclub.jsp">我的社团</a></li>
                    <li><a href="createclub.jsp">创建社团</a></li>
                    <li><a href="joinclub.jsp">加入社团</a></li>
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
                    <button type="button" class="btn" id="fixinfo">修改个人信息</button>
                </div>
            </div>
            <div class="content" id="changeinfo">
                <form action="/UniversityClubSystem/changeinfoservlet" method="post">
                    <div class="changehead"><span class="item">头像：</span><img src="images/img.png" alt="头像" /><span class="inputfile">上传图片<input type="file"/></span></div>
                    <span class="item">性别：</span>
                    <select name="sex">
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
                    </select><br/>
                    <span class="item">所在学校：</span><input class="fix_info" type="text" name="school" value="<%=school%>"/><br/>
                    <span class="item">联系电话：</span><input class="fix_info" type="text" name="phone" value="<%=phone%>"/><br/>
                    <span class="item">E-mail：</span><input class="fix_info" type="text" name="email" value="<%=email%>"/><br/>
                    <span class="item">个人描述：</span><textarea name="intro"><%=intro%></textarea><br/>
                    <button type="submit" class="btn" id="submit">保存</button>
                    <button type="button" class="btn" id="cancel">取消</button>
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
