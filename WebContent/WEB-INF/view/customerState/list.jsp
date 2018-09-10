<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>客户状态 - 智游客户关系管理系统</title>
<link rel="stylesheet" href="<c:url value="/lib/font-awesome/css/font-awesome.css" />">
<link rel="stylesheet" href="<c:url value="/css/main.css" />">
</head>
<body>
	<div class="box">
		<h3>客户状态</h3>
		<div class="actions">
			<form></form>
			<div>
				<a class="btn btn-primary" href="<c:url value="/customerState/add" />">添加状态</a>
			</div>
		</div>
		<table class="list">
            <tr>
                <th>序号</th>
                <th>状态名称</th>
                <th>状态描述</th>
                <th>更新时间</th>
                <th>操作</th>
            </tr>
            <c:forEach var="state" items="${ list }">
            <tr>
                <td>${ state.customerStateId }</td>
                <td>${ state.customerStateName }</td>
                <td>${ state.customerStateDesc }</td>
                <td>
                	<fmt:formatDate value="${state.updateTime}" type="both" pattern="MM-dd HH:mm"/>
                </td>
                <td>
                	<a class="fa fa-pencil" title="编辑" href="<c:url value="/customerState/update?id=" />${state.customerStateId}"></a>
                	&nbsp;&nbsp;
                	<a class="fa fa-remove" title="删除" href="javascript:confirmDelete(${state.customerStateId})"></a>
                </td>
            </tr>
            </c:forEach>
        </table>
	</div>
	<script src="<c:url value="/lib/jquery/jquery.js" />"></script>
	<script>
    	function confirmDelete(id){
    		if (confirm("确定要删除码？")) {
    			location.href = '<c:url value="/customerState/remove?id=" />' + id
    		}
    	}
    </script>
</body>
</html>