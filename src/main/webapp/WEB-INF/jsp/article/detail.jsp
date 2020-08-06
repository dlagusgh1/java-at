<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

<title>게시물 상세보기</title>

<style>
	a {
		color: inherit;
		text-decoration: none;
	}
	
	h1, h2, h3 {
		margin: 10px;
		text-align: center;
	}
	
	.article-reply-list-box {
		display: flex;
		justify-content: center;
	}
	
	.table-box {
		display: flex;
		justify-content: center;
	}
	
	.detail-table { 
		border-collapse: collapse;
		border-top: 2px solid #168;
		width: 600px;
		text-align: center;
		padding: 10px;
		margin: 10px;
	}	
	
	.detail-table th, .detail-table td {
		border: 0.5px solid #ddd;
		white-space:nowrap;
		padding: 10px;
	}
	
	.detail-table th {
		font-weight: bold;
		color: #168;
		background: #f0f6f9;
	}
	
	.detail-table tr td {
		colspan: 2;
	}
	
	.detail-table tr td:first-child {
		font-weight: bold;
		color: #168;
		background: #f0f6f9;
	}
	
	.button-box {
		display: flex;
		justify-content: center;
	}
	
	.button-box a {
		padding: 10px;
		margin: 10px;
		cursor: pointer;
		background: #f0f6f9;
		border: 1px solid #168;
	}
	.button-box a:hover {
		color: white;
		background: #afafaf;
	}
	
	.articleReply-table { 
		border-collapse: collapse;
		border-top: 2px solid #168;
		width: 600px;
		text-align: center;
		padding: 10px;
		margin: 10px;
	}	
	
	.articleReply-table th, .articleReply-table td {
		border: 0.5px solid #ddd;
		white-space:nowrap;
		padding: 10px;
	}
	
	.articleReply-table th {
		font-weight: bold;
		color: #168;
		background: #f0f6f9;
	}
	
	.total {
		display: flex;
		justify-content: center;
	}
	
	.articleReply-write { 
		border-collapse: collapse;
		border-top: 2px solid #168;
		width: 600px;
		text-align: center;
		padding: 10px;
		margin: 10px;
	}	
	
	.articleReply-write th, .articleReply-write td {
		border: 0.5px solid #ddd;
		white-space:nowrap;
		padding: 10px;
	}
	
	.articleReply-write th {
		font-weight: bold;
		color: #168;
		background: #f0f6f9;
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
	
	.write-box .form-row>.input>input {
		display: block;
		width: 200px;
		box-sizing: border-box;
		padding: 8px;
	}
	
	textarea {
		padding: 10px;
		width: 100%;
		height: 100px;
		resize: none;
	}
	
	.page-box {
		display: flex;
		justify-content: center;
	}
	
	.page-box tr > td > a {
		font-size: 1.5rem;
		padding: 10px;
	}
	.articleReply-table tr > td:hover > a {
		color: red;
		font-weight: bold;
	}
</style>

<script>
	// 댓글 작성 AJAX 
	function ArticleReply__submitWriteForm(form) {
		form.body.value = form.body.value.trim();
		
		if (form.body.value.length == 0) {
			alert('댓글을 입력해주세요.');
			form.body.focus();

			return;
		}

		$.post('./doWriteReplyAjax', {
			articleId : form.articleId.value,
			body : form.body.value
		}, function(data) {
			if (data.msg) {
				alert(data.msg);
			}

			if ( data.resultCode.substr(0, 2) == 'S-' ) {
				location.reload(); // 임시
			}
		}, 'json');

		form.body.value = '';
	}

	// 댓글 리스트 AJAX
	function ArticleReply__loadList() {
		$.get('./getForPrintArticleRepliesRs', {
			id : ${article.id}
		}, function(data) {
			for (var i = 0; i < data.articleReplies.length; i++) {
				var articleReply = data.articleReplies[i];
				ArticleReply__drawReply(articleReply);
			}
		}, 'json');
	}

	var ArticleReply__$listTbody;

	function ArticleReply__drawReply(articleReply) {
		var html = '';

		html = '<tr data-article-reply-id="' + articleReply.id + '">';
		html += '<td>' + articleReply.id + '</td>';
		html += '<td>' + articleReply.regDate + '</td>';
		html += '<td>' + articleReply.body + '</td>';
		html += '<td>';
		html += '<a href="#">수정</a>';
		html += '</td>';
		html += '<td>';
		html += '<a href="#">삭제</a>';
		html += '</td>';
		html += '</tr>';

		ArticleReply__$listTbody.prepend(html);
	}

	$(function() {
		ArticleReply__$listTbody = $('.article-reply-list-box > table tbody');

		ArticleReply__loadList();
		//setInterval(ArticleReply__loadList, 1000);
	});
</script>
	
<c:if test="${article.delStatus != false}">
	<h1>삭제된 게시물 입니다.</h1>
</c:if>
<c:if test="${article.delStatus == false}">
	<h1>게시물 상세보기</h1>
	<div class="table-box">
		<table class="detail-table">
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
</c:if>

<div class="button-box">
	<c:if test="${article.id-1 != 0}">	
		<a href="detail?id=${param.id-1}">이전 글</a>
	</c:if>
		<a onclick="location.replace('list?page=1');">뒤로가기</a>
	<c:if test="${article.delStatus == false}">
		<a href="modify?id=${param.id}">게시물 수정</a>
		<a onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;" href="delete?id=${article.id}">게시물 삭제</a>
	</c:if>
	<c:if test="${article.id+1 != totalCount}">
		<a href="detail?id=${param.id+1}">다음 글</a>
	</c:if>
</div>

<c:if test="${article.delStatus == false}">
	<h2>댓글 리스트</h2>
	
	<div class="total">
		전체 댓글 수 : ${totalCount}
	</div>
	
	<div class="article-reply-list-box table-box">
		<table class="articleReply-table">
			<thead>
				<tr>
					<th style="width:10px;">번호</th>
					<th style="width:30px;">작성일</th>
					<th>내용</th>	
					<th style="width:10px;">수정</th>
					<th style="width:10px;">삭제</th>			
				</tr>
			</thead>
			<tbody>
				<!--  
				<c:forEach items="${articleReplies}" var="articleReply">
					<tr>
						<td style="width:10px;">${articleReply.id}</td>
						<td style="width:30px;">${articleReply.regDate}</td>
						<td>${articleReply.body}</td>
						<td style="width:10px;"><a href="replyModify?articleId=${articleReply.articleId}&articleReplyId=${articleReply.id}">수정</a></td>
						<td style="width:10px;"><a onclick="if ( confirm('댓글을 삭제하시겠습니까?') == false ) return false;" href="replyDelete?articleId=${param.id}&articleReplyId=${articleReply.id}">삭제</a></td>
					</tr>
				</c:forEach>
				-->
			</tbody>
		</table>
	</div>
	
	
	<div class="page-box">
		<table>
			<tr>
				<c:if test="${totalPage == 0}">
						<h3>댓글이 없습니다.</h3>
				</c:if>
				<c:if test="${totalPage != 0}">
					<c:if test="${page != 1}">
						<c:set var="k" value="${page}" />
							<td><a href="detail?id=${param.id}&page=${k-1}"><</a></td>
					</c:if>
					<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
						<td class="${i == page ? 'current' : ''}" >
							<a href="detail?id=${param.id}&page=${i}" class="block" >${i}</a>
						</td>
					</c:forEach>
					<c:if test="${page != totalPage}">
						<c:set var="k" value="${page}" />
							<td><a href="detail?id=${param.id}&page=${k+1}">></a></td>
					</c:if>
				</c:if>
			</tr>
		</table>
	</div>


	<h2>댓글 작성</h2>
	<div class="write-box">
		<form action="" onsubmit="ArticleReply__submitWriteForm(this); return false;">
			<input type="hidden" name="articleId" value="${param.id}" />
			<div class="form-row">
				<div class="label">내용</div>
				<div class="input">
					<textarea  name="body" placeholder="댓글의 내용을 입력해주세요."></textarea>
				</div>
			</div>
			<div class="form-row">
				<div class="input" style="display: flex; justify-content: center;">
					<input class="submit-button" type="submit" value="작성">	
				</div>
			</div>
		</form>
	</div>
</c:if>
	
<%@ include file="../part/foot.jspf"%>