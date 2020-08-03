<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
	h1 {
		margin: 10px;
		text-align: center;
	}
	.write-box {
		display: flex;
		justify-content: center;
		width: 100%;
	}
	
	.write-box .form-row {
		align-items: center;
		display: flex;
		margin: 20px;
	}
	
	.write-box .form-row button {
		cursor: pointer;
		padding: 10px 50px;
		margin: 10px;
	}
	
	.write-box .form-row>.label {
		width: 100px;
	}
	
	.write-box .form-row>.input {
		flex-grow: 1;
		flex-wrap: nowrap;
		text-align: center;
	}
	
	.write-box .form-row>.input>input {
		display: block;
		width: 200px;
		box-sizing: border-box;
		padding: 8px;
	}
	
	textarea {
		width: 100%;
		height: 100px;
		resize: none;
	}

</style>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정하기</title>
</head>
<body>

<h1>게시물 수정</h1>

<div class="write-box">
	<form action="doModify" method="POST">
		<div class="form-row">
			<div class="label">게시물 번호</div>
			<div class="input">
				<input name="id" type="hidden" value="${article.id}" />${article.id}
			</div>
		</div>
		<div class="form-row">
			<div class="label">제목</div>
			<div class="input">
				<input name="title" type="text" value="${article.title}" />
			</div>
		</div>
		<div class="form-row">
			<div class="label">내용</div>
			<div class="input">
				<textarea  name="body">${article.body}</textarea>
			</div>
		</div>
		<div class="form-row">
			<div class="input">
				<button type="submit" value="로그인">작성</button>
			</div>
		</div>
	</form>
</div>

</body>
</html>