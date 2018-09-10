<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>部门信息 - 智游客户关系管理系统</title>
<link rel="stylesheet" href="<c:url value="/lib/font-awesome/css/font-awesome.css" />">
<link rel="stylesheet" href="<c:url value="/css/main.css" />">
</head>
<body>
	<div class="box">
		<h3>部门信息</h3>
		<div class="actions">
			<form></form>
			<div>
				<a class="btn btn-primary" href="<c:url value="/department/add" />">添加部门</a>
			</div>
		</div>
		<table class="list">
            <tr>
                <th>序号</th>
                <th>部门名称</th>
                <th>部门描述</th>
                <th>更新时间</th>
            </tr>
            <c:forEach var="department" items="${ list }">
            <tr>
                <td>${ department.departmentId }</td>
                <td>${ department.departmentName }</td>
                <td>${ department.departmentDesc }</td>
                <td>
                	<fmt:formatDate value="${department.updateTime}" type="both" pattern="MM-dd HH:mm"/>
                </td>
            </tr>
            </c:forEach>
        </table>
	</div>
	<script src="<c:url value="/lib/jquery/jquery.js" />"></script>
</body>
</html>