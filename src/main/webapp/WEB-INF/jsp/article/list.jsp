<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 리스트" />
<%@ include file="../part/head.jspf"%>

<style>
	a {
		color: inherit;
		text-decoration: none;
	}
	
	h1 {
		margin: 10px;
		text-align: center;
	}
	
	.total {
		display: flex;
		justify-content: center;
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
	
	.write-button {
		padding: 10px;
		margin: 10px;
		cursor: pointer;
		background: #f0f6f9;
		border: 1px solid #168;
	}
	
	.write-button:hover {
		color: white;
		background: #afafaf;
	}
	
	.page-box {
		display: flex;
		justify-content: center;
	}
	
	.page-box tr > td > a {
		font-size: 1.5rem;
		padding: 10px;
	}
	
	.search-box {
		display: flex;
		justify-content: center;
	}
	

	.write-box {
		display: flex;
		justify-content: center;
		width: 100%;
	}
	
	.write-box form {
		width: 600px;
		text-align: center;
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
	
	.write-box .form-row > .input > input {
		display: block;
		width: 100%;
		padding: 10px;
	}
	
	.write-box .form-row > .input > .submit-button {
		display: block;
		width: 200px;
		padding: 10px;
	}
	
	.article-write {
		padding: 10px;
		width: 100%;
		height: 100px;
		resize: none;
	}
</style>


<script type="text/javascript">
	// 게시물 작성 AJAX 
	function ArticleReply__submitWriteForm(form) {
		form.title.value = form.title.value.trim();
		form.body.value = form.body.value.trim();
		
		if (form.title.value.length == 0) {
			alert('젝목을 입력해주세요.');
			form.title.focus();

			return;
		}

		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();

			return;
		}

		$.post('./doWriteAjax', {
			title : form.title.value,
			body : form.body.value
		}, function(data) {
			
		}, 'json');

		form.title.value = '';
		form.body.value = '';
	}
</script>


<h1>게시물 리스트</h1>
<div class="search-box">
	<div class="input-box">
		<form action="list">
			<input type="hidden" name="page" value="1" /> 
			<input type="hidden" name="searchKeywordType" value="title" /> 
			<input type="text" name="searchKeyword" value="${param.searchKeyword}" />
			<button type="submit">검색</button>
		</form>
	</div>
</div>

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
			<td><a href="detail?id=${article.id}" >${article.title}</a></td>
			<td>${article.regDate}</td>
		</tr>
		</c:forEach>
	</table>
</div>
<div class="total">
	전체 게시물 수 : ${totalCount}
</div>


<div class="page-box">
	<table>
		<tr>
			<c:if test="${searchKeyword == null}">
				<c:if test="${page != 1}">
					<c:set var="k" value="${page}" />
						<td><a href="?page=1"><i class="fas fa-angle-double-left"></i></a></td>
						<td><a href="?page=${k-1}"><i class="fas fa-angle-left"></i></a></td>
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1" >
					<td class="${i == page ? 'current' : ''}" >
						<a href="?page=${i}" class="block">${i}</a>
					</td>
				</c:forEach>
				<c:if test="${page != totalPage}">
					<c:set var="k" value="${page}" />
						<td><a href="?page=${k+1}"><i class="fas fa-angle-right"></i></a></td>
						<td><a href="?page=${totalPage}"><i class="fas fa-angle-double-right"></i></a></td>
				</c:if>
			</c:if>
			
			<c:if test="${searchKeyword != null}">
				<c:if test="${page != 1}">
					<c:set var="k" value="${page}" />
						<td><a href="?page=1&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}"><i class="fas fa-angle-double-left"></i></a></td>
						<td><a href="?page=${k-1}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}"><i class="fas fa-angle-left"></i></a></td>
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
					<td class="${i == page ? 'current' : ''}" >
						<a href="?page=${i}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}" class="block" >${i}</a>
					</td>
				</c:forEach>
				<c:if test="${page != totalPage}">
					<c:set var="k" value="${page}" />
						<td><a href="?page=${k+1}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}"><i class="fas fa-angle-right"></i></a></td>
						<td><a href="?page=${totalPage}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}"><i class="fas fa-angle-double-right"></i></a></td>
				</c:if>
			</c:if>
		</tr>
	</table>
</div>

<h1 style="margin-top: 30px;">게시물 작성</h1>
<div class="write-box">
	<form action="" onsubmit="ArticleReply__submitWriteForm(this); return false;">
		<div class="form-row">
			<div class="label">제목</div>
			<div class="input">
				<input name="title" type="text" placeholder="제목을 입력해주세요." />
			</div>
		</div>
		<div class="form-row">
			<div class="label">내용</div>
			<div class="input">
				<textarea class="article-write" name="body" placeholder="내용을 입력해주세요."></textarea>
			</div>
		</div>
		<div class="form-row">
			<div class="label">파일 업로드</div>
			<div class="input">
				<input name="myFile" type="file" accept=".jpg, .png, .gif, .mp4"/>
			</div>
		</div>
		<div class="form-row">
			<div class="input" style="display: flex; justify-content: center;">
				<input class="submit-button" type="submit" value="작성"></input>
				<a class="submit-button" href="list?page=1">취소</a>
			</div>
		</div>
	</form>
</div>

<%@ include file="../part/foot.jspf"%>