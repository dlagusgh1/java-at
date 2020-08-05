<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

<style>
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
</style>

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
			</c:if>
			
			<c:if test="${searchKeyword != null}">
				<c:if test="${page != 1}">
					<c:set var="k" value="${page}" />
						<td><a href="?page=${k-1}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}"><</a></td>
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
					<td class="${i == page ? 'current' : ''}" >
						<a href="?page=${i}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}" class="block" >${i}</a>
					</td>
				</c:forEach>
				<c:if test="${page != totalPage}">
					<c:set var="k" value="${page}" />
						<td><a href="?page=${k+1}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}">></a></td>
				</c:if>
			</c:if>
		</tr>
	</table>
</div>

<div class="button-box">
	<a class="write-button" onclick="location.replace('write');">게시물 작성</a>
</div>

<%@ include file="../part/foot.jspf"%>