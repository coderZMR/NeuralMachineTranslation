<%--
  Created by IntelliJ IDEA.
  User: RuI
  Date: 2018/2/12
  Time: 19:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户登录</title>
    <link rel="stylesheet" href="css/login.css">
    <script src="js/login.js"></script>
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
<body onload="show();check()">
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
    <div id="container">
        <div style="border:1px solid black;width: 40%;margin: 0 auto;background: #404553;opacity:0.8;height: 40%;padding-top: 25px;border-radius: 5px ">
        <form <% if ("add".equals(request.getParameter("from"))) { %>
                    action="UserLogin?from=add"
                <% } else if ("detail".equals(request.getParameter("from"))) {%>
                    action="UserLogin?from=detail&qId=<%=request.getParameter("qId")%>"
                <% } else if ("questionHome".equals(request.getParameter("from"))) {%>
                    action="UserLogin?from=questionHome"
                <% } else { %>
                    action="UserLogin"
                <% } %>
                    method="POST">
            <!-- action属性值为处理该表单请求的servlet映射url method值为HTTP方法类型-->
            <%
                if (request.getAttribute("ifRegister") != null && (boolean)request.getAttribute("ifRegister")) {
            %>
                <div name="info">您已注册成功！请登录</div>
            <%
                }
            %>
            <%
                if (request.getParameter("info") != null && request.getParameter("info").equals("error")) {
            %>
                <div>“用户名或密码错误，请重新登录！”</div>
            <%
                }
            %>
            <h2 style="color: white">用户登录</h2>
            <br>
            <br>
            <table id="tableContainer">
                <tr>
                    <td style="color: white">用户名: </td><td><input type="text" name="userName" id="userName" onmouseout="UserCheck()"></td><td><p id="0" style="color: white"></p></td>
                </tr>
                <tr><td><br></td></tr>
                <tr>
                    <td style="color: white">密码:</td><td><input type="password" name="password" id="password" onmouseout="PasswordCheck()"></td><td><p id="1" style="color: white"></p></td>
                </tr>
                <tr><td><br></td></tr>
            </table>
            <span><input id="submit" type="submit" value="登录" disabled ></span>
            <br>
            <br>
            <div style="color: white">还没有账号? <a href="register.jsp" style="color: white">立即注册</a></div>
            <br>
            <div style="color: white">The time: <p id="time"></p></div>
        </form>
        </div>
    </div>
</body>
</html>
