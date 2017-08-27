<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="utf-8"/>
    <title>ログイン</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          th:href="@{/webjars/bootstrap/3.3.7/css/bootstrap.min.css}"/>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
          th:href="@{/webjars/bootstrap/3.3.7/css/bootstrap-theme.min.css}"/>
</head>

<body>

<div class="container">
    <h1>ログイン</h1>
    <form class="form-signin" method="post" th:action="@{/login}">
        <h2 class="form-signin-heading">ログイン </h2>

        <div th:if="${param.error}" class="alert alert-danger">
        </div>
        <input type="text" class="form-control" name="username" placeholder="Username" required="required"
               autofocus="autofocus"/>
        <input type="password" class="form-control" name="password" placeholder="Password" required="required"/>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
    </form>
</div>
</body>
</html>