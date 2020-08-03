<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
	a {
		color: inherit;
		text-decoration: none;
	}
	
	h1 {
		margin: 10px;
		text-align: center;
	}
	
	.table-box {
		display: flex;
		justify-content: center;
	}
		
	.article-table { 
		border-collapse: collapse;
		border-top: 2px solid #168;
		width: 600px;
		text-align: center;
		padding: 10px;
		margin: 10px;
	}	
	.article-table th {
		color: #168;
		background: #f0f6f9;
	}
	
	.article-table th, .article-table td {
		border: 0.5px solid #ddd;
		white-space:nowrap;
		padding: 10px;
	}
	
	.button-box {
		display: flex;
		justify-content: center;
	}
	
	button {
		padding: 10px;
		margin: 10px;
		cursor: pointer;
	}
	
	.page-box {
		display: flex;
		justify-content: center;
	}
	
	.page-box tr > td > a {
		font-size: 1.5rem;
		padding: 10px;
	}
</style>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 리스트</title>
</head>
<body>

<h1>게시물 리스트</h1>

<div class="table-box">
	<table class="article-table">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>등록일</th>
		</tr>
		<c:forEach items="${articles}" var="article">
		<tr>
			<td>${article.id}</td>
			<td><a href="http://localhost:8085/article/detail?id=${article.id}" >${article.title}</a></td>
			<td>${article.regDate}</td>
		</tr>
		</c:forEach>
	</table>
</div>

<div class="page-box">
	<table>
		<tr>
			<c:if test="${page != 1}">
				<c:set var="k" value="${page}" />
					<td><a href="?page=${k-1}"><</a></td>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
				<td class="${i == page ? 'current' : ''}" >
					<a href="?page=${i}" class="block" >${i}</a>
				</td>
			</c:forEach>
			<c:if test="${page != totalPage}">
				<c:set var="k" value="${page}" />
					<td><a href="?page=${k+1}">></a></td>
			</c:if>
		</tr>
	</table>
</div>

<div class="button-box">
	<button onclick="location.replace('write');">게시물 작성</button>
</div>

</body>
</html>