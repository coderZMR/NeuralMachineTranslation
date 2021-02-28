<%@ page import="java.util.List" %>
<%@ page import="cn.nmtweb.bean.Message" %><%--
  Created by IntelliJ IDEA.
  User: RuI
  Date: 2018/2/27
  Time: 16:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>我的消息</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="layui/css/global.css">
    <link rel="stylesheet" href="css/header.css">
    <script src="layui/layui.js"></script>
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

<div class="layui-container fly-marginTop fly-user-main">
    <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
        <li class="layui-nav-item">
            <a href="${pageContext.request.contextPath}/UserInfo?op=get&fromPage=home">
                <i class="layui-icon">&#xe609;</i>
                我的主页
            </a>
        </li>
        <li class="layui-nav-item">
            <a href="${pageContext.request.contextPath}/UserInfo?op=get&fromPage=userHome">
                <i class="layui-icon">&#xe612;</i>
                用户中心
            </a>
        </li>
        <li class="layui-nav-item">
            <a href="set.jsp">
                <i class="layui-icon">&#xe620;</i>
                基本设置
            </a>
        </li>
        <li class="layui-nav-item layui-this">
            <a href="UserMessage">
                <i class="layui-icon">&#xe611;</i>
                我的消息
            </a>
        </li>
        <li class="layui-nav-item">
            <a href="QuestionHome">
                <i class="layui-icon">&#xe68e;</i>
                问题中心
            </a>
        </li>
        <li class="layui-nav-item">
            <a href="UserLogout">
                <i class="layui-icon">&#x1006;</i>
                退出登录
            </a>
        </li>
    </ul>

    <div class="site-tree-mobile layui-hide">
        <i class="layui-icon">&#xe602;</i>
    </div>
    <div class="site-mobile-shade"></div>

    <div class="site-tree-mobile layui-hide">
        <i class="layui-icon">&#xe602;</i>
    </div>
    <div class="site-mobile-shade"></div>


    <div class="fly-panel fly-panel-user" pad20>
        <div class="layui-tab layui-tab-brief" lay-filter="user" id="LAY_msg" style="margin-top: 15px;">
            <a class="layui-btn layui-btn-danger" href="UserMessage?opt=deleteAll">清空全部消息</a>
            <div  id="LAY_minemsg" style="margin-top: 10px;">
                <%
                    List<Message> messageList = (List<Message>) request.getAttribute("messageList");
                    if (messageList.isEmpty()) {
                %>
                    <div class="fly-none">您暂时没有最新消息</div>
                <%
                    } else {
                %>
                    <ul class="mine-msg">
                        <%
                            for (int i = messageList.size() - 1; i >= 0; i--) {
                            Message message = messageList.get(i);
                        %>
                            <li data-id="123">
                                <%
                                    if (message.getType() == 0) {
                                %>
                                    <blockquote class="layui-elem-quote">
                                        <a href="${pageContext.request.contextPath}/UserInfo?op=get&fromPage=home&toUserName=<%=message.getaUserName()%>" target="_blank"><cite><%=message.getaUserName()%></cite></a>回答了您的问题<a target="_blank" href="QuestionHome?opt=detail&qId=<%=message.getqId()%>"><cite><%=message.getqString()%></cite></a>
                                    </blockquote>
                                <%
                                    } else {
                                %>
                                    <blockquote class="layui-elem-quote">
                                        <a href="${pageContext.request.contextPath}/UserInfo?op=get&fromPage=home&toUserName=<%=message.getqUserName()%>" target="_blank"><cite><%=message.getqUserName()%></cite></a>采纳了您的回答<a target="_blank" href="QuestionHome?opt=detail&qId=<%=message.getqId()%>"><cite><%=message.getaString()%></cite></a>
                                    </blockquote>
                                <%
                                    }
                                %>
                                <p><span><%=message.getmDate()%></span><a href="UserMessage?opt=delete&mId=<%=message.getId()%>" class="layui-btn layui-btn-small layui-btn-danger fly-delete">删除</a></p>
                            </li>
                        <%
                            }
                        %>
                    </ul>
                <%
                    }
                %>
            </div>
        </div>
    </div>

</div>
</body>
</html>
