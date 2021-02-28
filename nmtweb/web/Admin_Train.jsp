<%@ page import="cn.nmtweb.bean.CorpusInfoItem" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: RuI
  Date: 2018/4/16
  Time: 13:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>管理员中心</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="layui/css/global.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/Admin_Train.css">
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
        <li class="layui-nav-item">
            <a href="SysManage?target=CorpusMon">
                <i class="layui-icon">&#xe7a0;</i>
                语料库管理
            </a>
        </li>
        <li class="layui-nav-item layui-this">
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
        <form class="layui-form" action="SysManage?target=TrainStart" method="post">
            <div class="layui-form-item">
                <label class="layui-form-label">模型选择</label>
                <div class="layui-input-block">
                    <input type="radio" name="model" value="En2Ch" title="英->中">
                    <input type="radio" name="model" value="Ch2En" title="中->英" checked>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">语料库选择</label>
                <div class="layui-input-block">
                    <select name="corpusName">
                        <option value="">请选择</option>
                        <optgroup label="未使用的语料库">
                            <%
                                List<CorpusInfoItem> corpusInfoItemList = (List<CorpusInfoItem>) request.getAttribute("CorpusInfoItemList");
                                for (CorpusInfoItem corpusInfoItem : corpusInfoItemList) {
                                    if (corpusInfoItem.getIsUsed() != 1) {
                            %>
                                <option value="<%=corpusInfoItem.getName()%>"><%=corpusInfoItem.getName()%></option>
                            <%
                                    }
                                }
                            %>
                        </optgroup>
                        <optgroup label="已使用的语料库">
                            <%
                                for (CorpusInfoItem corpusInfoItem : corpusInfoItemList) {
                                    if (corpusInfoItem.getIsUsed() == 1) {
                            %>
                            <option value="<%=corpusInfoItem.getName()%>"><%=corpusInfoItem.getName()%></option>
                            <%
                                    }
                                }
                            %>
                        </optgroup>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">批大小</label>
                <div class="layui-input-block">
                    <input type="text" name="batch_size" required  lay-verify="required" placeholder="请输入数字" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">周期数</label>
                <div class="layui-input-block">
                    <input type="text" name="n_epoch" required  lay-verify="required" placeholder="请输入数字" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">学习率</label>
                <div class="layui-input-block">
                    <input type="text" name="lr" required  lay-verify="required" placeholder="请输入数字" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">最大梯度</label>
                <div class="layui-input-block">
                    <input type="text" name="max_grad" required  lay-verify="required" placeholder="请输入数字" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">自动训练</label>
                <div class="layui-input-block">
                    <input type="radio" name="auto" value="Yes" title="是">
                    <input type="radio" name="auto" value="No" title="否" checked>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">训练时间</label>
                <div class="layui-input-block">
                    <input type="text" name="train_time" placeholder="请按格式（yyyy-MM-dd HH:mm:ss）输入训练时间" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
            <div class="input-box box-output">
                <%Object ConsoleResult = request.getAttribute("ConsoleResult");
                    if (ConsoleResult != null) {
                %>
                <%=ConsoleResult.toString()%>
                <% } %>
            </div>
        </form>
    </div>
</div>

</body>
</html>
