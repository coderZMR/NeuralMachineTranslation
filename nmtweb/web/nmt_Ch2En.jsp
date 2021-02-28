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
    <meta name="charset" content="utf-8">
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <link rel="stylesheet" href="css/clear-style.css">
    <link rel="stylesheet" href="css/nmt.css?v=1">
    <title>NMT-Web</title>
</head>
<body>
<div class="header-bar">
    <div class="header-left">
        <div class="logo">
            N M T - W e b
        </div>
        <div class="logo-desc">
            机器翻译平台
        </div>
    </div>
</div>
<div class="translate-app">
    <div class="translate-title">
        <div class="translate-desc-left">
            机器翻译工具
        </div>
        <div class="translate-desc-right">
            <a href="login.jsp">用户注册/登录</a>
            <a href="${pageContext.request.contextPath}/QuestionHome">问题中心</a>
        </div>
    </div>
    <form action="Nmt?type=2" method="post">
        <div class="translate-area">
            <div class="translate-area-left">
                <div class="language-choose">
                    <div class="language-select">
                        中文
                    </div>
                </div>
                <textarea class="input-box" name="userInput"><%Object userIntput = request.getAttribute("userInput");if (userIntput != null) {%><%=userIntput.toString()%><% } %></textarea>
            </div>
            <div class="translate-area-right">
                <div class="language-choose">
                    <div class="language-select">
                        英语
                    </div>
                </div>
                <div class="input-box box-output">
                    <%Object nmtOutput = request.getAttribute("nmtOutput");
                        if (nmtOutput != null) {
                    %>
                    <%=nmtOutput.toString()%>
                    <% } %>
                </div>
                <input type="submit" class="translate-bottom" value="翻译">
                <a type="submit" class="translate-bottom" href="nmt_En2Ch.jsp">转换</a>
            </div>
        </div>
    </form>
</div>
</body>
</html>

