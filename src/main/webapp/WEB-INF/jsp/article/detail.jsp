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
	
	table { 
		border-collapse: collapse;
		border-top: 2px solid #168;
		width: 600px;
		text-align: center;
		padding: 10px;
		margin: 10px;
	}	
	
	table th, table td {
		border: 0.5px solid #ddd;
		white-space:nowrap;
		padding: 10px;
	}
	
	table th {
		font-weight: bold;
		color: #168;
		background: #f0f6f9;
	}
	
	table tr td {
		colspan: 2;
	}
	
	table tr td:first-child {
		font-weight: bold;
		color: #168;
		background: #f0f6f9;
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
</style>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 상세보기</title>
</head>
<body>
	
<h1>게시물 상세보기</h1>
	
<div class="table-box">
	<table>
		<tr>
			<th colspan=4>상세보기</th>
		</tr>
		<tr>
			<td>번호</td>
			<td>${article.id}</td>
		</tr>
		<tr>
			<td>제목</td>
			<td>${article.title}</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${article.body}</td>
		</tr>
		<tr>
			<td>작성일</td>
			<td>${article.regDate}</td>
		</tr>
	</table>
</div>

<div class="button-box">
	<button onclick="history.back();">돌아가기</button>
	<button><a href="http://localhost:8085/article/modify?id=${article.id}">게시물 수정</a></button>
	<button><a href="http://localhost:8085/article/delete?id=${article.id}">게시물 삭제</a></button>
</div>
	
</body>
</html>