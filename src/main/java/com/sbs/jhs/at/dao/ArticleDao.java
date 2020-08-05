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

	void write(String title, String body);

	void delete(int id);

	int getForPrintListArticlesCount();

	void modify(int id, String title, String body);

	List<Article> getForPrintSearchArticle(int limitFrom, int itemsInAPage, String searchKeywordType, String searchKeyword);

	int getForPrintListSearchArticlesCount(String searchKeywordType, String searchKeyword);

	void writeArticleReply(Map<String, Object> param);

	int getForPrintListArticleRepliesCount(int id);

	List<ArticleReply> getForPrintArticleReplies(int id, int limitFrom, int itemsInAPage);

	void replyDelete(int articleId, int articleReplyId);

	ArticleReply getForPrintArticleReply(int articleId, int articleReplyId);

	void replyModify(int articleId, int articleReplyId, String body);
	
}
