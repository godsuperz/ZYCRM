<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>角色管理 - 智游客户关系管理系统</title>
<link rel="stylesheet" href="<c:url value="/lib/font-awesome/css/font-awesome.css" />">
<link rel="stylesheet" href="<c:url value="/css/main.css" />">
</head>
<body>
	<div class="box">
		<h3>角色管理</h3>
		<div class="actions">
			<form></form>
			<div>
				<a class="btn btn-primary" href="<c:url value="/role/add" />">添加角色</a>
			</div>
		</div>
		<table class="list">
            <tr>
                <th>序号</th>
                <th>角色名称</th>
                <th>角色描述</th>
                <th>更新时间</th>
                <th>操作</th>
            </tr>
            <c:forEach var="role" items="${ list }">
            <tr>
                <td>${ role.roleId }</td>
                <td>${ role.roleName }</td>
                <td>${ role.roleDesc }</td>
                <td>
                	<fmt:formatDate value="${role.updateTime}" type="both" pattern="MM-dd HH:mm"/>
                </td>
                <td>
                	<a class="fa fa-pencil" title="编辑" href="<c:url value="/role/update?id=" />${role.roleId}"></a>
                	&nbsp;&nbsp;
                	<a class="fa fa-remove" title="删除" href="javascript:confirmDelete(${role.roleId})"></a>
                </td>
            </tr>
            </c:forEach>
        </table>
	</div>
	<script src="<c:url value="/lib/jquery/jquery.js" />"></script>
	<script>
    	function confirmDelete(id){
    		if (confirm("确定要删除码？")) {
    			location.href = '<c:url value="/role/remove?id=" />' + id
    		}
    	}
    </script>
</body>
</html>