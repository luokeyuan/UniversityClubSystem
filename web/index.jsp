<%-- 
    Document   : index
    Created on : 2016-5-3, 15:47:58
    Author     : MR.l
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
	<meta charset="utf-8">
	<title>欢迎使用高校社团管理系统</title>
	<link rel="stylesheet" type="text/css" href="css/login.css">
	<script src="js/base.js"></script>
    </head>
    <body>
    <div class="header">
        <div class='title'></div>
    </div>
    <div class="content">
        <div class="wrap">
    	<div class="nav">
                <div class="btnf log-btn" id="login">登录</div>
                <div class="btnf reg-btn" id="register">注册</div>
    	</div>
    	<div class="login" id="log-panel">
                <form method="post">
                    <div class="form user">
                        <span class="icon"></span><input type="text" placeholder="用户名" name="log-user" id="log-user" />
                        <span class="msg" id="user-msg"><i></i>用户不存在</span>
                    </div>
                    <div class="form password">
                        <span class="icon"></span><input type="password" placeholder="密码" name="log-password" id="log-password" />
                        <span class="msg" id="pwd-msg"><i></i>密码错误</span>
                    </div>
                    <div class="usertype">
                        <input type="radio" name="usertype" id="user" value="user" checked="checked"/><label for="user"> 普通用户</label>
                        &nbsp;<input type="radio" name="usertype" id="admin" value="admin"/><label for="admin"> 管理员</label>			
                    </div>
                    <div class="form btn"><input type="button" value="登     录" id="login-sub" /></div>
                </form>
    	</div>
    	<div class="register" id="reg-panel">
                <form method="post">
                    <div class="form1 rg-user">
                        用户名<span>*</span><input type="text" name="reg-username" id="reg-username" />
                        <span class="msg" id="user-exist"><i></i>该用户名已被注册！</span>
                    </div>
                    <div class="form1 rg-pwd rg-pwd1">密码<span>*</span><input type="password" name="reg-password" id="reg-password" /></div>
                    <div class="form1 rg-pwd rg-pwd2">
                        确认密码<span>*</span><input type="password" id="reg-password1" />
                        <span class="msg" id="pwd-confirm"><i></i>两次密码输入不一致！</span>
                    </div>
                    <div class="btn"><input type="button" value="注     册" id="register-sub" /></div>
                </form>
    	</div>
        </div>
    </div>
    </body>
</html>
