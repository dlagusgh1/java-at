package com.sbs.jhs.at.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.jhs.at.dto.Article;

@Mapper
public interface ArticleDao {
	/* article list 시작 */
	// 게시물 리스트
	List<Article> getForPrintArticles(int limitFrom, int itemsInAPage);
	
	// 검색된 게시물 리스트
	List<Article> getForPrintSearchArticle(int limitFrom, int itemsInAPage, String searchKeywordType, String searchKeyword);
	
	// 검색된 게시물 수 출력
	int getForPrintListSearchArticlesCount(String searchKeywordType, String searchKeyword);
	
	// 게시물 수 출력
	int getForPrintListArticlesCount();
	
	// 게시물 수 출력(삭제된 것 포함)
	int getForPrintListArticlesTotalCount();
	/* article list 끝 */
	
	
	/* article detail 시작 */
	// 게시물 상세보기
	Article getForPrintArticleById(@Param("id") int id);
	/* article detail 끝 */
	
	
	/* article write 시작 */
	// 게시물 작성
	void write(Map<String, Object> param);
	/* article write 끝 */
	
	
	/* article delete 시작 */
	// 게시물 삭제
	void delete(int id);
	/* article delete 끝 */
	

	/* article modify 시작 */
	// 게시물 수정
	void modify(int id, String title, String body);
	/* article modify 끝 */

	
}
