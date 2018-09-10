<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>更新状态 - 智游客户关系管理系统</title>
<link rel="stylesheet" href="<c:url value="/lib/font-awesome/css/font-awesome.css" />">
<link rel="stylesheet" href="<c:url value="/css/main.css" />">
</head>
<body>
	<div class="box">
		<h3>更新状态</h3>
		<form action="<c:url value="/customerState/update" />" method="post">
			<table class="form-table">
				<tr>
					<td>状态名称</td>
					<td colspan="3" class="control">
						<input type="text" name="customerStateName" value="${ customerState.customerStateName }" placeholder="填写状态名称">
					</td>
				</tr>
				<tr>
					<td>状态描述</td>
					<td colspan="3" class="control">
						<textarea class="p100" name="customerStateDesc" placeholder="请填写状态描述">${ customerState.customerStateDesc }</textarea>
					</td>
				</tr>
			</table>
			<div class="buttons">
				<input type="hidden" name="customerStateId" value="${ customerState.customerStateId }">
				<input class="btn btn-primary va-bottom" type="submit" value="保存">&nbsp;&nbsp;
				<a class="btn btn-default" href="javascript:history.go(-1)">返回</a>
			</div>
		</form>
	</div>
</body>
</html>