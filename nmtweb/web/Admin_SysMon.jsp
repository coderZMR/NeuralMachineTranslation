<%@ page import="java.util.List" %>
<%@ page import="cn.nmtweb.bean.SysChangeItem" %><%--
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
    <title>系统监控</title>
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
        <li class="layui-nav-item  layui-this">
            <a href="SysManage?target=SysMon">
                <i class="layui-icon">&#xe628;</i>
                系统监控
            </a>
        </li>
        <li class="layui-nav-item">
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
        <ul class="mine-view jie-row" id="qListUl">
            <%
                List<SysChangeItem> sysChangeItemList = (List<SysChangeItem>) request.getAttribute("SysChangeItemList");
                if (sysChangeItemList.isEmpty()) {
            %>
                <div class="fly-none">您暂时没有最新消息</div>
            <%
                } else {
                    for (int i = sysChangeItemList.size() - 1; i >= 0; --i) {
                        SysChangeItem sysChangeItem = sysChangeItemList.get(i);
            %>
                    <li>
                        <span>操作：</span>
                        <%
                            String opt = sysChangeItem.getOpt();
                            switch (opt) {
                                case "语料库添加":
                                    %>
                                        <i class="layui-bg-green" style="padding: 0 5px 0"><%=sysChangeItem.getOpt()%></i>
                                    <%
                                    break;
                                case "语料库删除":
                                    %>
                                        <i class="layui-bg-red" style="padding: 0 5px 0"><%=sysChangeItem.getOpt()%></i>
                                    <%
                                    break;
                                case "语料库下载":
                                    %>
                                        <i class="layui-bg-blue" style="padding: 0 5px 0"><%=sysChangeItem.getOpt()%></i>
                                    <%
                                    break;
                                case "模型训练":
                                    %>
                                        <i class="layui-bg-orange" style="padding: 0 5px 0"><%=sysChangeItem.getOpt()%></i>
                                    <%
                                    break;
                            }
                        %>
                        <span style="margin-left: 10px">对象：</span><i><%=sysChangeItem.getTarget()%></i>
                        <em>时间：<%=sysChangeItem.getcDate()%></em>
                    </li>
                <%
                    }
                %>
            <%
                }
            %>
        </ul>
    </div>
</div>

</body>
</html>
