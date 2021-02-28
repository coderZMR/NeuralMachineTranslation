<%--
  Created by IntelliJ IDEA.
  User: RuI
  Date: 2018/2/27
  Time: 10:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>语料库添加</title>
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
    </div>
</div>

<div class="layui-container fly-marginTop">
    <div class="fly-panel" pad20 style="padding-top: 5px;">
        <div class="layui-form layui-form-pane layui-tab-item layui-show" style="text-align: center">
            <form action="SysManage?target=FileUpload" method="post" enctype="multipart/form-data">
                <div style="margin: 10px auto 10px">
                    <label>语料库名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="name" class="layui-input" placeholder="人工翻译语料库">
                    </div>
                </div>
                <div style="margin: 10px auto 10px">
                    <label>语料库来源</label>
                    <div class="layui-input-inline">
                        <input type="text" name="comeFrom" class="layui-input" placeholder="NMT-Web 机器翻译平台">
                    </div>
                </div>
                <div style="margin: 10px auto 10px">
                    <label>语料库上传</label>
                    <div class="layui-input-inline">
                        <input type="file" name="corpus" class="layui-input">
                    </div>
                </div>
                <div style="margin: 10px auto 10px">
                    <button class="layui-btn" type="submit">创建语料库</button>
                    <a href="SysManage?target=createHuTranCor" class="layui-btn layui-btn-normal">创建人工翻译语料库</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>


<%--
style="margin-left: 415px"
class="layui-form-item"
class="layui-form-label"
--%>