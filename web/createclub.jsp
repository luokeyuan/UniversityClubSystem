<%-- 
    Document   : createclub
    Created on : 2016-5-11, 16:23:23
    Author     : MR.l
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>高校社团管理系统</title>
        <link rel="stylesheet" type="text/css" href="css/base.css">
        <link rel="stylesheet" type="text/css" href="css/createclub.css">
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
                <div class="createclub">
                    <form action="createclub" method="post" onsubmit="return check()">
                        <span class="item">社团名称:</span><input type="text" name="clubname" id="clubname" /><span id="warning"></span><br/>
                        <span class="item">简介:</span><textarea name="introduce" id="introduce"></textarea><br/>
                        <button type="submit" id="submit">确认创建</button>
                    </form>
                </div>
            </div>
        </div>
        <script>
            var submit = document.getElementById("submit");
            var clubname = document.getElementById("clubname");
            var intro = document.getElementById("introduce");
            var warning = document.getElementById("warning");
            
            //表单信息不能为空
            function check(){
                if(clubname.value==""||intro.value==""||clubname.value==null||intro.value==null){
                    alert("创建社团信息不能为空！");
                    return false;
                }
                return true;
            }
            
            clubname.onchange = function(){
                var xmlhttp;
		if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}else{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}

		xmlhttp.open('post','club_isset.jsp',true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		var str="clubname="+clubname.value;
		xmlhttp.send(str);
		xmlhttp.onreadystatechange = function(){
                    if(xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                        var s = xmlhttp.responseText;
                        if (s == 1){
                            warning.innerHTML = "该社团名称已被注册！";
                            clubname.value="";
                        }else{
                            warning.innerHTML = "";
                        }
                    }
		}
            }
            
        </script>
    </body>
</html>