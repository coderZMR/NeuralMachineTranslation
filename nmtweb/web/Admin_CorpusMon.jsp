<%@ page import="java.util.List" %>
<%@ page import="cn.nmtweb.bean.CorpusInfoItem" %><%--
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
    <title>语料库管理</title>
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
            <a href="SysManage?target=SysMon">
                <i class="layui-icon">&#xe628;</i>
                系统监控
            </a>
        </li>
        <li class="layui-nav-item layui-this">
            <a href="SysManage?target=CorpusMon">
                <i class="layui-icon">&#xe7a0;</i>
                语料库管理
            </a>
        </li>
        <li class="layui-nav-item">
            <a href="SysManage?target=Train">
                <i class="layui-icon">&#xe623;</i>
                模型训练
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
        <ul class="fly-case-list">
            <%
                List<CorpusInfoItem> corpusInfoItemList = (List<CorpusInfoItem>) request.getAttribute("CorpusInfoItemList");
                for (CorpusInfoItem corpusInfoItem : corpusInfoItemList) {
            %>
                <li>
                    <a class="fly-case-img">
                        <img src="pic/corpus.png" alt="语料库">
                    </a>
                    <h2><%=corpusInfoItem.getName()%></h2>
                    <p class="fly-case-desc" style="text-align: center"><%=corpusInfoItem.getComeFrom()%></p>
                    <div class="fly-case-info">
                        <div style="font-size: 12px; text-align: center">
                            <%
                                if (corpusInfoItem.getIsUsed() == 1) {
                            %>
                            <span style="color: #666;" class="layui-badge">已使用</span>
                            <%
                            } else {
                            %>
                            <span style="color: #666;" class="layui-badge layui-bg-green">未使用</span>
                            <%
                                }
                            %>
                        </div>
                        <div style="font-size: 12px; text-align: center"><%=corpusInfoItem.getCiDate()%></div>
                        <div style="text-align: center">
                            <a href="SysManage?target=FileDownload&filename=<%=corpusInfoItem.getName()%>" class="layui-btn-zmr layui-btn-sm layui-btn-normal">下载</a>
                            <a href="SysManage?target=FileDelete&filename=<%=corpusInfoItem.getName()%>" class="layui-btn-zmr layui-btn-sm layui-btn-danger">删除</a>
                        </div>
                    </div>
                </li>
            <%
                }
            %>
            <li>
                <div class="fly-case-info" style="text-align: center">
                    <a href="Admin_FileUpload.jsp"><i class="layui-icon" style="font-size: 60px">&#xe654;</i></a>
                </div>
            </li>
        </ul>
    </div>
</div>

</body>
</html>
