<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 상세내용" />
<%@ include file="../part/head.jspf"%>

<c:if test="${article.delStatus != false}">
	<h1>삭제된 게시물 입니다.</h1>
</c:if>
<c:if test="${article.delStatus == false}">
	<div class="table-box con">
		<table class="detail-table ">
			<tbody>
				<tr>
					<th colspan=4>상세보기</th>
				</tr>
				<tr>
					<th>번호</th>
					<td>${article.id}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${article.title}</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${article.body}</td>
				</tr>
				<tr>
					<th>첨부 파일 내용</th>
					<td><video controls src="/usr/file/streamVideo?id=1" ></video></td>
				</tr>
				<tr>
					<th>작성일</th>
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

	<form class="table-box con form1" onsubmit="ArticleWriteReplyForm__submit(this); return false;">
		<input type="hidden" name="relTypeCode" value="article" /> 
		<input type="hidden" name="relId" value="${article.id}" />
		<table>
			<tbody>
				<tr>
					<th>내용</th>
					<td>
						<div class="form-control-box">
							<textarea maxlength="300" name="body" placeholder="내용을 입력해주세요." class="height-300"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>첨부1 비디오</th>
					<td>
						<div class="form-control-box">
							<input type="file" accept="video/*" capture name="file__reply__0__common__attachment__1">
						</div>
					</td>
				</tr>
				<tr>
					<th>첨부2 비디오</th>
					<td>
						<div class="form-control-box">
							<input type="file" accept="video/*" capture name="file__reply__0__common__attachment__2">
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
	<form action="" class="form1 bg-white padding-10" onsubmit="ReplyList__submitModifyForm(this); return false;">
		<input type="hidden" name="id" />
		<div class="form-row">
			<div class="form-control-label">내용</div>
			<div class="form-control-box">
				<textarea name="body" placeholder="내용을 입력해주세요."></textarea>
			</div>
		</div>
		<div class="form-row">
			<div class="form-control-label">첨부1 비디오</div>
			<div class="form-control-box">
				<input type="file" accept="video/*" capture name="file__reply__0__common__attachment__1">
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
	function ArticleWriteReplyForm__submit(form) {
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('댓글을 입력해주세요.');
			form.body.focus();
			return;
		}

		var startUploadFiles = function(onSuccess) {
			// 실행 1
			if ( form.file__reply__0__common__attachment__1.value.length == 0 && form.file__reply__0__common__attachment__2.value.length == 0 ) {
				onSuccess();
				return;
			}

			var fileUploadFormData = new FormData(form); 
			
			fileUploadFormData.delete("relTypeCode");
			fileUploadFormData.delete("relId");
			fileUploadFormData.delete("body");

			$.ajax({
				url : './../file/doUploadAjax',
				data : fileUploadFormData,
				processData : false,
				contentType : false,
				dataType:"json",
				type : 'POST',
				success : onSuccess
			});
			// 실행 2
		}

		var startWriteReply = function(fileIdsStr, onSuccess) {
			// 실행 4
			$.ajax({
				url : './../reply/doWriteReplyAjax',
				data : {
					fileIdsStr: fileIdsStr,
					body: form.body.value,
					relTypeCode: form.relTypeCode.value,
					relId: form.relId.value
				},
				dataType:"json",
				type : 'POST',
				success : onSuccess
			});
			// 실행 5
		};

		startUploadFiles(function(data) {
			// 실행 3
			var idsStr = '';
			if ( data && data.body && data.body.fileIdsStr ) {
				idsStr = data.body.fileIdsStr;
			}
			startWriteReply(idsStr, function(data) {
				// 실행 7
				if ( data.msg ) {
					alert(data.msg);
				}
				// 실행 8
				form.body.value = '';
				form.file__reply__0__common__attachment__1.value = '';
				form.file__reply__0__common__attachment__2.value = '';
			});
			// 실행 6
		});
	}

	// 댓글 수정 AJAX
	var ReplyList__$box = $('.reply-list-box');
	var ReplyList__$tbody = ReplyList__$box.find('tbody');

	var ReplyList__lastLodedId = 0;

	var ReplyList__submitModifyFormDone = false;

	function ReplyList__submitModifyForm(form) {
		if (ReplyList__submitModifyFormDone) {
			alert('처리중입니다.');
			return;
		}

		form.body.value = form.body.value.trim();

		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();

			return;
		}

		var id = form.id.value;
		var body = form.body.value;

		ReplyList__submitModifyFormDone = true;
		$.post('../reply/doModifyReplyAjax', {
			id : id,
			body : body
		}, function(data) {
			if (data.resultCode && data.resultCode.substr(0, 2) == 'S-') {
				// 성공시에는 기존에 그려진 내용을 수정해야 한다.!!
				var $tr = $('.reply-list-box tbody > tr[data-id="' + id
						+ '"] .reply-body');
				$tr.empty().append(body);
			}

			ReplyList__hideModifyFormModal();
			ReplyList__submitModifyFormDone = false;
		}, 'json');
	}

	// 댓글 수정 - 수정 폼 보이기
	function ReplyList__showModifyFormModal(el) {
		$('html').addClass('reply-modify-form-modal-actived');
		var $tr = $(el).closest('tr');
		var originBody = $tr.data('data-originBody');

		var id = $tr.attr('data-id');

		var form = $('.reply-modify-form-modal form').get(0);

		form.id.value = id;
		form.body.value = originBody;
	}

	// 댓글 수정 - 수정 폼 숨기기
	function ReplyList__hideModifyFormModal() {
		$('html').removeClass('reply-modify-form-modal-actived');
	}

	function ReplyList__loadMoreCallback(data) {
		if (data.body.replies && data.body.replies.length > 0) {
			ReplyList__lastLodedId = data.body.replies[data.body.replies.length - 1].id;
			ReplyList__drawReplies(data.body.replies);
		}

		setTimeout(ReplyList__loadMore, 2000);
	}

	// 특정 게시물의 댓글 리스트 가져오기
	function ReplyList__loadMore() {

		$.get('../reply/getForPrintReplies', {
			articleId : param.id,
			from : ReplyList__lastLodedId + 1
		}, ReplyList__loadMoreCallback, 'json');
	}

	// 댓글 리스트 (댓글 컨트롤러에서 가져온 댓글 리스트를 ReplyList__drawReply에 각각 넣어서 출력되도록 전달)
	function ReplyList__drawReplies(replies) {
		for (var i = 0; i < replies.length; i++) {
			var reply = replies[i];
			 ReplyList__drawReply(reply);
		}
	}

	// 댓글 삭제 AJAX
	function ReplyList__delete(el) {
		if (confirm('삭제 하시겠습니까?') == false) {
			return;
		}

		var $tr = $(el).closest('tr');

		var id = $tr.attr('data-id');

		$.post('./../reply/doDeleteReplyAjax', {
			id : id
		}, function(data) {
			$tr.remove();
		}, 'json');
	}

	// 댓글 리스트 AJAX (받아온 각각의 댓글을 통해 댓글 리스트 생성)
	function ReplyList__drawReply(reply) {
		var html = '';
		html += '<tr data-id="' + reply.id + '">';
		html += '<td>' + reply.id + '</td>';
		html += '<td>' + reply.regDate + '</td>';
		html += '<td>' + reply.extra.writer + '</td>';
		html += '<td>';
		html += '<div class="reply-body">' + reply.body + '</div>';
		if (reply.extra.file__common__attachment__1) {
            var file = reply.extra.file__common__attachment__1;
            html += '<video controls src="/usr/file/streamVideo?id=' + file.id + '">video not supported</video>';
        }

		if (reply.extra.file__common__attachment__2) {
            var file = reply.extra.file__common__attachment__2;
            html += '<video controls src="/usr/file/streamVideo?id=' + file.id + '">video not supported</video>';
        }
		
		html += '</td>';
		html += '<td>';

		if (reply.extra.actorCanDelete) {
			html += '<button type="button" onclick="ReplyList__delete(this);">삭제</button>';
		}
		
		if (reply.extra.actorCanModify) {
			html += '<button type="button" onclick="ReplyList__showModifyFormModal(this);">수정</button>';
		}
		
		html += '</td>';
		html += '</tr>';

		var $tr = $(html);
		$tr.data('data-originBody', reply.body);
		ReplyList__$tbody.prepend($tr);
	}

	ReplyList__loadMore();
</script>
	
<%@ include file="../part/foot.jspf"%>