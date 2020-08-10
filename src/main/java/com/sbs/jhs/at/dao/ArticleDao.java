package com.sbs.jhs.at.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.jhs.at.dto.Article;
import com.sbs.jhs.at.dto.ArticleReply;

@Mapper
public interface ArticleDao {
	List<Article> getForPrintArticles(int limitFrom, int itemsInAPage);
	
	Article getForPrintArticle(@Param("id") int id);

	void write(Map<String, Object> param);

	void delete(int id);

	int getForPrintListArticlesCount();

	void modify(int id, String title, String body);

	List<Article> getForPrintSearchArticle(int limitFrom, int itemsInAPage, String searchKeywordType, String searchKeyword);

	int getForPrintListSearchArticlesCount(String searchKeywordType, String searchKeyword);

	void writeArticleReply(Map<String, Object> param);

	int getForPrintListArticleRepliesCount(int id);

	List<ArticleReply> getForPrintArticleRepliesFrom(@Param("articleId") int articleId, @Param("from") int from);

	ArticleReply getForPrintArticleReply(int articleId, int articleReplyId);

	void replyModify(int articleId, int articleReplyId, String body);

	ArticleReply getArticleReply(@Param("id") int id);

	void deleteArticleReply(@Param("id") int id);

	void modifyArticleReply(Map<String, Object> param);
	
}
