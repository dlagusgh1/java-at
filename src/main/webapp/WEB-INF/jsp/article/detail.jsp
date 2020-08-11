<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 상세내용" />
<%@ include file="../part/head.jspf"%>

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
	
	.reply-write {
		padding: 10px;
		width: 100%;
		height: 100px;
		resize: none;
	}
	
	.reply-modify {
		padding: 5px;
		width: 100%;
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
	
	.article-reply-list-box tr .loading-delete-inline {
	display: none;
	font-weight: bold;
	color: red;
	}
	
	.article-reply-list-box tr[data-loading="Y"] .loading-none {
		display: none;
	}
	
	.article-reply-list-box tr[data-loading="Y"][data-loading-delete="Y"] .loading-delete-inline
		{
		display: inline;
	}
	
	.article-reply-list-box tr[data-modify-mode="Y"] .modify-mode-none {
		display: none;
	}
	
	.article-reply-list-box tr .modify-mode-inline {
		display: none;
	}
	
	.article-reply-list-box tr .modify-mode-block {
		display: none;
	}
	
	.article-reply-list-box tr[data-modify-mode="Y"] .modify-mode-block {
		display: block;
	}
	
	.article-reply-list-box tr[data-modify-mode="Y"] .modify-mode-inline {
		display: inline;
	}
</style>

<style>
.reply-modify-form-modal {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(0, 0, 0, 0.4);
	display: none;
}

.reply-modify-form-modal-actived .reply-modify-form-modal {
	display: flex;
}
</style>

<c:if test="${article.delStatus != false}">
	<h1>삭제된 게시물 입니다.</h1>
</c:if>
<c:if test="${article.delStatus == false}">
	<h1>게시물 상세보기</h1>
	<div class="table-box">
		<table class="detail-table ">
			<tbody>
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
			</tbody>
		</table>
	</div>
</c:if>


<!-- 게시물 네비게이션 -->
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


<!-- 댓글 작성 -->
<c:if test="${isLogined}">
	<h2 class="con">댓글 작성</h2>

	<form class="table-box con form1"
		onsubmit="ArticleWriteReplyForm__submit(this); return false;">
		<input type="hidden" name="relTypeCode" value="article" /> <input
			type="hidden" name="relId" value="${article.id}" />

		<table>
			<tbody>
				<tr>
					<th>내용</th>
					<td>
						<div class="form-control-box">
							<textarea maxlength="300" name="body" placeholder="내용을 입력해주세요."
								class="height-300"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>첨부1 비디오</th>
					<td>
						<div class="form-control-box">
							<input type="file" accept="video/*" capture
								name="file__reply__0__common__attachment__1">
						</div>
					</td>
				</tr>
				<tr>
					<th>첨부2 비디오</th>
					<td>
						<div class="form-control-box">
							<input type="file" accept="video/*" capture
								name="file__reply__0__common__attachment__2">
						</div>
					</td>
				</tr>
				<tr>
					<th>작성</th>
					<td><input type="submit" value="작성"></td>
				</tr>
			</tbody>
		</table>
	</form>

</c:if>

<!-- 댓글 리스트 -->
<h2 class="con">댓글 리스트</h2>
<div class="total">
	전체 댓글 수 : ${articleReplies.size()} <!-- ${totalCount}  -->
</div>
<div class="reply-list-box table-box con">
	<table>
		<colgroup>
			<col width="80">
			<col width="180">
			<col width="180">
			<col>
			<col width="200">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>작성자</th>
				<th>내용</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>

		</tbody>
	</table>
</div>

<!-- 댓글 수정 -->
<div class="reply-modify-form-modal flex flex-ai-c flex-jc-c">
	<form action="" class="form1 bg-white padding-10"
		onsubmit="ReplyList__submitModifyForm(this); return false;">
		<input type="hidden" name="id" />
		<div class="form-row">
			<div class="form-control-label">내용</div>
			<div class="form-control-box">
				<textarea name="body" placeholder="내용을 입력해주세요."></textarea>
			</div>
		</div>
		<div class="form-row">
			<div class="form-control-label">수정</div>
			<div class="form-control-box">
				<button type="submit">수정</button>
				<button type="button" onclick="ReplyList__hideModifyFormModal();">취소</button>
			</div>
		</div>
	</form>
</div>


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
			memberId : 1,
			articleId : form.articleId.value,
			body : form.body.value
		}, function(data) {
			
		}, 'json');

		form.body.value = '';
	}

	// 댓글 리스트 AJAX
	var ArticleReply__lastLoadedArticleReplyId = 0;
	function ArticleReply__loadList() {
		$.get('./getForPrintArticleRepliesRs', {
			id : ${article.id},
			from : ArticleReply__lastLoadedArticleReplyId + 1
		}, function(data) {
			data.articleReplies = data.articleReplies.reverse();
			
			for (var i = 0; i < data.articleReplies.length; i++) {
				var articleReply = data.articleReplies[i];
				ArticleReply__drawReply(articleReply);

				ArticleReply__lastLoadedArticleReplyId = articleReply.id;
			}
			setTimeout(ArticleReply__loadList, 1000);
		}, 'json');
	}

	var ArticleReply__$listTbody;

	function ArticleReply__drawReply(articleReply) {
		var html = $('.template-box-1 tbody').html();

		html = replaceAll(html, "{$번호}", articleReply.id);
		html = replaceAll(html, "{$날짜}", articleReply.regDate);
		html = replaceAll(html, "{$내용}", articleReply.body);
		html = replaceAll(html, "{$작성자}", articleReply.extra.writer);
		
		ArticleReply__$listTbody.prepend(html);
	}

	$(function() {
		ArticleReply__$listTbody = $('.article-reply-list-box > table tbody');

		ArticleReply__loadList();
	});

	// 댓글 수정 AJAX
	function ArticleReply__enableModifyMode(obj) {
		var $clickedBtn = $(obj);
		var $tr = $clickedBtn.closest('tr');

		var $replyBodyText = $tr.find('.reply-body-text');
		var $textarea = $tr.find('form textarea');

		$textarea.val($replyBodyText.text().trim());

		$tr.attr('data-modify-mode', 'Y');
	}

	function ArticleReply__disableModifyMode(obj) {
		var $clickedBtn = $(obj);
		var $tr = $clickedBtn.closest('tr');

		$tr.attr('data-modify-mode', 'N');
	}

	function ArticleReply__submitModifyReplyForm(form) {
		var $tr = $(form).closest('tr');
		form.body.value = form.body.value.trim();

		if (form.body.value.length == 0) {
			alert('댓글내용을 입력 해주세요.');
			form.body.focus();

			return false;
		}

		var replyId = parseInt($tr.attr('data-article-reply-id'));
		var body = form.body.value;

		$tr.attr('data-loading', 'Y');
		$tr.attr('data-loading-modify', 'Y');

		$.post('./doModifyReplyAjax', {
			id : replyId,
			body : body
		}, function(data) {
			$tr.attr('data-loading', 'N');
			$tr.attr('data-loading-modify', 'N');

			ArticleReply__disableModifyMode(form);

			if (data.resultCode.substr(0, 2) == 'S-') {
				var $replyBodyText = $tr.find('.reply-body-text');
				var $textarea = $tr.find('form textarea');

				$replyBodyText.text($textarea.val());
			} else {
				if (data.msg) {
					alert(data.msg)
				}
			}
		});
	}

	// 댓글 삭제 AJAX
	function ArticleReply__delete(obj) {
		var $clickedBtn = $(obj);
		var $tr = $clickedBtn.closest('tr');

		var replyId = parseInt($tr.attr('data-article-reply-id'));

		$tr.attr('data-loading', 'Y');
		$tr.attr('data-loading-delete', 'Y');

		$.post('./doDeleteReplyAjax', {
			id : replyId
		}, function(data) {
			$tr.attr('data-loading', 'N');
			$tr.attr('data-loading-delete', 'N');

			// resultCode가 S-(성공)이면 삭제 진행.
			if (data.resultCode.substr(0, 2) == 'S-') {
				$tr.remove();
			} else {
				if (data.msg) {
					alert(data.msg)
				}
			}
		}, 'json');
		
	}
</script>
	
<%@ include file="../part/foot.jspf"%>