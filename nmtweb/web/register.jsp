<%--
  Created by IntelliJ IDEA.
  User: RuI
  Date: 2018/2/12
  Time: 21:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册</title>
    <script src="js/register.js"></script>
    <link rel="stylesheet" href="css/register.css">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="layui/css/global.css">
    <link rel="stylesheet" href="css/header.css">
    <script src="layui/layui.js"></script>
    <script src="js/jquery-3.3.1.js"></script>
    <script>
        layui.config({
            version: "2.0.0"
            ,base: 'mods/'
        }).extend({
            fly: 'index'
        }).use('fly');
    </script>
</head>
<body onload="SubmitCheck()">
<div class="fly-header layui-bg-black">
    <div class="layui-container">
        <div class="header-left">
            <div class="logo">
                N M T - W e b
            </div>
            <div class="logo-desc">
                机器翻译平台
            </div>
        </div>
    </div>
</div>
<!-- 从页面加载开始就检测是否可以提交 -->
<div id="container">
    <h2>用户信息</h2>
    <br>
    <br>
    <form action="UserRegister" method="POST">
        <%
            if (request.getAttribute("ifRegister") != null && !(boolean)request.getAttribute("ifRegister")) {
        %>
        <div>用户名已存在！请重新注册</div>
        <%
            }
        %>
        <table id="tableContainer">
            <tr>
                <td>账号: </td><td><input onmouseout = "UserCheck()" id="userName" type="text" name="userName" ></td><td><p id="0"></p></td>
            </tr>
            <tr><td><br></td></tr>
            <tr>
                <td>密码：</td><td><input onmouseout = "PassCheck()" id="password" type="password" name="password" ></td><td><p id="1"></p></td>
            </tr>
            <tr><td><br></td></tr>
            <tr>
                <td>确认密码: </td><td><input onmouseout = "PassTwoCheck()" id = "PassTwo" type="password" name="PassTwo" ></td><td><p id="2"></p></td>
            </tr>
        </table>
        <br>
        <br>
        <span><input id = "submit" disabled type="submit" value="立即注册"/></span>
    </form>
</div>
</body>
</html>
