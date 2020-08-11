package com.sbs.jhs.at.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.jhs.at.dto.Article;
import com.sbs.jhs.at.dto.Reply;

@Mapper
public interface ArticleDao {
	/* article list 시작 */
	// 게시물 리스트
	List<Article> getForPrintArticles(int limitFrom, int itemsInAPage);
	
	// 검색된 게시물 리스트
	List<Article> getForPrintSearchArticle(int limitFrom, int itemsInAPage, String searchKeywordType, String searchKeyword);
	
	// 검색된 게시물 수 출력
	int getForPrintListSearchArticlesCount(String searchKeywordType, String searchKeyword);
	
	//게시물 수 출력
	int getForPrintListArticlesCount();
	/* article list 끝 */
	
	
	/* article detail 시작 */
	// 게시물 상세보기
	Article getForPrintArticle(@Param("id") int id);
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
	

	

	void writeArticleReply(Map<String, Object> param);

	int getForPrintListArticleRepliesCount(int id);

	List<Reply> getForPrintArticleRepliesFrom(@Param("articleId") int articleId, @Param("from") int from);

	Reply getForPrintArticleReply(int articleId, int articleReplyId);

	void replyModify(int articleId, int articleReplyId, String body);

	Reply getArticleReply(@Param("id") int id);

	void deleteArticleReply(@Param("id") int id);

	void modifyArticleReply(Map<String, Object> param);
	
}
