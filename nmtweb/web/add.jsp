<%--
  Created by IntelliJ IDEA.
  User: RuI
  Date: 2018/3/1
  Time: 13:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>发表问题</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="layui/css/global.css">
    <link rel="stylesheet" href="css/header.css">
    <script src="layui/layui.js"></script>
    <script>
        layui.config({
            version: "3.0.0"
            ,base: 'mods/'
        }).extend({
            fly: 'index'
        }).use('fly');
    </script>
</head>
<body>
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

<div class="layui-container fly-marginTop">
    <div class="fly-panel" pad20 style="padding-top: 5px;">
        <%
            String userName = (String) session.getAttribute("userName");
            if (userName == null) {
        %>
            <div class="fly-none">并无权限，请<a href="login.jsp?from=add">登录</a></div>
        <%
            } else {
        %>
            <div class="layui-form layui-form-pane">
                <div class="layui-tab layui-tab-brief" lay-filter="user">
                    <ul class="layui-tab-title">
                        <li class="layui-this">发表新问题</li>
                    </ul>
                    <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
                        <div class="layui-tab-item layui-show">
                            <form action="QuestionHome?opt=add" method="post">
                                <div class="layui-form-item layui-form-text">
                                    <div class="layui-input-block">
                                        <textarea id="L_content" name="content" required lay-verify="required" placeholder="详细描述" class="layui-textarea fly-editor" style="height: 260px;"></textarea>
                                    </div>
                                </div>

                                <div class="layui-form-item">
                                    <button class="layui-btn" lay-filter="*" lay-submit>立即发布</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        <%
            }
        %>
    </div>
</div>

</body>
</html>
