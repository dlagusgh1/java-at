package com.sbs.jhs.at.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.jhs.at.dto.Article;

@Mapper
public interface ArticleDao {
	List<Article> getForPrintArticles(int limitFrom, int itemsInAPage);
	
	Article getOne(@Param("id") int id);

	void write(String title, String body);

	void delete(int id);

	int getForPrintListArticlesCount();

	void modify(int id, String title, String body);
}
