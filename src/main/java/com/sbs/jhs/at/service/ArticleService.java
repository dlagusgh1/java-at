package com.sbs.jhs.at.service;

import java.util.List;

import com.sbs.jhs.at.dto.Article;
import com.sbs.jhs.at.dto.ArticleReply;

public interface ArticleService {
	
	// 게시물 리스트
	public List<Article> getForPrintArticles(int limitFrom, int itemsInAPage);

	// 게시물 상세보기
	public Article getForPrintArticle(int id);

	// 게시물 작성
	public void write(String title, String body);

	// 게시물 삭제
	public void delete(int id);
	
	// 게시물 수 출력
	public int getForPrintListArticlesCount();

	// 게시물 수정
	public void modify(int id, String title, String body);

	// 검색 게시물 리스트
	public List<Article> getForPrintSearchArticle(int limitFrom, int itemsInAPage, String searchKeywordType, String searchKeyword);

	// 검색 게시물 수 출력
	public int getForPrintListSearchArticlesCount(String searchKeywordType, String searchKeyword);

	// 댓글 작성 기능
	public void writeReply(int articleId, String body);

	// 특정 게시물 댓글 수 출력
	public int getForPrintListArticleRepliesCount(int id);

	// 특정 게시물 내 댓글 리스트
	public List<ArticleReply> getForPrintArticleReply(int id, int limitFrom, int itemsInAPage);
	
}



