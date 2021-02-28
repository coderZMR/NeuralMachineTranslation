<%@ page import="cn.nmtweb.bean.User" %>
<%@ page import="cn.nmtweb.bean.Answer" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.nmtweb.bean.Question" %><%--
  Created by IntelliJ IDEA.
  User: RuI
  Date: 2018/2/27
  Time: 10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>用户主页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
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

<div class="fly-home fly-panel">
    <h1>
        <%=((User)request.getAttribute("user")).getUserName()%>
        <%
            if (((User)request.getAttribute("user")).getSex().equals("男")) {
        %>
            <i class="iconfont icon-nan"></i>
        <%
            } else {
        %>
            <i class="iconfont icon-nv"></i>
        <%
            }
        %>
        <i class="layui-badge fly-badge-vip"><%=((User)request.getAttribute("user")).getUserType()%></i>
    </h1>

    <p style="padding: 10px 0; color: #5FB878;">邮箱<%=((User)request.getAttribute("user")).getEmail()%></p>

    <p class="fly-home-info">
        <i class="iconfont icon-shijian"></i><span>最近登录  <%=((User)request.getAttribute("user")).getLastLoginTime()%></span>
        <i class="iconfont icon-chengshi"></i><span>来自  <%=((User)request.getAttribute("user")).getComeFrom()%></span>
    </p>

    <p class="fly-home-sign">（<%=((User)request.getAttribute("user")).getSignature()%>）</p>


</div>

<div class="layui-container">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md6 fly-home-jie">
            <div class="fly-panel">
                <h3 class="fly-panel-title"><%=((User)request.getAttribute("user")).getUserName()%> 最近的提问</h3>
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
            </div>
        </div>

        <div class="layui-col-md6 fly-home-da">
            <div class="fly-panel">
                <h3 class="fly-panel-title"><%=((User)request.getAttribute("user")).getUserName()%> 最近的回答</h3>
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
            </div>
        </div>
    </div>
</div>
</body>
</html>
