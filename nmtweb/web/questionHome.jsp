<%@ page import="cn.nmtweb.bean.Question" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: RuI
  Date: 2018/3/1
  Time: 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>问题中心</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="layui/css/global.css">
    <link rel="stylesheet" href="css/header.css">
    <script src="layui/layui.js"></script>
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
        <ul class="layui-nav fly-nav-user">
            <%
                if (session.getAttribute("userName") == null) {
            %>
            <!-- 未登入的状态 -->
            <li class="layui-nav-item">
                <a href="login.jsp?from=questionHome">用户注册/登录</a>
            </li>
            <%
            } else {
            %>
            <!-- 登入后的状态 -->
            <li class="layui-nav-item">
                <a class="fly-nav-avatar" href="javascript:;">
                    <cite class="layui-hide-xs"><%=(String) session.getAttribute("userName")%></cite>
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="UserInfo?op=get&fromPage=userHome"><i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe612;</i>用户中心</a></dd>
                    <dd><a href="UserLogout" style="text-align: center;">退出登录</a></dd>
                </dl>
            </li>
            <%
                }
            %>
        </ul>
    </div>
</div>

<div class="fly-panel fly-column">
    <div class="layui-container">
        <div class="fly-column-right layui-hide-xs">
            <span class="fly-search"><i class="layui-icon"></i></span>
            <a href="add.jsp" class="layui-btn">发表提问</a>
        </div>
        <div class="layui-hide-sm layui-show-xs-block" style="margin-top: -10px; padding-bottom: 10px; text-align: center;">
            <a href="add.jsp" class="layui-btn">发表提问</a>
        </div>
    </div>
</div>

<div class="layui-container">
    <div class="layui-row layui-col-space15">
        <div class="fly-panel" style="margin-bottom: 0;">
            <ul class="fly-list">
                <%
                    List<Question> qList = (List<Question>) request.getAttribute("qList");
                    for (int index = qList.size() - 1; index >= 0; index--) {
                        Question question = qList.get(index);
                %>
                    <li>
                        <h2>
                            <a href="QuestionHome?opt=detail&qId=<%=question.getId()%>"><%=question.getqString()%></a>
                        </h2>
                        <div class="fly-list-info">
                            <a href="${pageContext.request.contextPath}/UserInfo?op=get&fromPage=home&toUserName=<%=question.getUserName()%>" link>
                                <cite><%=question.getUserName()%></cite>
                            </a>
                            <span><%=question.getqDate()%></span>
                            <%
                                if (question.getEnd() == 1) {
                            %>
                                <span class="layui-badge fly-badge-accept layui-hide-xs">已结</span>
                            <%
                                }
                            %>
                            <span class="fly-list-nums">
                                <i class="iconfont icon-pinglun1" title="回答"></i> <%=question.getaNum()%>
                            </span>
                        </div>
                    </li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>
</div>

</body>
</html>
