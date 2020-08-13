<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

<title>게시물 수정하기</title>

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
	function ArticleModifyForm__submit(form) {
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

<!-- 게시물 수정 -->
<c:if test="${isLogined}">
	<h1 style="margin-top: 30px;">게시물 수정</h1>
	<form class="table-box con form1" action="doModify" method="POST" onsubmit="ArticleModifyForm__submit(this); return false;">
		<table>
			<tbody>
				<tr>
					<th>게시물 번호</th>
					<td>
						<div class="form-control-box">
							<input name="id" type="hidden" value="${article.id}" />${article.id}
						</div>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<div class="form-control-box">
							<input name="title" type="text" value="${article.title}" />
						</div>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<div class="form-control-box">
							<textarea  name="body">${article.body}</textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>첨부1 비디오</th>
					<td>
						<div class="form-control-box">
							<input type="file" accept="video/*" capture name="file__article__0__common__attachment__1">
						</div>
					</td>
				</tr>
				<tr>
					<th>첨부2 비디오</th>
					<td>
						<div class="form-control-box">
							<input type="file" accept="video/*" capture name="file__article__0__common__attachment__2">
						</div>
					</td>
				</tr>
				<tr>
					<th>수정</th>
					<td><input type="submit" value="수정"></td>
				</tr>
			</tbody>
		</table>
	</form>
</c:if>

<%@ include file="../part/foot.jspf"%>