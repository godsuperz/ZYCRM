<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>客户分类 - 智游客户关系管理系统</title>
<link rel="stylesheet" href="<c:url value="/lib/font-awesome/css/font-awesome.css" />">
<link rel="stylesheet" href="<c:url value="/css/main.css" />">
</head>
<body>
	<div class="box">
		<h3>客户分类</h3>
		<div class="actions">
			<form></form>
			<div>
				<a class="btn btn-primary" href="<c:url value="/customerCategory/add" />">添加分类</a>
			</div>
		</div>
		<table class="list">
            <tr>
                <th>序号</th>
                <th>分类名称</th>
                <th>分类描述</th>
                <th>更新时间</th>
                <th>操作</th>
            </tr>
            <c:forEach var="category" items="${ list }">
            <tr>
                <td>${ category.customerCategoryId }</td>
                <td>${ category.customerCategoryName }</td>
                <td>${ category.customerCategoryDesc }</td>
                <td>
                	<fmt:formatDate value="${category.updateTime}" type="both" pattern="MM-dd HH:mm"/>
                </td>
                <td>
                	<a class="fa fa-pencil" title="编辑" href="<c:url value="/customerCategory/update?id=" />${category.customerCategoryId}"></a>
                	&nbsp;&nbsp;
                	<a class="fa fa-remove" title="删除" href="javascript:confirmDelete(${category.customerCategoryId})"></a>
                </td>
            </tr>
            </c:forEach>
        </table>
	</div>
	<script src="<c:url value="/lib/jquery/jquery.js" />"></script>
	<script>
    	function confirmDelete(id){
    		if (confirm("确定要删除码？")) {
    			location.href = '<c:url value="/customerCategory/remove?id=" />' + id
    		}
    	}
    </script>
</body>
</html>