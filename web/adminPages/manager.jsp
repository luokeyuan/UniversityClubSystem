<%-- 
    Document   : manager
    Created on : 2016-5-9, 13:08:22
    Author     : MR.l
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>高校社团管理系统</title>
        <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
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
            .heading{
                width:100%;
                background:#222222;
            }
            .introduce{
                background-color: red;
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
                        <li class="active"><a href="#">用户信息</a></li>
                        <li><a href="#">社团信息</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#">退出系统</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
    <div class="content">
        <div class="container">
            <table class="table table-hover table-bordered">
                <tr>
                    <th>用户名</th>
                    <th>密码</th>
                    <th>性别</th>
                    <th>学校</th>
                    <th>电话</th>
                    <th>邮箱</th>
                    <th class="introduce">自我介绍</th>
                    <th>操作</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>1</td>
                    <td>1</td>
                    <td>1</td>
                    <td>1</td>
                    <td>1</td>
                    <td class="introduce">111111111111111</td>
                    <td><button class="btn btn-success btn-xs">删除</button></td>
                </tr>
            </table>
        </div>
    </div>
        <script src="../js/jquery-2.2.4.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="../js/bootstrap.min.js"></script>
    </body>
</html>
