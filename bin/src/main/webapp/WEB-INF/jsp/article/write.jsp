<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

<title>게시물 작성하기</title>

<style>
	a {
		color: inherit;
		text-decoration: none;
	}
	
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
	
	.write-box .form-row .submit-button {
		cursor: pointer;
		padding: 10px 50px;
		margin: 10px;
		background: #f0f6f9;
		border: 1px solid #168;
	}
	
	.write-box .form-row .submit-button:hover {
		color: white;
		background: #afafaf;
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

<script type="text/javascript">
	function submitAddForm(form) {
		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			alert('제목을 입력해주세요.');
			form.title.focus();

			return false;
		}

		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();

			return false;
		}

		form.submit();
	}
</script>

<h1>게시물 작성</h1>

<div class="write-box">
	<form action="doWrite" method="POST" onsubmit="submitAddForm(this); return false;">
		<div class="form-row">
			<div class="label">제목</div>
			<div class="input">
				<input name="title" type="text" placeholder="제목을 입력해주세요." />
			</div>
		</div>
		<div class="form-row">
			<div class="label">내용</div>
			<div class="input">
				<textarea  name="body" placeholder="내용을 입력해주세요."></textarea>
			</div>
		</div>
		<div class="form-row">
			<div class="input" style="display: flex;">
				<input class="submit-button" type="submit" value="작성"></input>
				<a class="submit-button" href="list?page=1">취소</a>
			</div>
		</div>
	</form>
</div>

<%@ include file="../part/foot.jspf"%>