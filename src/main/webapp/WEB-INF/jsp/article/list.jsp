<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 리스트" />
<%@ include file="../part/head.jspf"%>

<script type="text/javascript">
	// 게시물 작성 AJAX 
	function ArticleWriteForm__submit(form) {
		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			alert('제목을 입력해주세요.');
			form.title.focus();
			return;
		}
		
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();
			return;
		}

		var startUploadFiles = function(onSuccess) {
			if ( form.file__article__0__common__attachment__1.value.length == 0 && form.file__article__0__common__attachment__2.value.length == 0 ) {
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
		}

		var startWrite = function(fileIdsStr, onSuccess) {
			$.ajax({
				url : './../article/doWriteAjax',
				data : {
					fileIdsStr: fileIdsStr,
					title: form.title.value,
					body: form.body.value,
					relTypeCode: form.relTypeCode.value,
					relId: form.relId.value
				},
				dataType:"json",
				type : 'POST',
				success : onSuccess
			});
		};

		startUploadFiles(function(data) {
			var idsStr = '';
			if ( data && data.body && data.body.fileIdsStr ) {
				idsStr = data.body.fileIdsStr;
			}
			startWrite(idsStr, function(data) {
				if ( data.msg ) {
					alert(data.msg);
				}

				form.title.value = '';
				form.body.value = '';
				form.file__article__0__common__attachment__1.value = '';
				form.file__article__0__common__attachment__2.value = '';
			});
		});
	}
</script>

<!-- 게시물 리스트 내 검색 창-->
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

<!-- 게시물 리스트 -->
<!-- PC용 -->
<div class="table-box con visible-on-md-up">
	<table>
		<colgroup>
			<col width="100" />
			<col width="200" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>제목</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${articles}" var="article">
				<tr>
					<td>${article.id}</td>
					<td>${article.regDate}</td>
					<td>
						<a href="${article.getDetailLink(board.code)}">${article.title}</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<!-- 모바일 용 -->
<div class="table-box con visible-on-sm-down">
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${articles}" var="article">
				<tr>
					<td>${article.id}</td>
					<td>
						<a href="${article.getDetailLink(board.code)}">${article.title}</a>
						<br />
						날짜 : ${article.regDate}
						<br />
						작성 : ${article.extra.writer}
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="btn-box con margin-top-20">
	<a class="btn btn-primary" href="./${board.code}-write">글쓰기</a>
</div>
<div class="total">
	전체 게시물 수 : ${totalCount}
</div>

<!-- 게시물 리스트 네비게이션 -->
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

<%@ include file="../part/foot.jspf"%>