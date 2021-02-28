<%@ page import="cn.nmtweb.bean.Question" %>
<%@ page import="cn.nmtweb.bean.Answer" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: RuI
  Date: 2018/3/1
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>问题详情</title>
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
                        <dd><a href="QuestionHome"><i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe68e;</i>问题中心</a></dd>
                        <dd><a href="UserLogout" style="text-align: center;">退出登录</a></dd>
                    </dl>
                </li>
            <%
                }
            %>
        </ul>
    </div>
</div>

<div class="layui-container">
    <div class="layui-row layui-col-space15">
        <%
            String userName = (String) session.getAttribute("userName");
            if (userName == null) {
        %>
            <div class="fly-none">并无权限，请<a href="login.jsp?from=detail&qId=<%=request.getParameter("qId")%>">登录</a></div>
        <%
            } else {
        %>
        <div class="layui-row layui-col-space15">
            <div class="fly-panel detail-box">
                <div class="fly-detail-info">
                    <%
                        if (((Question)request.getAttribute("question")).getEnd() == 0) {
                    %>
                        <span class="layui-badge" style="background-color: #999;">未结</span>
                    <%
                        } else {
                    %>
                        <span class="layui-badge" style="background-color: #5FB878;">已结</span>
                    <%
                        }
                    %>

                    <span class="fly-list-nums">
                        <a href="#comment"><i class="iconfont" title="回答">&#xe60c;</i><%=((Question)request.getAttribute("question")).getaNum()%></a>
                    </span>
                </div>
                <div class="detail-about">
                    <div class="fly-avatar">
                        <h3>提问</h3>
                    </div>
                    <div class="fly-detail-user">
                        <a href="${pageContext.request.contextPath}/UserInfo?op=get&fromPage=home&toUserName=<%=((Question)request.getAttribute("question")).getUserName()%>" class="fly-link">
                            <cite><%=((Question)request.getAttribute("question")).getUserName()%></cite>
                        </a>
                        <span><%=((Question)request.getAttribute("question")).getqDate()%></span>
                    </div>
                </div>
                <div class="detail-body photos">
                    <%=((Question)request.getAttribute("question")).getqString()%>
                </div>
            </div>
            <div class="fly-panel detail-box" id="flyReply">
                <fieldset class="layui-elem-field layui-field-title" style="text-align: center;">
                    <legend>回复</legend>
                </fieldset>

                <ul class="jieda" id="jieda">
                    <%
                        int floorNum = 1;
                        List<Answer> aList = (List<Answer>)request.getAttribute("aList");
                        for (Answer answer : aList) {
                    %>
                    <li>
                        <div class="detail-about detail-about-reply">
                            <%--回答者信息--%>
                            <div class="fly-detail-user">
                                <div class="fly-avatar">
                                    <h3><%=floorNum%>楼</h3>
                                </div>
                                <a href="${pageContext.request.contextPath}/UserInfo?op=get&fromPage=home&toUserName=<%=answer.getaUserName()%>" class="fly-link">
                                    <cite><%=answer.getaUserName()%></cite>
                                </a>
                            </div>
                            <%--显示回答时间--%>
                            <div class="detail-hits">
                                <span><%=answer.getaDate()%></span>
                            </div>
                            <%--判断是否是最佳答案--%>
                            <%
                                if (answer.getAccept() == 1) {
                            %>
                                <i class="iconfont icon-caina" title="最佳答案"></i>
                            <%
                                }
                            %>
                        </div>
                        <%--回复的内容--%>
                        <div class="detail-body jieda-body photos">
                            <%=answer.getaString()%>
                            <div class="jieda-reply">
                                <div class="jieda-admin">
                                    <%
                                        if (session.getAttribute("userName").equals(((Question)request.getAttribute("question")).getUserName()) && ((Question)request.getAttribute("question")).getEnd() == 0) {
                                    %>
                                    <span class="jieda-accept" type="accept">
                                        <a href="QuestionHome?opt=accept&qId=<%=request.getParameter("qId")%>&aId=<%=answer.getId()%>&qUserName=<%=((Question)request.getAttribute("question")).getUserName()%>&aUserName=<%=answer.getaUserName()%>&qString=<%=((Question)request.getAttribute("question")).getqString()%>&aString=<%=answer.getaString()%>">采纳</a>
                                    </span>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                    </li>
                    <%
                        floorNum++;}
                    %>
                </ul>
                <%
                    if (!userName.equals(((Question) request.getAttribute("question")).getUserName()) && ((Question)request.getAttribute("question")).getEnd() == 0) {
                %>
                <div class="layui-form layui-form-pane">
                    <form action="QuestionHome?opt=reply&qId=<%=request.getParameter("qId")%>&qUserName=<%=((Question)request.getAttribute("question")).getUserName()%>&aNum=<%=((Question)request.getAttribute("question")).getaNum()%>&qString=<%=((Question)request.getAttribute("question")).getqString()%>" method="post">
                        <div class="layui-form-item layui-form-text">
                            <a name="comment"></a>
                            <div class="layui-input-block">
                                <textarea id="L_content" name="content" required lay-verify="required" placeholder="请输入内容"  class="layui-textarea fly-editor" style="height: 150px;"></textarea>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <button class="layui-btn" lay-filter="*" lay-submit>提交回复</button>
                        </div>
                    </form>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>
</body>
</html>
