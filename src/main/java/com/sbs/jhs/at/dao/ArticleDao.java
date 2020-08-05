package com.sbs.jhs.at.dao;

import java.util.List;

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

	void writeReply(int articleId, String body);

	int getForPrintListArticleRepliesCount(int id);

	List<ArticleReply> getForPrintArticleReply(int id, int limitFrom, int itemsInAPage);

	void replyDelete(int articleId, int articleReplyId);

	
}
