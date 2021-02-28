<%@ page import="cn.nmtweb.bean.User" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.nmtweb.bean.Question" %>
<%@ page import="cn.nmtweb.bean.Answer" %><%--
  Created by IntelliJ IDEA.
  User: RuI
  Date: 2018/2/14
  Time: 17:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>用户中心</title>
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
        <li class="layui-nav-item layui-this">
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
        <li class="layui-nav-item">
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
        <div class="layui-tab layui-tab-brief" lay-filter="user">
            <ul class="layui-tab-title" id="LAY_mine">
                <li data-type="mine-jie" lay-id="index" class="layui-this">我请求的翻译（<span><%=((User)request.getAttribute("user")).getQuestionNum()%></span>）</li>
                <li data-type="collection" data-url="/collection/find/" lay-id="collection">我回复的翻译（<span><%=((User)request.getAttribute("user")).getAnswerNum()%></span>）</li>
            </ul>
            <div class="layui-tab-content" style="padding: 20px 0;">
                <div class="layui-tab-item layui-show">
                    <ul class="mine-view jie-row" id="qListUl">
                        <%
                            List<Question> qList = (List<Question>) request.getAttribute("qList");
                            for (Question question : qList) {
                        %>
                        <li>
                            <a class="jie-title" href="QuestionHome?opt=detail&qId=<%=question.getId()%>" target="_blank"><%=question.getqString()%></a>
                            <i>提问时间：<%=question.getqDate()%></i>
                            <em>回答数目：<%=question.getaNum()%></em>
                        </li>
                        <%
                            }
                        %>
                    </ul>
                    <div id="LAY_page"></div>
                </div>
                <div class="layui-tab-item">
                    <ul class="mine-view jie-row">
                    <%
                        List<Answer> aList = (List<Answer>) request.getAttribute("aList");
                        for (Answer answer : aList) {
                    %>
                    <li>
                        <a class="jie-title" href="QuestionHome?opt=detail&qId=<%=answer.getqId()%>" target="_blank"><%=answer.getaString()%></a>
                        <i>回答时间：<%=answer.getaDate()%></i>
                        <em>提问者：<%=answer.getqUserName()%></em>
                    </li>
                    <%
                        }
                    %>
                </ul>
                    <div id="LAY_page1"></div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
