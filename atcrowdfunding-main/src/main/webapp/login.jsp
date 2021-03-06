<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <%--包含指令属于java代码，以斜线开头标识上下文路径了，如果再增加上下文的表达式
        就会出现重复的上下文路径【ip+端口+项目名】
       --%>
    <%@include file="/WEB-INF/common/css.jsp"%>
    <title>登录界面</title>
    <style>

    </style>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="index.html" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
    </div>
</nav>

<div class="container">

    <form  id="loginForm" class="form-signin" role="form" action="${PATH}/login" method="post">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录</h2>
        <c:if test="${not empty message}">
            <div>
                ${message}
            </div>
        </c:if>
        <div class="form-group has-success has-feedback">
            <input name="loginacct" type="text" class="form-control" id="inputSuccess4" value="zhangsan" placeholder="请输入登录账号" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input name="userpswd" type="password" class="form-control" id="inputSuccess"value="123456" placeholder="请输入登录密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="checkbox">
            <label>
                <input type="checkbox" value="remember-me"> 记住我
            </label>
            <br>
            <label>
                忘记密码
            </label>
            <label style="float:right">
                <a href="reg.html">我要注册</a>
            </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 登录</a>
    </form>
</div>

<%@include file="/WEB-INF/common/js.jsp"%>
<script>
    function dologin() {
       $("#loginForm").submit();
    }
</script>
</body>
</html>